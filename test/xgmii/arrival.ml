(* See arrival.mli for the contract, the §0.3 arithmetic and the spec
   citations. *)

type frame =
  { index : int
  ; start_octet_time : int
  ; start_lane : int
  ; octets : int array
  }

type t =
  { frames : frame array
  ; ifg : int
  ; fcs_valid : bool
  }

let preamble_octets = 8 (* REQ-102: eight octets from the start character inclusive *)
let fcs_octets = 4 (* REQ-103 *)
let dic_floor = 9 (* requirements.md §0.3: a shortened gap is never below 9 *)
let round_up_4 x = (x + 3) / 4 * 4
let start_cycle f = f.start_octet_time / 8
let terminate_octet_time f = f.start_octet_time + preamble_octets + Array.length f.octets

let in_times f =
  Array.init (preamble_octets + Array.length f.octets) (fun k -> f.start_octet_time + k)
;;

let delivered f = Array.sub f.octets 0 (Array.length f.octets - fcs_octets)

let create ?(ifg = 12) ?(first_start = 8) ?(fcs_valid = true) frame_octets =
  if first_start mod 4 <> 0
  then
    invalid_arg
      "Arrival.create: a start character may occupy only lane 0 or lane 4 \
       (requirements.md §0.3), so the first start octet time must be a multiple of 4";
  let floor_gap = min ifg dic_floor in
  (* An explicit fold rather than [List.mapi] over a mutable cursor: the
     stdlib leaves [map]'s evaluation order unspecified, and a schedule whose
     octet times depend on that order would be a bench that reproduces
     differently on a different runtime. *)
  let rec lay_out index start credit acc = function
    | [] -> List.rev acc
    | octets :: rest ->
      let frame =
        { index
        ; start_octet_time = start
        ; start_lane = start mod 8
        ; octets = Array.of_list octets
        }
      in
      (* §0.3: the gap is counted from the terminate character inclusive, is at
         least [ifg], is rounded up so the next start lands on lane 0 or lane 4,
         and — the link partner being DIC-capable — may spend banked rounding
         credit to shorten a later gap, never below 9. *)
      let terminate = terminate_octet_time frame in
      let shorten = min credit (ifg - floor_gap) in
      let target = terminate + ifg - shorten in
      let next = round_up_4 target in
      lay_out (index + 1) next (credit - shorten + (next - target)) (frame :: acc) rest
  in
  { frames = Array.of_list (lay_out 0 first_start 0 [] frame_octets); ifg; fcs_valid }
;;

let stress ?(count = 10_000) ?filler () =
  create
    (List.init count (fun i -> Frame.stress_frame ?filler ~sequence:i ()))
;;

let frames t = t.frames
let ifg t = t.ifg

(* Index of the last frame whose start character is at or before [octet_time],
   or -1. The emitter is a total function of octet time with no state of its
   own, so a bench may sample any cycle in any order — including re-reading a
   cycle it has already driven, which a step-testbench does. *)
let frame_index_at t octet_time =
  let lo = ref 0 in
  let hi = ref (Array.length t.frames - 1) in
  let found = ref (-1) in
  while !lo <= !hi do
    let mid = (!lo + !hi) / 2 in
    if t.frames.(mid).start_octet_time <= octet_time
    then (
      found := mid;
      lo := mid + 1)
    else hi := mid - 1
  done;
  !found
;;

let lane_at t octet_time =
  let i = frame_index_at t octet_time in
  if i < 0
  then Xgmii_word.Control Xgmii_word.idle_char
  else (
    let f = t.frames.(i) in
    let d = octet_time - f.start_octet_time in
    let n = Array.length f.octets in
    if d = 0
    then Xgmii_word.Control Xgmii_word.start_char
    else if d < preamble_octets
    then
      (* SPEC-M03 §6.1's cycle table: six 0x55 then the 0xD5 SFD. REQ-102
         forbids the receiver from validating these values, so no bench may
         assert on them; they are written correctly because a link partner
         that is wrong for no reason is a bench that fails for no reason. *)
      Xgmii_word.Data (if d = preamble_octets - 1 then 0xD5 else 0x55)
    else if d < preamble_octets + n
    then Xgmii_word.Data f.octets.(d - preamble_octets)
    else if d = preamble_octets + n
    then Xgmii_word.Control Xgmii_word.terminate_char
    else Xgmii_word.Control Xgmii_word.idle_char)
;;

let word_at t ~cycle =
  Xgmii_word.of_lanes (List.init 8 (fun k -> lane_at t ((8 * cycle) + k)))
;;

