open! Base
open Hardcaml
module Xgmii_word = Dv_xgmii.Xgmii_word
module Tx_decoder = Dv_xgmii.Tx_decoder
module Stream_word = Dv_monitors.Stream_word
module Strobe_monitor = Dv_monitors.Strobe_monitor
module Xgmii_probe = Dv_xgmii_probe.Xgmii_probe
module Axi64_driver = Dv_axi64_probe.Axi64_driver

module Sim =
  Cyclesim.With_interface (Hardcaml_ethernet.Xgmii_tx_64.I) (Hardcaml_ethernet.Xgmii_tx_64.O)

type t =
  { sim : Sim.t
  ; decoder : Tx_decoder.t
  ; strobes : Strobe_monitor.t
  ; mutable cycles_driven : int
        (* WO-0080 §5.2's choke-point ordering guard, RV-0038-R5 / R5-1's
           idiom carried to this port: {!sample_cycle} is the one function
           that touches the design, so this is the one place a reversed or
           skipped drive can be caught before anything downstream treats the
           result as a statement about M04. Starts at 0 in {!create};
           incremented on every conforming call. *)
  }

let decoder t = t.decoder
let strobes t = t.strobes

(* T10: the 8-bit cfg_ifg drive. Same [concat_lsb]-of-eight-bits shape
   test/xgmii_probe/xgmii_probe.ml's and test/axi64_probe/axi64_driver.ml's
   own [bits_of_int] already carry through a green CI run — defined again
   here rather than reached into cross-module, so this file's proven-API
   surface is self-contained. No integer constructor and no width argument
   whose name this repository's local compiler cannot check. *)
let bit b = if b then Bits.vdd else Bits.gnd

let bits_of_int ~width value =
  Bits.concat_lsb (List.init width ~f:(fun i -> bit ((value lsr i) land 1 = 1)))
;;

let poison = 0xA5

let create () =
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (Hardcaml_ethernet.Xgmii_tx_64.create scope) in
  let i = Cyclesim.inputs sim in
  (* SPEC-M04 §7.1 (WO-0080's own pin): clear for exactly one cycle, then
     release. cfg_tx_enable = 1 and cfg_ifg = 12 driven THROUGH that reset
     cycle and every cycle after — this function's own choke point for both,
     matching {!sample_cycle}'s later choke point for the same two inputs.
     The source is driven with Stream_word.idle () through the reset cycle
     rather than left at Cyclesim's zero default (N2, the RV-0038 addendum
     incident that taught this at the other port): harmless under clear (no
     accepted word, so no frame can open), but obligation 6's own check never
     reaches this cycle because it is outside every schedule {!run_lengths}
     drives, so it is worth driving correctly rather than relying on clear to
     paper over it. *)
  Axi64_driver.to_refs
    ~tvalid:i.tx.tvalid
    ~tdata:i.tx.tdata
    ~tkeep:i.tx.tkeep
    ~tstrb:i.tx.tstrb
    ~tlast:i.tx.tlast
    ~tuser:i.tx.tuser
    (Stream_word.idle ());
  i.clear := Bits.vdd;
  i.cfg_tx_enable := Bits.vdd;
  i.cfg_ifg := bits_of_int ~width:8 12;
  Cyclesim.cycle sim;
  i.clear := Bits.gnd;
  { sim
  ; decoder = Tx_decoder.create ~name:"M04 tx" ~ifg:12 ()
  ; strobes = Strobe_monitor.create ~name:"M04 tx" ~strobes:[ "error_underflow" ]
  ; cycles_driven = 0
  }
;;

type sample =
  { cycle : int
  ; offered : Stream_word.t
  ; accepted : bool
  ; wire : Xgmii_word.t
  ; underflow : bool
  }

(* WO-0080 §5.2's eight steps, in order — the drive/sample idiom
   test/xgmii_rx_64/bench.ml's own sample_cycle carries, direction reversed
   and the acceptance decision added. *)
let sample_cycle t ~cycle (offered : Stream_word.t) : sample =
  (* Step 1: the choke-point ordering guard. *)
  if cycle <> t.cycles_driven
  then
    failwith
      (String.concat
         [ "Bench.sample_cycle: driving cycle "
         ; Int.to_string cycle
         ; " after "
         ; Int.to_string t.cycles_driven
         ; " cycles have been driven — the STIMULUS is out of order at the one \
            point that touches the design, so nothing downstream of this is a \
            statement about it"
         ]);
  t.cycles_driven <- t.cycles_driven + 1;
  let i = Cyclesim.inputs t.sim in
  (* Step 2: take the Before output view before cycling — a Bits.t ref
     handle per field, read only after the clock has advanced (step 5). *)
  let o = Cyclesim.outputs ~clock_edge:Side.Before t.sim in
  let tready_ref = o.tx_dest.tready in
  let d_ref = o.xgmii_tx.d in
  let c_ref = o.xgmii_tx.c in
  let underflow_ref = o.error_underflow in
  (* Step 3: drive the six source refs plus clear/cfg_ifg/cfg_tx_enable at
     this SAME choke point — one unconditional ref write per cycle per
     input, never a conditional one (WO-0067 §1.1(R-e) / WO-0072 §5 clause 4,
     carried to this port). clear is always 0 here: the one reset cycle is
     {!create}'s own, outside this function's cycle numbering (§7.1); no
     Clear or Enable schedule type is built this round (BOUNCE BM5), so
     cfg_ifg = 12 and cfg_tx_enable = 1 are driven as constants rather than
     read from a schedule argument. *)
  Axi64_driver.to_refs
    ~tvalid:i.tx.tvalid
    ~tdata:i.tx.tdata
    ~tkeep:i.tx.tkeep
    ~tstrb:i.tx.tstrb
    ~tlast:i.tx.tlast
    ~tuser:i.tx.tuser
    offered;
  i.clear := Bits.gnd;
  i.cfg_ifg := bits_of_int ~width:8 12;
  i.cfg_tx_enable := Bits.vdd;
  (* Step 4. *)
  Cyclesim.cycle t.sim;
  (* Step 5: read the Before view — tx_dest.tready, xgmii_tx.d, xgmii_tx.c,
     error_underflow. *)
  let tready = Bits.to_int !tready_ref <> 0 in
  let wire = Xgmii_probe.of_refs ~d:d_ref ~c:c_ref () in
  let underflow = Bits.to_int !underflow_ref <> 0 in
  (* Step 6: decide acceptance. *)
  let accepted = offered.tvalid && tready in
  (* Step 7: feed the standing instruments, every cycle including idle ones
     (obligation 1, obligation 4 / C-23's counting convention). *)
  Tx_decoder.observe t.decoder ~cycle wire;
  Strobe_monitor.sample
    t.strobes
    ~cycle
    ~high:(if underflow then [ "error_underflow" ] else []);
  (* Step 8. *)
  { cycle; offered; accepted; wire; underflow }
;;

let content_octets ~p = List.init p ~f:(fun j -> 1 + Int.rem j 127)

(* WO-0080 §5.5's presenter, obligation 6's own check, T6's poisoned-word
   construction. *)
let source_words octets =
  let rec chunks = function
    | [] -> []
    | xs ->
      let chunk, rest = List.split_n xs 8 in
      chunk :: chunks rest
  in
  let all = chunks octets in
  let n = List.length all in
  (* Only the LAST chunk of a list cut into eights can have fewer than eight
     elements — every earlier chunk is exactly eight by [List.split_n]'s own
     construction, so [len = 8] alone (not [is_last]) decides whether a chunk
     needs poisoning. *)
  List.mapi all ~f:(fun i chunk ->
    let is_last = i = n - 1 in
    let len = List.length chunk in
    if len = 8
    then Stream_word.of_octets ~tlast:is_last chunk
    else
      Stream_word.raw
        ~tvalid:true
        ~tdata:(chunk @ List.init (8 - len) ~f:(fun (_ : int) -> poison))
        ~tkeep:((1 lsl len) - 1)
        ~tstrb:0
        ~tlast:true
        ~tuser:0)
;;

(* Obligation 6: every frame the source model presents is checked against
   §3's contract before it is presented — Arrival.check's own ground, one
   port over. Returns a list of descriptions, empty when conformant. *)
let check_words (words : Stream_word.t list) =
  let n = List.length words in
  List.concat
    (List.mapi words ~f:(fun i (w : Stream_word.t) ->
       let is_last = i = n - 1 in
       let problems = ref [] in
       let add msg = problems := msg :: !problems in
       if not w.tvalid
       then
         add
           (String.concat
              [ "word "; Int.to_string i; ": tvalid = false, never driven by this presenter" ]);
       if w.tvalid && w.tkeep = 0
       then
         add
           (String.concat
              [ "word "
              ; Int.to_string i
              ; ": tkeep = 0 with tvalid, never driven (SPEC-M01 §6.1, SPEC-M04 §3 \
                 REQ-011 row)"
              ]);
       if (not is_last) && w.tkeep <> 0xFF
       then
         add
           (String.concat
              [ "word "
              ; Int.to_string i
              ; ": not the tlast word but tkeep = "
              ; Int.to_string w.tkeep
              ; " <> 0xFF"
              ]);
       if is_last && not (Stream_word.keep_is_contiguous_from_zero w)
       then
         add
           (String.concat
              [ "word "
              ; Int.to_string i
              ; " (tlast): tkeep = "
              ; Int.to_string w.tkeep
              ; " is not 1-8 contiguous ones from bit 0 (REQ-011)"
              ]);
       if not (Bool.equal w.tlast is_last)
       then
         add
           (String.concat
              [ "word "
              ; Int.to_string i
              ; ": tlast = "
              ; Bool.to_string w.tlast
              ; ", expected "
              ; Bool.to_string is_last
              ]);
       List.rev !problems))
;;

(* WO-0082 §5.3(2): the loop and the liveness bound, split from the
   postcondition each presenter enforces over it — a re-expression of
   WO-0080's landed [present], not a behaviour change. [drive] offers word
   [next] (or idle when the source is exhausted) every cycle and advances
   [next] only on acceptance; it never withholds mid-frame (§9.4(1), BOUNCE
   BM6). *)
let drive t (words : Stream_word.t list) ~total : sample list =
  let w = List.length words in
  let words_arr = Array.of_list words in
  let rec go cycle next acc =
    if cycle >= total
    then List.rev acc
    else (
      let offered = if next < w then words_arr.(next) else Stream_word.idle () in
      let s = sample_cycle t ~cycle offered in
      let next' = if s.accepted then next + 1 else next in
      go (cycle + 1) next' (s :: acc))
  in
  go 0 0 []
;;

let accepted_cycles_of samples =
  List.filter_map samples ~f:(fun (s : sample) -> if s.accepted then Some s.cycle else None)
;;

(* SP-1 / the landed liveness bound (§5.6, WO-0082 §5.3(4)): NOT a timing
   assertion about C (M04-A5 forbids that) — it claims only that the run
   produced a frame to talk about. A conformant M04 with a word offered
   from cycle 0 accepts by cycle 2 (SPEC-M04 §6.2's Idle row), so 16 is
   slack and any firing is real. Shared by every presenter over {!drive}. *)
let assert_liveness accepted_cycles =
  match accepted_cycles with
  | [] ->
    failwith
      "Bench.present: no word accepted within the liveness bound of 16 cycles — \
       this is a BENCH-LIVENESS bound, not a timing assertion about C (M04-A5 \
       forbids asserting C's value); it claims only that the run produced a frame \
       to talk about, and this run produced none"
  | c :: _ ->
    if c > 16
    then
      failwith
        (String.concat
           [ "Bench.present: first acceptance at cycle "
           ; Int.to_string c
           ; " exceeds the liveness bound of 16 cycles — a BENCH-LIVENESS bound, \
              not a timing assertion about C"
           ])
;;

(* [present] = {!drive} + P-ACCEPT (WO-0082 §5.3(2)): byte-for-byte the
   landed semantics, used by [run_frames] and therefore by [run_lengths]. *)
let present t (words : Stream_word.t list) ~total : sample list =
  let samples = drive t words ~total in
  let accepted_cycles = accepted_cycles_of samples in
  assert_liveness accepted_cycles;
  (* P-ACCEPT (§5.6): the accepted cycles are exactly C, C+1, .., C+W-1,
     contiguous. A precondition of every derived constant downstream, not a
     claimed row; its failure is disposition class D3 (routed to dv_lead),
     never a bounce. *)
  let w = List.length words in
  let c = List.hd_exn accepted_cycles in
  let expected = List.init w ~f:(fun m -> c + m) in
  if not (List.equal Int.equal accepted_cycles expected)
  then
    failwith
      (String.concat
         [ "Bench.present: P-ACCEPT precondition failed (WO-0080 §5.6, disposition \
            class D3) — accepted cycles were ["
         ; String.concat ~sep:"; " (List.map accepted_cycles ~f:Int.to_string)
         ; "], expected exactly ["
         ; String.concat ~sep:"; " (List.map expected ~f:Int.to_string)
         ; "] contiguous from C = "
         ; Int.to_string c
         ; " — every row assertion downstream of this precondition is meaningless \
            and must not be read"
         ]);
  samples
;;

(* [present_stream] = {!drive} + the stream preconditions (WO-0082
   §5.3(4)): SP-1 (liveness, above, unchanged) and SP-2 (completeness — the
   number of accepted samples equals the total word count offered).
   Deliberately NOT P-ACCEPT: contiguity is FALSE against a conformant M04
   at the second frame of every run (trap T4) — [tx_tready] is 0 on the FCS
   word and the terminate word (SPEC-M04 §7's C-14.1 bullet), so a stream's
   acceptance cycles have holes at those cycles in every run of more than
   one frame. SP-3: nothing else is checked here — no contiguity, no
   per-frame acceptance shape, no claim about which cycles are holes. Where
   a row needs an exact acceptance cycle, it asserts it in its own unit,
   from [samples]. *)
let present_stream t (words : Stream_word.t list) ~total : sample list =
  let samples = drive t words ~total in
  let accepted_cycles = accepted_cycles_of samples in
  assert_liveness accepted_cycles;
  let expected_total = List.length words in
  let got_total = List.length accepted_cycles in
  if got_total <> expected_total
  then
    failwith
      (String.concat
         [ "Bench.run_stream: SP-2 (completeness) failed — "
         ; Int.to_string got_total
         ; " word(s) accepted, expected "
         ; Int.to_string expected_total
         ; " (the total word count offered across the run) — every row assertion \
            downstream of this precondition is meaningless and must not be read"
         ]);
  samples
;;

(* WO-0082 §5.3(3): [frame_words] is the ONE site computing ⌊F/8⌋ — no
   second copy anywhere in this round (bar M-8). NOT exported: a unit takes
   its expected values from §6's tables, never by recomputing them from the
   same helper the runner uses. *)
let frame_words ~p = (Int.max p 60 + 4) / 8

(* [cycles_for]'s VALUE does not change at any [p] — still 27 + ⌊F/8⌋, now
   expressed over the shared helper (bar M-6b). *)
let cycles_for ~p = 27 + frame_words ~p

(* WO-0082 §5.3(3): the per-frame allowance is ⌊F_k/8⌋ + 4, where the 4 is
   1 (the preamble word) + g_max = 3, the largest g at cfg_ifg = 12
   (⌈(12+7)/8⌉ = 3). Since the true cadence is 1 + ⌊F_k/8⌋ + g_k and
   g_k <= 3, the allowance is an upper bound at every terminate lane, with
   equality at t in {5, 6, 7}. A round that changes cfg_ifg must re-derive
   this (§5.3(3)'s own warning; that round is stage 3). *)
let cycles_for_run contents =
  27
  + List.fold contents ~init:0 ~f:(fun acc content ->
      acc + frame_words ~p:(List.length content) + 4)
;;

(* WO-0082 §5.3(1): the multi-frame continuous presenter — the capability
   this round builds (WO-0082 §5, §0). Obligation 6's contract check runs
   PER FRAME, on that frame's own word list, BEFORE anything is
   concatenated (trap T5: concatenating first would demand [tlast] on the
   run's last word only and reject every earlier frame's). One SINGLE
   elaboration for the whole run (unlike {!run_frames}, which elaborates
   afresh per frame — that is the whole point). *)
let run_stream (contents : int list list) : int list list * t * sample list =
  let per_frame_words = List.map contents ~f:source_words in
  List.iteri per_frame_words ~f:(fun frame_idx words ->
    match check_words words with
    | [] -> ()
    | problems ->
      failwith
        (String.concat
           ~sep:"\n"
           (String.concat
              [ "Bench.run_stream: frame "
              ; Int.to_string frame_idx
              ; " fails obligation 6:"
              ]
            :: problems)));
  let words = List.concat per_frame_words in
  let t = create () in
  let total = cycles_for_run contents in
  let samples = present_stream t words ~total in
  contents, t, samples
;;

(* WO-0081 §5.3: the general runner. [run_one_length] is gone — its body is
   now [run_one_frame] taking a content string directly, and [run_lengths]
   below is a thin wrapper so the run-length formula ([cycles_for], above)
   and the obligation-6 / liveness-bound / P-ACCEPT guards ([check_words],
   [present]) are shared rather than duplicated (bar M-8). *)
let run_one_frame content =
  let words = source_words content in
  (match check_words words with
   | [] -> ()
   | problems ->
     failwith
       (String.concat
          ~sep:"\n"
          (String.concat
             [ "Bench.run_frames: content of length "
             ; Int.to_string (List.length content)
             ; " fails obligation 6:"
             ]
           :: problems)));
  let t = create () in
  let total = cycles_for ~p:(List.length content) in
  let samples = present t words ~total in
  content, t, samples
;;

let run_frames contents = List.map contents ~f:run_one_frame

let run_lengths ps =
  run_frames (List.map ps ~f:(fun p -> content_octets ~p))
  |> List.map ~f:(fun (content, t, samples) -> List.length content, t, samples)
;;

let first_accepted_cycle samples =
  match List.find samples ~f:(fun (s : sample) -> s.accepted) with
  | Some s -> s.cycle
  | None ->
    failwith
      "Bench.first_accepted_cycle: no accepted cycle in this sample list — \
       Bench.run_lengths's own P-ACCEPT precondition should already have caught this \
       upstream"
;;

(* WO-0082 §5.3(5): the multi-frame content reader, with no count
   constraint. Same [~name] discipline and [~ifg:12] {!wire_frame} used
   before this round. *)
let wire_frames (samples : sample list) : Tx_decoder.frame list =
  let d = Tx_decoder.create ~name:"M04 tx (content reader)" ~ifg:12 () in
  List.iter samples ~f:(fun (s : sample) -> Tx_decoder.observe d ~cycle:s.cycle s.wire);
  Tx_decoder.frames d
;;

(* [wire_frame] re-expressed over {!wire_frames} (§5.3(5)): both existing
   failure messages kept byte for byte, so the landed units' failure text
   is unchanged (bar M-6b). *)
let wire_frame (samples : sample list) : Tx_decoder.frame =
  match wire_frames samples with
  | [ f ] -> f
  | [] ->
    failwith
      "Bench.wire_frame: no completed frame decoded from this sample list — the run \
       was too short, or the design never emitted a terminate character (trap T9)"
  | fs ->
    failwith
      (String.concat
         [ "Bench.wire_frame: "
         ; Int.to_string (List.length fs)
         ; " completed frames decoded, expected exactly one — this round drives one \
            frame per run (WO-0080 §1.2)"
         ])
;;

let wire_octets samples = (wire_frame samples).octets

(* WO-0083 §5.3(1): the stall schedule — one stall per run (§5.3(1)), the
   design fixed at WO-0082 §20.4 and implemented here without re-opening
   it. *)
module Stall = struct
  type after =
    | Resume
    | Abandon

  type t =
    { frame : int
    ; word : int
    ; hold : int
    ; after : after
    }
end

(* WO-0083 §5.3(2) step 2: the schedule's three legality rules, checked
   against the PER-FRAME word lists BEFORE a single cycle is driven — an
   illegal schedule is a defect in the stimulus, not the design. *)
let check_schedule (per_frame_words : Stream_word.t list list) (stall : Stall.t) =
  let n = List.length per_frame_words in
  if not (0 <= stall.frame && stall.frame < n)
  then
    failwith
      (String.concat
         [ "Bench.run_scheduled: schedule.frame = "
         ; Int.to_string stall.frame
         ; " violates §4.4's legality rule 0 <= frame < "
         ; Int.to_string n
         ; " (List.length contents)"
         ]);
  let w_frame = List.length (List.nth_exn per_frame_words stall.frame) in
  if not (1 <= stall.word && stall.word <= w_frame - 1)
  then
    failwith
      (String.concat
         [ "Bench.run_scheduled: schedule.word = "
         ; Int.to_string stall.word
         ; " violates §4.4's legality rule 1 <= word <= W_frame - 1 (W_frame = "
         ; Int.to_string w_frame
         ; " at frame "
         ; Int.to_string stall.frame
         ; ")"
         ]);
  if stall.frame > 0 && stall.word < 2
  then
    failwith
      (String.concat
         [ "Bench.run_scheduled: schedule.word = "
         ; Int.to_string stall.word
         ; " violates §4.4's derived legality rule word >= 2 for a frame that is not the \
            run's first (frame = "
         ; Int.to_string stall.frame
         ; ", words 0 and 1 of a back-to-back frame are accepted before its own start \
            character and are never REQ-206-required, §7's C-16 consequences 2 and 4)"
         ]);
  if stall.hold < 1
  then
    failwith
      (String.concat [ "Bench.run_scheduled: schedule.hold = "; Int.to_string stall.hold; " must be >= 1" ])
;;

(* WO-0083 §5.3(3): the allowance, derived from §4.2 fact 7 rather than
   chosen. [frame_words] (WO-0082's own, unchanged — ⌊F/8⌋'s one site, bar
   M-8) is reused for every UNwithheld frame and for the Resume tail; the
   withheld frame's own contribution is the abort-law arithmetic:
   [w + max(3, hold) + 1] (the true cadence from S_j to the next start
   character is [w + 3] under branch (a), [hold <= 3], and [w + hold] under
   branch (b), [hold >= 4]; [w + max(3, hold)] covers both, +1 for the same
   one-cycle head room the normal allowance carries). *)
let cycles_for_scheduled_run (contents : int list list) (stall : Stall.t) =
  27
  + List.foldi contents ~init:0 ~f:(fun idx acc content ->
      if idx = stall.frame
      then acc + stall.word + Int.max 3 stall.hold + 1
      else acc + frame_words ~p:(List.length content) + 4)
  + (match stall.after with
     | Resume ->
       let p_j = List.length (List.nth_exn contents stall.frame) in
       frame_words ~p:(p_j - (8 * stall.word)) + 4
     | Abandon -> 0)
;;

(* WO-0083 §5.3(2'): the withholding predicate, over the presenter's own
   CURSOR (frame, word into that frame's own word list) and never over a
   cycle — a cursor schedule targets the same WORD whatever the design
   does, which is the design decision that makes the schedule
   design-independent (§5.3(2')'s own ground). [served] is mutable and is
   set the moment the cursor first reaches the schedule's target, so a
   [Resume] cursor (which returns to the SAME (frame, word) after its hold)
   never re-enters the withhold branch a second time. Returns the sample
   list alongside the bench's own INTENTION RECORD — for every cycle,
   whether the schedule intended a word to be offered — which [ST-2] checks
   against [offered.tvalid] rather than re-reading the schedule. *)
let drive_scheduled t (per_frame_words : Stream_word.t array array) (stall : Stall.t) ~total
  : sample list * bool list
  =
  let n_frames = Array.length per_frame_words in
  let served = ref false in
  let rec go cycle frame word holding acc intention =
    if cycle >= total
    then List.rev acc, List.rev intention
    else (
      match holding with
      | Some remaining ->
        (* One of [stall.hold]'s idle cycles — the schedule declares this
           cycle withheld regardless of what the design's tready does. *)
        let s = sample_cycle t ~cycle (Stream_word.idle ()) in
        if remaining > 1
        then go (cycle + 1) frame word (Some (remaining - 1)) (s :: acc) (false :: intention)
        else (
          (* The hold is served: the LAST withheld cycle has just been
             driven. Resume re-targets the same (frame, word); Abandon
             skips to the next frame's word 0. *)
          let frame', word' =
            match stall.after with
            | Resume -> frame, word
            | Abandon -> frame + 1, 0
          in
          go (cycle + 1) frame' word' None (s :: acc) (false :: intention))
      | None ->
        if (not !served) && frame = stall.frame && word = stall.word
        then (
          served := true;
          let s = sample_cycle t ~cycle (Stream_word.idle ()) in
          if stall.hold > 1
          then go (cycle + 1) frame word (Some (stall.hold - 1)) (s :: acc) (false :: intention)
          else (
            let frame', word' =
              match stall.after with
              | Resume -> frame, word
              | Abandon -> frame + 1, 0
            in
            go (cycle + 1) frame' word' None (s :: acc) (false :: intention)))
        else (
          let in_range = frame < n_frames && word < Array.length per_frame_words.(frame) in
          let offered =
            if in_range then per_frame_words.(frame).(word) else Stream_word.idle ()
          in
          let s = sample_cycle t ~cycle offered in
          let frame', word' =
            if s.accepted
            then (
              let w = word + 1 in
              if w >= Array.length per_frame_words.(frame) then frame + 1, 0 else frame, w)
            else frame, word
          in
          go (cycle + 1) frame' word' None (s :: acc) (in_range :: intention)))
  in
  go 0 0 0 None [] []
;;

(* WO-0083 §5.3(2), (5): the loop plus ST-1 .. ST-4 — {!present_scheduled}
   is {!drive_scheduled} plus the scheduled-regime postconditions, sharing
   {!assert_liveness} with {!present} and {!present_stream} (ST-1 = SP-1 =
   P-ACCEPT's own liveness bound, unchanged). *)
let present_scheduled t (per_frame_words : Stream_word.t array array) (stall : Stall.t) ~total
  : sample list
  =
  let samples, intention = drive_scheduled t per_frame_words stall ~total in
  let accepted_cycles = accepted_cycles_of samples in
  assert_liveness accepted_cycles;
  (* ST-2: schedule fidelity, a check on the BENCH — asserted from the
     bench's own intention record (drive_scheduled's own [intention]),
     never from the design's output, and design-independent by
     construction. Its failure message says everything downstream is
     void: a driver that quietly failed to withhold turns a stall round
     into a non-stall round. *)
  List.iter2_exn samples intention ~f:(fun (s : sample) intended ->
    if not (Bool.equal s.offered.tvalid intended)
    then
      failwith
        (String.concat
           [ "Bench.run_scheduled: ST-2 (schedule fidelity) failed at cycle "
           ; Int.to_string s.cycle
           ; " — offered.tvalid = "
           ; Bool.to_string s.offered.tvalid
           ; ", the bench's own intention record says "
           ; Bool.to_string intended
           ; " — this run is NOT the stimulus its schedule claims, and everything \
              downstream of this cycle is VOID"
           ]));
  (* ST-3: accountability — the schedule's own declared [abandoned] count,
     fixed before the run and never inferred from the design's output:
     [W_frame - stall.word] under Abandon, 0 under Resume. *)
  let total_words =
    Array.fold per_frame_words ~init:0 ~f:(fun acc words -> acc + Array.length words)
  in
  let abandoned =
    match stall.after with
    | Abandon -> Array.length per_frame_words.(stall.frame) - stall.word
    | Resume -> 0
  in
  let expected_accepted = total_words - abandoned in
  let got_accepted = List.length accepted_cycles in
  if got_accepted <> expected_accepted
  then
    failwith
      (String.concat
         [ "Bench.run_scheduled: ST-3 (accountability) failed — "
         ; Int.to_string got_accepted
         ; " word(s) accepted, expected "
         ; Int.to_string expected_accepted
         ; " ("
         ; Int.to_string total_words
         ; " offered minus the schedule's own declared abandoned count "
         ; Int.to_string abandoned
         ; ") — everything downstream of this precondition is VOID"
         ]);
  (* ST-4: nothing else is checked here — no contiguity claim, and no
     acceptance-cycle claim for any word offered at or after the withheld
     cycle (§4.2 fact 8: that acceptance is unconstrained by §6.3 item 3). *)
  samples
;;

(* WO-0083 §5.3(2): the third runner. *)
let run_scheduled (contents : int list list) (stall : Stall.t) : int list list * t * sample list =
  let per_frame_words_list = List.map contents ~f:source_words in
  List.iteri per_frame_words_list ~f:(fun frame_idx words ->
    match check_words words with
    | [] -> ()
    | problems ->
      failwith
        (String.concat
           ~sep:"\n"
           (String.concat
              [ "Bench.run_scheduled: frame "; Int.to_string frame_idx; " fails obligation 6:" ]
            :: problems)));
  check_schedule per_frame_words_list stall;
  let t = create () in
  let total = cycles_for_scheduled_run contents stall in
  let per_frame_words = Array.of_list (List.map per_frame_words_list ~f:Array.of_list) in
  let samples = present_scheduled t per_frame_words stall ~total in
  contents, t, samples
;;

(* WO-0083 §5.3(4): the §0.6 window rule in exactly one expression (bar
   M-21). *)
let underflow_event ~frame ~cycle ~why : Strobe_monitor.event =
  { strobe = "error_underflow"; frame; cycle; not_before = cycle; not_after = cycle + 2; why }
;;

(* WO-0083 §5.3(6): the conservation rule, generalised over an
   underflow-bearing run — the ONE place it lives (bar M-8). *)
let assert_instruments_scheduled t ~row ~frames ~underflowed ~strobe_events =
  if not (Tx_decoder.is_clean t.decoder)
  then failwith (String.concat [ row; ": wire decoder unclean:\n"; Tx_decoder.report t.decoder ]);
  (* Obligation 4, registration half: every expected event is registered
     BEFORE the monitor is asked whether it is clean. *)
  List.iter strobe_events ~f:(Strobe_monitor.expect t.strobes);
  if not (Strobe_monitor.is_clean t.strobes)
  then
    failwith
      (String.concat [ row; ": strobe monitor unclean:\n"; Strobe_monitor.report t.strobes ]);
  let high = Strobe_monitor.high_cycles t.strobes "error_underflow" in
  let expected_high = List.length strobe_events in
  if high <> expected_high
  then
    failwith
      (String.concat
         [ row
         ; ": error_underflow high for "
         ; Int.to_string high
         ; " cycles, expected "
         ; Int.to_string expected_high
         ]);
  (* Obligation 3 — transmit-side frame conservation, carried by the bench
     (T-2: no monitor exists for this port). Keyed on the first accepted
     word of each frame, not on [tlast] (unchanged keying — a rule keyed on
     [tlast] would attribute an aborted frame's own [tlast] acceptance to
     the RESUMED tail, §4.3, trap T24): the standing decoder must report
     exactly [frames] completed frames. *)
  let decoded = Tx_decoder.frames t.decoder in
  let got = List.length decoded in
  if got <> frames
  then
    failwith
      (String.concat
         [ row
         ; ": conservation: expected exactly "
         ; Int.to_string frames
         ; " frame(s) begun and completed on the standing decoder, found "
         ; Int.to_string got
         ]);
  (* The set of underflowed positions, compared WHOLE against [underflowed]
     — never a count, which would pass a run in which the wrong frame
     aborted. *)
  let got_underflowed =
    List.filter_mapi decoded ~f:(fun idx (f : Tx_decoder.frame) ->
      if f.underflowed then Some idx else None)
  in
  if not (List.equal Int.equal got_underflowed underflowed)
  then
    failwith
      (String.concat
         [ row
         ; ": conservation: frames reported underflowed = ["
         ; String.concat ~sep:"; " (List.map got_underflowed ~f:Int.to_string)
         ; "], expected ["
         ; String.concat ~sep:"; " (List.map underflowed ~f:Int.to_string)
         ; "]"
         ])
;;

(* Byte-identical behaviour at underflowed = [] and strobe_events = [] (bar
   M-6b, M-8) — the 21 units landed before this round are the witness. *)
let assert_instruments_clean_n t ~row ~frames =
  assert_instruments_scheduled t ~row ~frames ~underflowed:[] ~strobe_events:[]
;;

let assert_instruments_clean t ~row = assert_instruments_clean_n t ~row ~frames:1
