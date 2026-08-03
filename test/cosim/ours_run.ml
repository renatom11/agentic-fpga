(* WO-0046 §2.1 — our-side co-simulation driver. Reads stimulus_gen.ml's
   stimulus.txt, drives Hardcaml_ethernet.Xgmii_rx_64 (M03) — REQ-901's
   parameter list maps to nothing here; SPEC-M03 §5 pins M03 at zero
   compile-time parameters, so there is nothing to set at instantiation
   (WO-0046 §6 question 1 names the same finding for the Verilog side) —
   and writes ours.canon in canonical.mli's pinned grammar.

   {2 Independence}

   This file elaborates M03 exactly as test/xgmii_rx_64/bench.ml does: through
   the published [Cyclesim.With_interface (Xgmii_rx_64.I) (Xgmii_rx_64.O)]
   entry point, reaching every port by field-name projection off the live
   [Cyclesim.inputs]/[outputs] records ([i.xgmii_rx.d], [o.rx.tvalid], …)
   rather than by naming or reading any concrete implementation.
   [libs/hardcaml_ethernet/src/] and [rtl_snapshots/**] were not opened to
   write this file (PROTOCOL §10). The [~clock_edge:Side.Before] sampling
   convention and the one-cycle [clear] pulse are carried from that same
   file's own reviewed and corrected reasoning (RV-0038-R6/BUG-0001: M03's
   [rx] stream and its strobes are combinational in the CURRENT XGMII word,
   SPEC-M03 §6.1's one-word lookahead, so [Before] is the view that reads a
   cycle's actual wire value; the default [After] view reads the state one
   edge later).

   {2 The accept-or-discard decision (WO-0046 §6 question 4)}

   REQ-901's [D] line is derived identically for both this driver and
   [tb_xgmii_rx_64.v]: a frame is admitted when its start character is
   recognised (REQ-101, lane 0 or lane 4) on the word about to be driven;
   an admitted frame is [Accept] iff a [tlast] word is observed for it before
   the stimulus (which already carries its own drain margin,
   stimulus_gen.ml) is exhausted, and [Discard] otherwise — the "no output
   word at all" case WO-0046 §2.3 and SPEC-M03 §9's zero-delivered rows both
   describe. This turned out to be a SYMMETRIC rule rather than one derived
   differently per side, because both M03 and the reference present an
   AXI-Stream-shaped [tvalid]/[tlast] output; see the Return log for the
   scope this does not cover (a second start character while a frame is
   still open — REQ-110's abort case — is out of Phase 1's authorised
   stimulus, WO-0046 §9, and is deliberately not implemented: this file
   [failwith]s rather than guess at it, so a future phase that needs it
   is told to write it rather than silently mishandling it). *)

open Hardcaml
module Xgmii_word = Dv_xgmii.Xgmii_word
module Stream_word = Dv_monitors.Stream_word
module Xgmii_probe = Dv_xgmii_probe.Xgmii_probe
module Axi64_probe = Dv_axi64_probe.Axi64_probe

module Sim =
  Cyclesim.With_interface (Hardcaml_ethernet.Xgmii_rx_64.I) (Hardcaml_ethernet.Xgmii_rx_64.O)

(* stimulus.txt: one line per cycle, "<16-hex xgmii_rxd> <2-hex xgmii_rxc>" —
   stimulus_gen.ml's format, not the pinned canonical form. *)
let read_stimulus path =
  let ic = open_in_bin path in
  let rec loop acc =
    match input_line ic with
    | line ->
      (match String.split_on_char ' ' line |> List.filter (fun s -> String.length s > 0) with
       | [ d_hex; c_hex ] ->
         let d = Int64.of_string ("0x" ^ d_hex) in
         let c = int_of_string ("0x" ^ c_hex) in
         loop (Xgmii_word.of_wire d c :: acc)
       | _ -> failwith (Printf.sprintf "ours_run: malformed stimulus line %S" line))
    | exception End_of_file -> List.rev acc
  in
  let words = loop [] in
  close_in ic;
  words
;;

let word_of_stream_word (w : Stream_word.t) : Canonical.word =
  { Canonical.tkeep = w.tkeep
  ; tlast = w.tlast
  ; tuser0 = w.tuser land 1 = 1
  ; octets = Stream_word.octets w
  }
;;

(* The bookkeeping half of WO-0046 §6 question 4, pulled out of the Cyclesim
   driving loop below so it is a plain function over [Xgmii_word.t] and
   [Stream_word.t] -- neither of which carries a Hardcaml dependency -- and
   is therefore exercisable on a hand-built trace with no DUT, no simulator
   and no elaboration, same as every DUT-independent model in dv_xgmii and
   dv_monitors. [trace] is one entry per driven cycle, in order: the input
   word driven that cycle, paired with the DUT's own [rx] stream reading for
   that SAME cycle (the [~clock_edge:Side.Before] view [run] samples below).
   [tb_xgmii_rx_64.v] implements the identical algorithm independently in
   Verilog, over its own per-cycle input/output pair. *)
let accumulate (trace : (Xgmii_word.t * Stream_word.t) list) : Canonical.transaction =
  let frames_rev = ref [] in
  let next_index = ref 0 in
  let open_frame = ref None in
  let close_frame ~decision =
    match !open_frame with
    | None -> ()
    | Some (index, words_rev) ->
      frames_rev
      := { Canonical.index; decision; words = List.rev words_rev } :: !frames_rev;
      open_frame := None
  in
  List.iter
    (fun (word, out) ->
       (match Xgmii_word.start_lane word with
        | Some (0 | 4) ->
          (match !open_frame with
           | Some _ ->
             failwith
               "ours_run: a second start character arrived while a frame was open \
                -- REQ-110 abort handling is out of Phase 1's authorised stimulus \
                (WO-0046 section 9)"
           | None ->
             open_frame := Some (!next_index, []);
             next_index := !next_index + 1)
        | Some _ | None -> ());
       if out.Stream_word.tvalid
       then (
         (match !open_frame with
          | None ->
            failwith "ours_run: M03 produced an output word with no admitted frame open"
          | Some (index, words_rev) ->
            open_frame := Some (index, word_of_stream_word out :: words_rev));
         if out.tlast then close_frame ~decision:Canonical.Accept))
    trace;
  (* End of trace (which already includes Phase 1's drain margin,
     stimulus_gen.ml): a frame still open here was admitted but never
     produced a [tlast] word -- REQ-901's discard case. A no-op if no frame
     is open. *)
  close_frame ~decision:Canonical.Discard;
  List.rev !frames_rev
;;

let run ~stimulus_path ~output_path =
  let stimulus = read_stimulus stimulus_path in
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (Hardcaml_ethernet.Xgmii_rx_64.create scope) in
  let i = Cyclesim.inputs sim in
  (* REQ-009: one clear cycle, matching test/xgmii_rx_64/bench.ml's own
     convention; cfg_rx_enable held at 1 for the whole run (Phase 1 drives no
     REQ-810 case, WO-0046 §9). *)
  Xgmii_probe.to_refs ~d:i.xgmii_rx.d ~c:i.xgmii_rx.c Xgmii_word.idle;
  i.clear := Bits.vdd;
  i.cfg_rx_enable := Bits.vdd;
  Cyclesim.cycle sim;
  i.clear := Bits.gnd;
  let trace =
    List.map
      (fun word ->
         (* RV-0038-R6/R6-1's [Before] convention (this file's own header
            comment): obtain the ref before driving the next word and
            stepping the clock, dereference it (inside [Axi64_probe.of_refs])
            only after -- the same order test/xgmii_rx_64/bench.ml's
            [sample_cycle] uses. *)
         let o_before = Cyclesim.outputs ~clock_edge:Side.Before sim in
         Xgmii_probe.to_refs ~d:i.xgmii_rx.d ~c:i.xgmii_rx.c word;
         Cyclesim.cycle sim;
         let out =
           Axi64_probe.of_refs
             ~tvalid:o_before.rx.tvalid
             ~tdata:o_before.rx.tdata
             ~tkeep:o_before.rx.tkeep
             ~tstrb:o_before.rx.tstrb
             ~tlast:o_before.rx.tlast
             ~tuser:o_before.rx.tuser
             ()
         in
         word, out)
      stimulus
  in
  Canonical.write_file output_path (accumulate trace)
;;

let () =
  let stimulus_path, output_path =
    match Sys.argv with
    | [| _ |] -> "stimulus.txt", "ours.canon"
    | [| _; s |] -> s, "ours.canon"
    | [| _; s; o |] -> s, o
    | _ ->
      prerr_endline "usage: ours_run [stimulus.txt] [ours.canon]";
      exit 2
  in
  run ~stimulus_path ~output_path
;;
