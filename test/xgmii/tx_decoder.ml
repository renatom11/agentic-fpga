(* See tx_decoder.mli for the contract and the spec citations. *)

type frame =
  { start_cycle : int
  ; terminate_cycle : int
  ; terminate_lane : int
  ; octets : int list
  ; underflowed : bool
  }

type violation =
  { cycle : int
  ; req : string
  ; detail : string
  }

(* [Gap None] is the state before any terminate character has been seen:
   SPEC-M04 §6.3 item 4 says REQ-204 has no instance for the first frame, so
   the gap obligation is not asserted there. [Gap (Some n)] counts octets from
   the terminate character inclusive (requirements.md §0.3). *)
type state =
  | Gap of int option
  | Preamble of int (** the next expected preamble position, 1 … 7 *)
  | In_frame

type t =
  { name : string
  ; ifg : int
  ; mutable state : state
  ; mutable rev_octets : int list
  ; mutable frame_start_cycle : int
  ; mutable underflowed : bool
  ; mutable expect_terminate : bool (** the lane after §9's [/E/] must be [/T/] *)
  ; mutable rev_frames : frame list
  ; mutable rev_violations : violation list
  ; mutable rev_gaps : int list
  }

let create ~name ?(ifg = 12) () =
  { name
  ; ifg
  ; state = Gap None
  ; rev_octets = []
  ; frame_start_cycle = -1
  ; underflowed = false
  ; expect_terminate = false
  ; rev_frames = []
  ; rev_violations = []
  ; rev_gaps = []
  }
;;

let violate t ~cycle ~req fmt =
  Printf.ksprintf
    (fun detail -> t.rev_violations <- { cycle; req; detail } :: t.rev_violations)
    fmt
;;

let close_frame t ~cycle ~lane =
  let octets = List.rev t.rev_octets in
  let n = List.length octets in
  if t.underflowed
  then
    (* SPEC-M04 §9: no FCS is appended to an underflowed frame, deliberately —
       the /E/ before the terminate character is what makes the truncation
       visible. Asserting REQ-202 or REQ-203 here would be demanding the
       well-formed short frame that clause exists to prevent. *)
    ()
  else if n < 64
  then
    violate
      t
      ~cycle
      ~req:"REQ-203"
      "frame of %d octets DA through FCS: REQ-203 pads to 60 octets before the four FCS \
       octets, so no transmitted frame is shorter than 64"
      n
  else (
    let payload = List.filteri (fun i _ -> i < n - 4) octets in
    let wire_fcs = List.filteri (fun i _ -> i >= n - 4) octets in
    let expected = Frame.fcs payload in
    let hex os = String.concat " " (List.map (Printf.sprintf "%02X") os) in
    if wire_fcs <> expected
    then
      violate
        t
        ~cycle
        ~req:"REQ-202"
        "FCS on the wire is [%s]; the REQ-305 bit-serial reference over the %d preceding \
         octets gives [%s], least significant octet first"
        (hex wire_fcs)
        (List.length payload)
        (hex expected)
    else if not (Frame.residue_ok octets)
    then
      violate
        t
        ~cycle
        ~req:"REQ-304"
        "the FCS octets match the reference but the residue over the whole frame is not \
         0x2144DF1C — the two cannot disagree, so this is a defect in the DV machinery, \
         not in a design");
  t.rev_frames
  <- { start_cycle = t.frame_start_cycle
     ; terminate_cycle = cycle
     ; terminate_lane = lane
     ; octets
     ; underflowed = t.underflowed
     }
     :: t.rev_frames;
  t.rev_octets <- [];
  t.underflowed <- false;
  t.expect_terminate <- false;
  (* §0.3: the terminate character occupies the first octet position of the
     gap, so the count starts at one on this lane. *)
  t.state <- Gap (Some 1)
;;

let observe_lane t ~cycle ~lane_index l =
  match t.state, l with
  (* ------------------------------------------------------------- in a gap *)
  | Gap since, Xgmii_word.Control c when c = Xgmii_word.start_char ->
    if lane_index <> 0
    then
      violate
        t
        ~cycle
        ~req:"REQ-201"
        "start character in lane %d; Phase 1 places every start character in lane 0 \
         (SPEC-M04 §6.1, requirements.md §0.3)"
        lane_index;
    (match since with
     | None -> () (* SPEC-M04 §6.3 item 4: the first frame owes no gap *)
     | Some n ->
       t.rev_gaps <- n :: t.rev_gaps;
       if n < t.ifg
       then
         violate
           t
           ~cycle
           ~req:"REQ-204"
           "gap of %d octets counted from the terminate character inclusive, below the \
            %d cfg_ifg requires; gaps are only ever rounded up (requirements.md §0.3, \
            §11)"
           n
           t.ifg);
    t.frame_start_cycle <- cycle;
    t.rev_octets <- [];
    t.underflowed <- false;
    t.expect_terminate <- false;
    t.state <- Preamble 1
  | Gap since, Xgmii_word.Control c when c = Xgmii_word.idle_char ->
    t.state <- Gap (match since with None -> None | Some n -> Some (n + 1))
  | Gap since, other ->
    violate
      t
      ~cycle
      ~req:"REQ-205"
      "lane %d carries %s between frames; every remaining lane of the terminate word and \
       every lane of every gap word carries an idle character"
      lane_index
      (match other with
       | Xgmii_word.Data d -> Printf.sprintf "data 0x%02X" d
       | Xgmii_word.Control c -> Printf.sprintf "control 0x%02X" c);
    t.state <- Gap (match since with None -> None | Some n -> Some (n + 1))
  (* ---------------------------------------------------------- the preamble *)
  | Preamble position, l ->
    (match l with
     | Xgmii_word.Data d ->
       let expected = if position = 7 then 0xD5 else 0x55 in
       if d <> expected
       then
         violate
           t
           ~cycle
           ~req:"REQ-201"
           "preamble octet %d is 0x%02X; SPEC-M04 §6.1 emits six 0x55 octets then the \
            0xD5 SFD after the start character"
           position
           d
     | Xgmii_word.Control c ->
       violate
         t
         ~cycle
         ~req:"REQ-201"
         "preamble position %d carries control character 0x%02X; the preamble is one \
          word of data octets after the start character"
         position
         c);
    t.state <- (if position = 7 then In_frame else Preamble (position + 1))
  (* ------------------------------------------------------------ in a frame *)
  | In_frame, Xgmii_word.Data d ->
    if t.expect_terminate
    then (
      violate
        t
        ~cycle
        ~req:"REQ-206"
        "lane %d carries data 0x%02X after the error character; SPEC-M04 §9's underflow \
         word is /E/ in lane 0 and /T/ in lane 1"
        lane_index
        d;
      t.expect_terminate <- false);
    t.rev_octets <- d :: t.rev_octets
  | In_frame, Xgmii_word.Control c when c = Xgmii_word.terminate_char ->
    close_frame t ~cycle ~lane:lane_index
  | In_frame, Xgmii_word.Control c when c = Xgmii_word.error_char ->
    if lane_index <> 0
    then
      violate
        t
        ~cycle
        ~req:"REQ-206"
        "error character in lane %d; SPEC-M04 §9's underflow word carries /E/ in lane 0 \
         and /T/ in lane 1"
        lane_index;
    t.underflowed <- true;
    t.expect_terminate <- true
  | In_frame, Xgmii_word.Control c when c = Xgmii_word.start_char ->
    violate
      t
      ~cycle
      ~req:"REQ-201"
      "start character in lane %d while a frame is in progress; M04 emits one frame at a \
       time and its gap is served before the next start character"
      lane_index;
    t.rev_octets <- [];
    t.underflowed <- false;
    t.frame_start_cycle <- cycle;
    t.state <- Preamble 1
  | In_frame, Xgmii_word.Control c ->
    violate
      t
      ~cycle
      ~req:"REQ-205"
      "lane %d carries control character 0x%02X inside a frame; only the terminate \
       character and §9's error character end a transmitted frame"
      lane_index
      c
;;

let observe t ~cycle word =
  for k = 0 to 7 do
    observe_lane t ~cycle ~lane_index:k (Xgmii_word.lane word k)
  done
;;

let observe_all t words = List.iter (fun (cycle, word) -> observe t ~cycle word) words
let name t = t.name
let frames t = List.rev t.rev_frames
let violations t = List.rev t.rev_violations
let start_cycles t = List.map (fun f -> f.start_cycle) (frames t)

let rec spacings = function
  | a :: (b :: _ as rest) -> (b - a) :: spacings rest
  | [] | [ _ ] -> []
;;

let start_spacings t = spacings (start_cycles t)
let gaps t = List.rev t.rev_gaps

let is_clean t =
  (match t.state with
   | Gap _ -> true
   | Preamble _ | In_frame -> false)
  &&
  match t.rev_violations with
  | [] -> true
  | _ :: _ -> false
;;

let string_of_violation v = Printf.sprintf "cycle %d %s: %s" v.cycle v.req v.detail

let report t =
  let frames = frames t in
  let underflowed = List.length (List.filter (fun (f : frame) -> f.underflowed) frames) in
  let octets = List.fold_left (fun acc (f : frame) -> acc + List.length f.octets) 0 frames in
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
  let unfinished =
    match t.state with
    | Gap _ -> []
    | Preamble position ->
      [ Printf.sprintf "  WARNING: the run ended inside a preamble (position %d)" position ]
    | In_frame ->
      [ Printf.sprintf
          "  WARNING: the run ended inside a frame, %d octet(s) decoded and no terminate \
           character"
          (List.length t.rev_octets)
      ]
  in
  let violation_text =
    List.map (fun v -> "  VIOLATION " ^ string_of_violation v) (violations t)
  in
  String.concat
    "\n"
    ((Printf.sprintf
        "[%s] frames=%d octets=%d underflowed=%d violations=%d"
        t.name
        (List.length frames)
        octets
        underflowed
        (List.length (violations t))
      :: [ show "start cycles" (start_cycles t)
         ; show "start-to-start cycles" (start_spacings t)
         ; show "gaps (octets, terminate inclusive)" (gaps t)
         ])
     @ unfinished
     @ violation_text)
;;
