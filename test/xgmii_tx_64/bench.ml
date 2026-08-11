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

(* WO-0080 §5.5's reactive presenter: offers word [next] (or idle when the
   source is exhausted) every cycle, and advances [next] only on acceptance.
   Never withholds mid-frame (§9.4(1), BOUNCE BM6) — a word is offered on
   every cycle until it is accepted. Enforces the liveness bound and
   P-ACCEPT (§5.6) before returning. *)
let present t (words : Stream_word.t list) ~total : sample list =
  let w = List.length words in
  let words_arr = Array.of_list words in
  let rec drive cycle next acc =
    if cycle >= total
    then List.rev acc
    else (
      let offered = if next < w then words_arr.(next) else Stream_word.idle () in
      let s = sample_cycle t ~cycle offered in
      let next' = if s.accepted then next + 1 else next in
      drive (cycle + 1) next' (s :: acc))
  in
  let samples = drive 0 0 [] in
  let accepted_cycles =
    List.filter_map samples ~f:(fun (s : sample) -> if s.accepted then Some s.cycle else None)
  in
  (* The liveness bound (§5.6): NOT a timing assertion about C (M04-A5
     forbids that) — it claims only that the run produced a frame to talk
     about. A conformant M04 with a word offered from cycle 0 accepts by
     cycle 2 (SPEC-M04 §6.2's Idle row), so 16 is slack and any firing is
     real. *)
  (match accepted_cycles with
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
            ]));
  (* P-ACCEPT (§5.6): the accepted cycles are exactly C, C+1, .., C+W-1,
     contiguous. A precondition of every derived constant downstream, not a
     claimed row; its failure is disposition class D3 (routed to dv_lead),
     never a bounce. *)
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

let cycles_for ~p =
  let f = Int.max p 60 + 4 in
  27 + (f / 8)
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

let wire_frame (samples : sample list) : Tx_decoder.frame =
  let d = Tx_decoder.create ~name:"M04 tx (content reader)" ~ifg:12 () in
  List.iter samples ~f:(fun (s : sample) -> Tx_decoder.observe d ~cycle:s.cycle s.wire);
  match Tx_decoder.frames d with
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

let assert_instruments_clean t ~row =
  if not (Tx_decoder.is_clean t.decoder)
  then failwith (String.concat [ row; ": wire decoder unclean:\n"; Tx_decoder.report t.decoder ]);
  if not (Strobe_monitor.is_clean t.strobes)
  then
    failwith
      (String.concat [ row; ": strobe monitor unclean:\n"; Strobe_monitor.report t.strobes ]);
  let high = Strobe_monitor.high_cycles t.strobes "error_underflow" in
  if high <> 0
  then
    failwith
      (String.concat
         [ row; ": error_underflow high for "; Int.to_string high; " cycles, expected 0" ]);
  (* Obligation 3 — transmit-side frame conservation, carried by the bench
     (T-2: no monitor exists for this port). Keyed on the first accepted
     word: every run in this round begins exactly one frame (§1.2's scope
     rule), so the standing decoder must report exactly one frame, and it
     must not be underflowed (this round drives no underflow stimulus —
     family G is excluded). *)
  match Tx_decoder.frames t.decoder with
  | [ f ] ->
    if f.underflowed
    then
      failwith
        (String.concat
           [ row
           ; ": conservation: the one frame begun is reported underflowed — this \
              round drives no underflow stimulus (family G, WO-0080 §1.2)"
           ])
  | fs ->
    failwith
      (String.concat
         [ row
         ; ": conservation: expected exactly one frame begun and completed on the \
            standing decoder, found "
         ; Int.to_string (List.length fs)
         ])
;;
