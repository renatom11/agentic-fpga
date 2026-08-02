(* See protocol_monitor.mli for the contract and its SPEC-M01 citations.

   One reading is recorded here because it is not free of doubt and a later
   reader should not have to re-derive it (raised as carry-forward C-11 in
   J-dv_lead-0004).

   REQ-015 says two things that do not sit together at the one-word frame.
   Its first sentence — "Between two successive words carrying tlast = 1 a
   stream SHALL carry at least one word and at most the number of words its
   maximum payload requires — for example 190 words on the Xgmii_rx_64 output
   stream (1514 octets)" — only yields 190 if the count is taken {inclusive} of
   the later tlast word: 1514 octets is 189 full words plus a 2-octet
   remainder. Its second sentence — "A stream SHALL NOT assert tlast without at
   least one preceding word since the previous tlast" — read with that same
   inclusive convention forbids the single-word frame, which REQ-011 and
   SPEC-M01 §6.1 make mandatory for any 1-to-8-octet payload (tkeep with 1 to 8
   contiguous ones on the tlast word). The two cannot both be enforced.

   The monitor therefore enforces the first sentence with the inclusive count
   (a frame is at least one word, the tlast word included, and at most
   [max_words_per_frame] words) and enforces nothing from the second, which in
   any case has no observable: the only shape it could forbid is tlast asserted
   on a cycle carrying no word, and SPEC-M01 §6.3 item 5 forbids a monitor from
   looking at tlast on a cycle with tvalid = 0. *)

type violation_kind =
  | Tkeep_zero
  | Tkeep_not_contiguous
  | Tkeep_partial_on_non_last
  | Tstrb_nonzero
  | Frame_exceeds_max_words

type violation =
  { cycle : int
  ; kind : violation_kind
  ; detail : string
  }

type t =
  { name : string
  ; max_words_per_frame : int option
  ; mutable words_this_frame : int
  ; mutable frames : int
  ; mutable words : int
  ; mutable octets : int
  ; mutable aborts : int
  ; mutable cleared_mid_frame : int
  ; mutable rev_violations : violation list
  }

let create ~name ?max_words_per_frame () =
  { name
  ; max_words_per_frame
  ; words_this_frame = 0
  ; frames = 0
  ; words = 0
  ; octets = 0
  ; aborts = 0
  ; cleared_mid_frame = 0
  ; rev_violations = []
  }
;;

let flag t ~cycle ~kind ~detail =
  t.rev_violations <- { cycle; kind; detail } :: t.rev_violations
;;

let observe t ~cycle (w : Stream_word.t) =
  (* SPEC-M01 §6.3 item 5: nothing on this cycle is constrained unless
     [tvalid] = 1. Every rule below lives inside this guard, and the guard is
     the first thing in the function so that it cannot be sidestepped by a
     later edit. *)
  if w.Stream_word.tvalid
  then (
    let keep = w.Stream_word.tkeep in
    (* REQ-011, SPEC-M01 §6.1 *)
    if keep = 0
    then
      flag
        t
        ~cycle
        ~kind:Tkeep_zero
        ~detail:"tkeep = 0 with tvalid = 1 (REQ-011; a zero-octet frame has no encoding)"
    else if not (Stream_word.keep_is_contiguous_from_zero w)
    then
      flag
        t
        ~cycle
        ~kind:Tkeep_not_contiguous
        ~detail:(Printf.sprintf "tkeep = 0x%02x is not contiguous from bit 0 (REQ-011)" keep)
    else if (not w.Stream_word.tlast) && keep <> 0xff
    then
      flag
        t
        ~cycle
        ~kind:Tkeep_partial_on_non_last
        ~detail:
          (Printf.sprintf
             "tkeep = 0x%02x on a word without tlast; only the tlast word may be partial \
              (REQ-011)"
             keep);
    (* REQ-014, SPEC-M01 §6.1 *)
    if w.Stream_word.tstrb <> 0
    then
      flag
        t
        ~cycle
        ~kind:Tstrb_nonzero
        ~detail:
          (Printf.sprintf
             "tstrb = 0x%02x; every producer drives 0 (REQ-014)"
             w.Stream_word.tstrb);
    t.words <- t.words + 1;
    t.octets <- t.octets + Stream_word.keep_count w;
    t.words_this_frame <- t.words_this_frame + 1;
    (* REQ-015 residue, inclusive of the tlast word — see the header note. *)
    (match t.max_words_per_frame with
     | Some max_words when t.words_this_frame = max_words + 1 ->
       flag
         t
         ~cycle
         ~kind:Frame_exceeds_max_words
         ~detail:
           (Printf.sprintf
              "frame reached %d words; this stream's pinned maximum is %d (REQ-015)"
              t.words_this_frame
              max_words)
     | Some _ | None -> ());
    if w.Stream_word.tlast
    then (
      t.frames <- t.frames + 1;
      if w.Stream_word.tuser land 1 = 1 then t.aborts <- t.aborts + 1;
      t.words_this_frame <- 0))
;;

let on_clear t ~cycle =
  ignore (cycle : int);
  if t.words_this_frame > 0
  then (
    t.cleared_mid_frame <- t.cleared_mid_frame + 1;
    t.words_this_frame <- 0)
;;

let name t = t.name
let violations t = List.rev t.rev_violations
let is_clean t =
  match t.rev_violations with
  | [] -> true
  | _ :: _ -> false
;;

let frames t = t.frames
let words t = t.words
let octets t = t.octets
let aborts t = t.aborts
let cleared_mid_frame t = t.cleared_mid_frame

let string_of_kind = function
  | Tkeep_zero -> "Tkeep_zero"
  | Tkeep_not_contiguous -> "Tkeep_not_contiguous"
  | Tkeep_partial_on_non_last -> "Tkeep_partial_on_non_last"
  | Tstrb_nonzero -> "Tstrb_nonzero"
  | Frame_exceeds_max_words -> "Frame_exceeds_max_words"
;;

let string_of_violation v =
  Printf.sprintf "cycle %d: %s: %s" v.cycle (string_of_kind v.kind) v.detail
;;

let report t =
  let vs = violations t in
  let header =
    Printf.sprintf
      "[%s] frames=%d words=%d octets=%d aborts=%d cleared_mid_frame=%d violations=%d"
      t.name
      t.frames
      t.words
      t.octets
      t.aborts
      t.cleared_mid_frame
      (List.length vs)
  in
  String.concat "\n" (header :: List.map (fun v -> "  " ^ string_of_violation v) vs)
;;

let sink t ~sample ~cycle = observe t ~cycle (sample ())
