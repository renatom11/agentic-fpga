(* See injection.mli for the contract, the spec citations and the standing note
   that this model is cross-checked against AP-xgmii_rx_64.md's hand-derived
   rows and is NOT yet externally anchored. *)

type placement =
  | At_preamble of int
  | At_octet of int
  | At_terminate

type corruption =
  | Flip_bit of
      { octet : int
      ; bit : int
      }
  | Place of
      { placement : placement
      ; character : int
      }

type frame_case =
  { octets : int list
  ; corruptions : corruption list
  }

let clean octets = { octets; corruptions = [] }
let corrupt octets corruptions = { octets; corruptions }

let frame_of_length ?(sequence = 0) n =
  if n >= 18
  then (
    (* Frame.stress_frame is 64 octets; longer and shorter frames keep its
       header and filler convention so a delivered-octet comparison reads the
       same way at every length (SPEC-M03 §8's "any fixed pattern, stated by
       the bench and constant across the run"). *)
    let header =
      [ 0x02; 0x00; 0x00; 0x00; 0x00; 0x01; 0x02; 0x00; 0x00; 0x00; 0x00; 0x02; 0x08; 0x00 ]
      @ [ (sequence lsr 24) land 0xff
        ; (sequence lsr 16) land 0xff
        ; (sequence lsr 8) land 0xff
        ; sequence land 0xff
        ]
    in
    let body = List.init (n - 4 - 18) (fun k -> (k + 18) land 0xff) in
    Frame.with_fcs (header @ body))
  else if n >= 5
  then Frame.with_fcs (List.init (n - 4) (fun k -> k land 0xff))
  else List.init n (fun k -> (0xF0 + k) land 0xff)
;;

(* ---------------------------------------------------------------------- *)
(* Building the octet-time line                                            *)
(* ---------------------------------------------------------------------- *)

type t =
  { schedule : Arrival.t
  ; overrides : (int, Xgmii_word.lane) Hashtbl.t (* octet time -> lane *)
  ; rev_errors : string list
  }

let is_control_char c =
  c = Xgmii_word.start_char
  || c = Xgmii_word.terminate_char
  || c = Xgmii_word.error_char
  || c = Xgmii_word.idle_char
  || c = Xgmii_word.sequence_char
;;

let apply_bit_flips (case : frame_case) =
  List.fold_left
    (fun octets c ->
      match c with
      | Flip_bit { octet; bit } ->
        List.mapi
          (fun k o -> if k = octet then (o lxor (1 lsl bit)) land 0xff else o)
          octets
      | Place _ -> octets)
    case.octets
    case.corruptions
;;

let create ?(ifg = 12) ?(first_start = 8) ?(first_lane = 0) cases =
  let problems = ref [] in
  let add fmt = Printf.ksprintf (fun s -> problems := s :: !problems) fmt in
  List.iteri
    (fun i (case : frame_case) ->
      List.iter
        (fun c ->
          match c with
          | Flip_bit { octet; bit } ->
            if octet < 0 || octet >= List.length case.octets
            then
              add "frame %d: Flip_bit octet %d is off the end of a %d-octet frame" i octet
                (List.length case.octets);
            if bit < 0 || bit > 7 then add "frame %d: Flip_bit bit %d is not 0 … 7" i bit
          | Place { placement; character } ->
            if not (is_control_char character)
            then
              add
                "frame %d: Place character 0x%02X is not one of requirements.md §2's five"
                i
                character;
            (match placement with
             | At_preamble p ->
               if p < 1 || p > 7
               then
                 add
                   "frame %d: At_preamble %d is outside 1 … 7; position 0 is the start \
                    character itself (REQ-102)"
                   i
                   p
             | At_octet k ->
               if k < 0 || k >= List.length case.octets
               then
                 add "frame %d: At_octet %d is off the end of a %d-octet frame" i k
                   (List.length case.octets);
               if character = Xgmii_word.idle_char || character = Xgmii_word.sequence_char
               then
                 add
                   "frame %d: an /I/ or /Q/ in a single lane of an OPEN frame is outside \
                    this specification's space — §6.2's Frame row leaves to Idle only on \
                    /T/, /E/ and /S/, and §6.1's hold clause is about a word covering no \
                    frame octet, not a lane. Refused rather than modelled"
                   i
             | At_terminate -> ()))
        case.corruptions)
    cases;
  let frame_octets = List.map apply_bit_flips cases in
  let first_start =
    (* first_lane selects the alignment of frame 0; §0.3 requires a multiple of
       4 and REQ-101 admits lane 0 and lane 4 only. *)
    if first_lane = 4 then first_start + 4 else first_start
  in
  if first_lane <> 0 && first_lane <> 4
  then add "first_lane %d: REQ-101 admits lane 0 and lane 4 only" first_lane;
  let schedule = Arrival.create ~ifg ~first_start ~fcs_valid:false frame_octets in
  (* [Arrival.check]'s sub-five-octet complaint says in terms that such a frame
     "is an injection case, not a schedule case" — and this IS the injection
     case, REQ-107's fewer-than-five-octet runt, rows F2 and F5. It is filtered
     out here and nowhere else; every other contract violation is propagated. *)
  let contains haystack needle =
    let n = String.length needle and h = String.length haystack in
    let rec go i = i + n <= h && (String.sub haystack i n = needle || go (i + 1)) in
    n = 0 || go 0
  in
  List.iter
    (fun p ->
      if not (contains p "is an injection case, not a schedule case")
      then add "schedule: %s" p)
    (Arrival.check schedule);
  let overrides = Hashtbl.create 64 in
  Array.iteri
    (fun i (f : Arrival.frame) ->
      let case = List.nth cases i in
      List.iter
        (fun c ->
          match c with
          | Flip_bit _ -> ()
          | Place { placement; character } ->
            let octet_time =
              match placement with
              | At_preamble p -> f.Arrival.start_octet_time + p
              | At_octet k -> f.Arrival.start_octet_time + 8 + k
              | At_terminate -> Arrival.terminate_octet_time f
            in
            if character = Xgmii_word.start_char && octet_time mod 8 <> 0
               && octet_time mod 8 <> 4
            then
              add
                "frame %d: a /S/ at octet time %d would land in lane %d; SPEC-M03 §6.3 \
                 item 3 leaves that stimulus unconstrained BECAUSE the link-partner \
                 contract never produces it (REQ-101, requirements.md §0.3)"
                i
                octet_time
                (octet_time mod 8)
            else Hashtbl.replace overrides octet_time (Xgmii_word.Control character))
        case.corruptions)
    (Arrival.frames schedule);
  { schedule; overrides; rev_errors = List.rev !problems }
;;

let schedule t = t.schedule
let errors t = t.rev_errors

let is_clean t =
  match t.rev_errors with
  | [] -> true
  | _ :: _ -> false
;;

let lane_at t octet_time =
  match Hashtbl.find_opt t.overrides octet_time with
  | Some lane -> lane
  | None ->
    (* Arrival has no per-octet accessor, so the word it would emit is read and
       the lane picked out. One call per octet time, which is fine at the
       directed lengths this catalogue drives and is not how the 10 000-frame
       stress run is driven (that one has no injection at all — §8: "error
       injection rate: zero in this run"). *)
    Xgmii_word.lane (Arrival.word_at t.schedule ~cycle:(octet_time / 8)) (octet_time mod 8)
;;

let word_at t ~cycle =
  Xgmii_word.of_lanes (List.init 8 (fun k -> lane_at t ((8 * cycle) + k)))
;;

let cycles t = Arrival.cycles t.schedule

(* ---------------------------------------------------------------------- *)
(* The reference evaluation of SPEC-M03 §6.2 and §9                        *)
(* ---------------------------------------------------------------------- *)

type report =
  { strobe : string
  ; cycle : int
  ; not_before : int
  ; not_after : int
  }

type outcome =
  { frame : int
  ; start_cycle : int
  ; start_lane : int
  ; received : int
  ; delivered : int
  ; words : int
  ; last_tkeep : int
  ; tlast_cycle : int option
  ; abort : bool
  ; reports : report list
  ; note : string
  }

type open_frame =
  { index : int
  ; start_ot : int
  ; mutable rev_octets : int list (* received frame octets, newest first *)
  }

(* §7's per-octet constant, applied rather than quoted: an output octet leaves
   L octet times after it arrived, L = 16 at a lane-0 start and 12 at a lane-4
   one, and the frame's octet j arrives at start_ot + 8 + j. Both give
   tlast cycle = start_cycle + 3 + (words - 1); the arithmetic is written out
   so the two start lanes are visibly the same answer and not an assumption.
   This is the route dv_lead re-derived §6.1's consequence-1 table by at
   WO-0031, and it is gap-invariant where §6.1's m + 3 is not. *)
let tlast_cycle_of ~start_ot ~start_lane ~delivered =
  if delivered <= 0
  then None
  else (
    let l = if start_lane = 0 then 16 else 12 in
    let last_in = start_ot + 8 + (delivered - 1) in
    Some ((last_in + l) / 8))
;;

let tkeep_of delivered =
  if delivered <= 0
  then 0
  else if delivered mod 8 = 0
  then 0xFF
  else (1 lsl (delivered mod 8)) - 1
;;

(* §9's second pinning rule: a frame that produces no output word pulses two
   cycles after the input word carrying the character that ended it, at both
   start lanes. Not a corollary of m + 3 — see §9's withdrawn gloss, M03-R2. *)
let no_output_cycle ~closing_ot = (closing_ot / 8) + 2

(* requirements.md §0.6's window, computed beside the pin so that
   [Dv_monitors.Strobe_monitor] can check the SPECIFICATION's own arithmetic
   before it checks a design's (X-3 check (c)):
   - not earlier than the cycle the condition first becomes decidable from the
     module's inputs — the word carrying the character that closed the frame,
     or the word whose octet took the received count past 1518;
   - not later than the module's latency in cycles (ΔC = 3, §7) after the input
     word carrying the last octet of the offending frame. A frame that received
     no octet has no such octet, and its closing character's word stands in. *)
let window ~start_ot ~received ~closing_ot =
  let last_octet_ot =
    if received > 0 then start_ot + 8 + (received - 1) else closing_ot
  in
  closing_ot / 8, (last_octet_ot / 8) + 3
;;

let outcomes t =
  let results = ref [] in
  let next_index = ref 0 in
  let current = ref None in
  let emit ~(f : open_frame) ~received ~delivered ~strobes ~note ~closing_ot =
    let start_lane = f.start_ot mod 8 in
    let tlast = tlast_cycle_of ~start_ot:f.start_ot ~start_lane ~delivered in
    let cycle =
      match tlast with
      | Some c -> c
      | None -> no_output_cycle ~closing_ot
    in
    let not_before, not_after = window ~start_ot:f.start_ot ~received ~closing_ot in
    let reports =
      List.map (fun strobe -> { strobe; cycle; not_before; not_after }) strobes
    in
    results
      := { frame = f.index
         ; start_cycle = f.start_ot / 8
         ; start_lane
         ; received
         ; delivered
         ; words = (delivered + 7) / 8
         ; last_tkeep = tkeep_of delivered
         ; tlast_cycle = tlast
         ; abort = delivered > 0 && strobes <> []
         ; reports
         ; note
         }
         :: !results
  in
  let open_at ot =
    let f = { index = !next_index; start_ot = ot; rev_octets = [] } in
    incr next_index;
    current := Some f
  in
  let close_zero ~f ~strobe ~note ~closing_ot =
    emit ~f ~received:(List.length f.rev_octets) ~delivered:0 ~strobes:[ strobe ] ~note
      ~closing_ot;
    current := None
  in
  let n = 8 * cycles t in
  for ot = 0 to n - 1 do
    let lane = lane_at t ot in
    let is_start =
      match lane with
      | Xgmii_word.Control c -> c = Xgmii_word.start_char && (ot mod 8 = 0 || ot mod 8 = 4)
      | Xgmii_word.Data _ -> false
    in
    match !current with
    | None ->
      (* §6.2's Idle and Discard rows are indistinguishable in the report model:
         in both, no frame is open, a /T/ closes nothing, an /E/ is absorbed
         (C-12) and only a /S/ starts a frame. Keeping one state here is not a
         simplification of the specification — it is the observation that the
         two differ only in what the datapath does with octets neither of them
         emits, which §6.3 item 6 leaves unconstrained. *)
      if is_start then open_at ot
    | Some f ->
      let d = ot - f.start_ot in
      if d > 0 && d < 8
      then (
        (* Preamble. REQ-102's third sentence routes every control character
           here: /T/ to REQ-107, /S/ to REQ-110, anything else to REQ-105. *)
        match lane with
        | Xgmii_word.Data _ -> ()
        | Xgmii_word.Control c when c = Xgmii_word.terminate_char ->
          close_zero ~f ~strobe:"error_runt"
            ~note:"§9 row 6: fewer than 5 octets between start and terminate, no output"
            ~closing_ot:ot
        | Xgmii_word.Control c when c = Xgmii_word.start_char && is_start ->
          close_zero ~f ~strobe:"error_start_without_terminate"
            ~note:"§9 row 9: /S/ while the aborted frame is still inside its own preamble"
            ~closing_ot:ot;
          open_at ot
        | Xgmii_word.Control _ ->
          close_zero ~f ~strobe:"error_bad_frame"
            ~note:
              "§9 row 3: a control character in a preamble position, at or before the \
               frame's first octet (REQ-102's third sentence, REQ-105)"
            ~closing_ot:ot)
      else if d >= 8
      then (
        let received () = List.length f.rev_octets in
        match lane with
        | Xgmii_word.Data octet ->
          f.rev_octets <- octet :: f.rev_octets;
          if received () > 1518
          then (
            (* REQ-108: truncated to exactly 1514 delivered octets, the
               remainder discarded until /T/ or /S/. *)
            emit ~f ~received:(received ()) ~delivered:1514
              ~strobes:[ "error_oversize" ]
              ~note:"§9 row 7: more than 1518 octets between start and terminate"
              ~closing_ot:ot;
            (* [current := None] IS the transition to §6.2's `Discard`: with no
               frame open, a /T/ closes nothing, an /E/ is absorbed (C-12) and
               only a /S/ starts a frame, which is that row exactly. This arm
               once also set a separate [discarding] flag; the flag was removed
               at WO-0033 when the two states were shown indistinguishable in
               the report model, and this line's write to it was missed —
               J-dv_lead-0018. *)
            current := None)
        | Xgmii_word.Control c when c = Xgmii_word.terminate_char ->
          let r = received () in
          if r < 5
          then
            close_zero ~f ~strobe:"error_runt"
              ~note:"§9 row 6: fewer than 5 octets between start and terminate, no output"
              ~closing_ot:ot
          else (
            let octets = List.rev f.rev_octets in
            let delivered = r - 4 in
            let fcs_bad = not (Frame.residue_ok octets) in
            let strobes =
              (if r <= 63 then [ "error_runt" ] else [])
              @ if fcs_bad then [ "error_bad_fcs" ] else []
            in
            emit ~f ~received:r ~delivered ~strobes
              ~note:
                (if r <= 63
                 then "§9 row 5: 5 to 63 octets — forwarded, runt (and REQ-304 checked)"
                 else "§9 row 1: normal close, FCS by REQ-304 residue")
              ~closing_ot:ot;
            current := None)
        | Xgmii_word.Control c when c = Xgmii_word.start_char && is_start ->
          let r = received () in
          if r = 0
          then
            close_zero ~f ~strobe:"error_start_without_terminate"
              ~note:"§9 row 9: /S/ at or before the aborted frame's first octet"
              ~closing_ot:ot
          else (
            emit ~f ~received:r ~delivered:r
              ~strobes:[ "error_start_without_terminate" ]
              ~note:
                "§9 row 8: /S/ before the current frame's /T/ with ≥ 1 octet delivered — \
                 truncated at the octet before it, NO FCS removed (REQ-103)"
              ~closing_ot:ot;
            current := None);
          open_at ot
        | Xgmii_word.Control c when c = Xgmii_word.error_char ->
          let r = received () in
          if r = 0
          then
            close_zero ~f ~strobe:"error_bad_frame"
              ~note:"§9 row 3: /E/ at or before the frame's first octet, no output word"
              ~closing_ot:ot
          else (
            emit ~f ~received:r ~delivered:r ~strobes:[ "error_bad_frame" ]
              ~note:
                "§9 row 2: /E/ while the frame is open with ≥ 1 octet delivered — \
                 truncated, NO FCS removed"
              ~closing_ot:ot;
            current := None)
        | Xgmii_word.Control _ ->
          (* /I/ or /Q/ in a lane of an open frame: refused at [create], so this
             is unreachable on a constructed catalogue and is left explicit
             rather than silently ignored. *)
          ())
  done;
  List.rev !results
;;

(* §12's order, so a report list reads the same way as the status record
   (REQ-804). Computed from Strobes.all rather than restated: §12 is normative
   and a second ordered copy is a second thing to drift. *)
let strobe_order name =
  let rec go i = function
    | [] -> max_int
    | s :: rest -> if s = name then i else go (i + 1) rest
  in
  go 0 Dv_monitors.Strobes.all
;;

let expected_strobes t =
  List.concat_map
    (fun o ->
      List.map
        (fun r ->
          { Dv_monitors.Strobe_monitor.strobe = r.strobe
          ; frame = o.frame
          ; cycle = r.cycle
          ; not_before = r.not_before
          ; not_after = r.not_after
          ; why = o.note
          })
        (List.sort
           (fun a b -> compare (strobe_order a.strobe) (strobe_order b.strobe))
           o.reports))
    (outcomes t)
;;

let report t =
  let line o =
    Printf.sprintf
      "  frame %d lane %d start@%d: received=%d delivered=%d words=%d tkeep=0x%02X \
       tlast=%s abort=%b [%s] %s"
      o.frame
      o.start_lane
      o.start_cycle
      o.received
      o.delivered
      o.words
      o.last_tkeep
      (match o.tlast_cycle with
       | None -> "none"
       | Some c -> string_of_int c)
      o.abort
      (String.concat "; "
         (List.map (fun r -> Printf.sprintf "%s@%d" r.strobe r.cycle) o.reports))
      o.note
  in
  let os = outcomes t in
  let header =
    Printf.sprintf
      "[injection] frames opened=%d cycles=%d"
      (List.length os)
      (cycles t)
  in
  let problems =
    match t.rev_errors with
    | [] -> [ "  construction: CLEAN" ]
    | es -> List.map (fun e -> "  ERROR: " ^ e) es
  in
  String.concat "\n" ((header :: List.map line os) @ problems)
;;