let cycles t =
  let n = Array.length t.frames in
  if n = 0
  then 0
  else (
    let last = t.frames.(n - 1) in
    (* through the gap that follows the last terminate character *)
    ((terminate_octet_time last + t.ifg + 7) / 8) + 1)
;;

let words t = List.init (cycles t) (fun cycle -> cycle, word_at t ~cycle)
let start_lanes t = Array.to_list (Array.map (fun f -> f.start_lane) t.frames)
let start_cycles t = Array.to_list (Array.map start_cycle t.frames)

let rec spacings = function
  | a :: (b :: _ as rest) -> (b - a) :: spacings rest
  | [] | [ _ ] -> []
;;

let start_spacings t = spacings (start_cycles t)

let gaps t =
  let n = Array.length t.frames in
  List.init
    (max 0 (n - 1))
    (fun i -> t.frames.(i + 1).start_octet_time - terminate_octet_time t.frames.(i))
;;

let check t =
  let problems = ref [] in
  let add fmt = Printf.ksprintf (fun s -> problems := s :: !problems) fmt in
  let floor_gap = min t.ifg dic_floor in
  Array.iter
    (fun f ->
      if f.start_lane <> 0 && f.start_lane <> 4
      then
        add
          "frame %d starts in lane %d; requirements.md §0.3 and REQ-101 admit lane 0 and \
           lane 4 only"
          f.index
          f.start_lane;
      if Array.length f.octets < 5
      then
        add
          "frame %d carries %d octets; a frame below five octets delivers nothing \
           (REQ-107) and is an injection case, not a schedule case"
          f.index
          (Array.length f.octets);
      if t.fcs_valid && not (Frame.residue_ok (Array.to_list f.octets))
      then
        add
          "frame %d does not satisfy REQ-304's residue: this schedule declares every \
           frame valid, and a frame the model believes valid must be provably valid \
           before a design ever sees it"
          f.index)
    t.frames;
  List.iteri
    (fun i gap ->
      if gap < floor_gap
      then
        add
          "the gap after frame %d is %d octets, below the %d-octet floor a DIC-capable \
           partner may never cross (requirements.md §0.3)"
          i
          gap
          floor_gap)
    (gaps t);
  (* The DIC invariant: banked rounding credit may shorten later gaps, so the
     running total never falls more than the outstanding credit (at most 3
     octets, one lane quantum less than the 4-octet rounding) below k × ifg. *)
  let running = ref 0 in
  List.iteri
    (fun i gap ->
      running := !running + gap;
      let k = i + 1 in
      if !running < (k * t.ifg) - 3
      then
        add
          "after %d gap(s) the cumulative gap is %d octets, below %d × %d − 3: the \
           average has fallen under the minimum §0.3 requires"
          k
          !running
          k
          t.ifg)
    (gaps t);
  for i = 1 to Array.length t.frames - 1 do
    if t.frames.(i).start_octet_time <= terminate_octet_time t.frames.(i - 1)
    then
      add
        "frame %d starts at octet time %d, at or before frame %d's terminate character \
         at %d — the schedule overlaps"
        i
        t.frames.(i).start_octet_time
        (i - 1)
        (terminate_octet_time t.frames.(i - 1))
  done;
  List.rev !problems
;;

let is_clean t =
  match check t with
  | [] -> true
  | _ :: _ -> false
;;

let report t =
  let show label values =
    let n = List.length values in
    let rec take k = function
      | [] -> []
      | x :: rest -> if k = 0 then [] else x :: take (k - 1) rest
    in
    Printf.sprintf
      "  %s: %s%s"
      label
      (String.concat " " (List.map string_of_int (take 12 values)))
      (if n > 12 then Printf.sprintf " ... (%d entries)" n else "")
  in
  let lengths = Array.to_list (Array.map (fun f -> Array.length f.octets) t.frames) in
  let distinct_lengths = List.sort_uniq compare lengths in
  let header =
    Printf.sprintf
      "[xgmii link partner] frames=%d ifg=%d cycles=%d frame octets(DA..FCS)=%s"
      (Array.length t.frames)
      t.ifg
      (cycles t)
      (String.concat "," (List.map string_of_int distinct_lengths))
  in
  let rows =
    [ show "start lanes" (start_lanes t)
    ; show "start cycles" (start_cycles t)
    ; show "start-to-start cycles" (start_spacings t)
    ; show "gaps (octets, terminate inclusive)" (gaps t)
    ]
  in
  let problems =
    match check t with
    | [] -> [ "  contract: CLEAN (requirements.md §0.3, REQ-004, REQ-101)" ]
    | ps -> List.map (fun p -> "  VIOLATION: " ^ p) ps
  in
  String.concat "\n" ((header :: rows) @ problems)
;;
