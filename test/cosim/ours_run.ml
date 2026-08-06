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
   is told to write it rather than silently mishandling it).

   {2 The idle-count sidecar (WO-0078 §5.2, FINDING RV-0075-2)}

   This file is the middle hop of a three-file relay: [stimulus_gen.ml]
   authors, per case, how many idle XGMII words its own schedule injected at
   or before each frame's first octet D(0) (only it knows this, by
   construction of the schedule); this file reads that record from
   [<stimulus_path>.idle] (absent for every case this packet's Stage 1
   ships, read as "0 for every frame") and forwards it, unchanged, to
   [<output_path>.idle]; [compare.ml] reads it from there and passes it to
   [Canonical.check_timing] as the antecedent FINDING RV-0075-2 requires be
   CARRIED rather than inferred from either canonical file's own cycles.
   This file performs no computation on the counts beyond a length
   cross-check against the number of frames it actually admitted — it does
   not, and structurally cannot, derive the count itself, since nothing
   about the DUT's own cycles reveals how many idle words the SCHEDULE
   chose to inject before a frame started. *)

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

(* WO-0078 §5.2 / FINDING RV-0075-2: [<stimulus_path>.idle], read here if
   present -- [stimulus_gen.ml]'s own per-case record of how many idle
   XGMII words its schedule injected at or before each frame's first octet
   D(0), one decimal integer per line, line order = frame ADMISSION order
   (0-based) -- the same order this file's own [accumulate] discovers
   frames in, since both walk the identical stimulus in the identical
   direction. Absent for every case this packet's Stage 1 ships (including
   case 0): [None] then, read by [run] below as "0 for every frame",
   unchanged from before this sidecar existed. *)
let read_idle_sidecar path =
  if not (Sys.file_exists path)
  then None
  else (
    let ic = open_in_bin path in
    let rec loop acc =
      match input_line ic with
      | line -> loop (int_of_string (String.trim line) :: acc)
      | exception End_of_file -> List.rev acc
    in
    let counts = loop [] in
    close_in ic;
    Some counts)
;;

(* Forwards [idle_counts] (one per frame, admission order) to
   [<output_path>.idle], for [compare.ml] to pick up as [check_timing]'s
   carried antecedent -- the second hop of the same relay ([stimulus_gen.ml]
   authors it; this file only forwards what it read, or an all-zero default
   it manufactures itself when nothing was to forward, never inventing a
   nonzero value on its own account). *)
let write_idle_sidecar path idle_counts =
  let oc = open_out_bin path in
  Fun.protect
    ~finally:(fun () -> close_out_noerr oc)
    (fun () -> List.iter (fun n -> Printf.fprintf oc "%d\n" n) idle_counts)
;;

(* [cycle] (WO-0075 §2): the shared time base's (§3.0) index of the
   stimulus line whose driving produced this word -- the SAME [line_index]
   [accumulate] below is folding over, passed in by its one caller rather
   than re-derived here. *)
let word_of_stream_word ~cycle (w : Stream_word.t) : Canonical.word =
  { Canonical.tkeep = w.tkeep
  ; tlast = w.tlast
  ; tuser0 = w.tuser land 1 = 1
  ; cycle
  ; octets = Stream_word.octets w
  }
;;

(* The bookkeeping half of WO-0046 §6 question 4, pulled out of the Cyclesim
   driving loop below so it is a plain function over [Xgmii_word.t] and
   [Stream_word.t] -- neither of which carries a Hardcaml dependency -- and
   is therefore exercisable on a hand-built trace with no DUT, no simulator
   and no elaboration, same as every DUT-independent model in dv_xgmii and
   dv_monitors. [trace] is one entry per driven cycle, in order: the
   stimulus line's own 0-based index (WO-0075 §3.0's shared time base --
   carried here from [run]'s [List.mapi] below rather than re-derived, so
   this stays "a third component ... your call", WO-0075 §5.2), the input
   word driven that cycle, and the DUT's own [rx] stream reading for that
   SAME cycle (the [~clock_edge:Side.Before] view [run] samples below).
   [tb_xgmii_rx_64.v] implements the identical algorithm independently in
   Verilog, over its own per-cycle input/output/line-index triple
   ([stimulus_lines - 1]). *)
let accumulate (trace : (int * Xgmii_word.t * Stream_word.t) list) : Canonical.transaction =
  let frames_rev = ref [] in
  let next_index = ref 0 in
  (* (frame-index, admit_cycle, words-so-far in reverse) *)
  let open_frame = ref None in
  let close_frame ~decision =
    match !open_frame with
    | None -> ()
    | Some (index, admit_cycle, words_rev) ->
      frames_rev
      := { Canonical.index; admit_cycle; decision; words = List.rev words_rev }
         :: !frames_rev;
      open_frame := None
  in
  List.iter
    (fun (line_index, word, out) ->
       (match Xgmii_word.start_lane word with
        | Some (0 | 4) ->
          (match !open_frame with
           | Some _ ->
             failwith
               "ours_run: a second start character arrived while a frame was open \
                -- REQ-110 abort handling is out of Phase 1's authorised stimulus \
                (WO-0046 section 9)"
           | None ->
             (* WO-0075 §2: [admit_cycle] is recorded at the exact point
                [Xgmii_word.start_lane] recognises the start character --
                this SAME [line_index], the stimulus line carrying it. *)
             open_frame := Some (!next_index, line_index, []);
             next_index := !next_index + 1)
        | Some _ | None -> ());
       if out.Stream_word.tvalid
       then (
         (match !open_frame with
          | None ->
            failwith "ours_run: M03 produced an output word with no admitted frame open"
          | Some (index, admit_cycle, words_rev) ->
            open_frame
            := Some
                 ( index
                 , admit_cycle
                 , word_of_stream_word ~cycle:line_index out :: words_rev ));
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
    (* WO-0075 §2/§3.0: [List.mapi] rather than [List.map] -- the ONLY change
       this WO makes to this loop -- so each entry carries the 0-based
       stimulus-line index of the word it drives, the shared time base both
       producers now write into the pinned grammar. Sampling itself
       (convention and order below) is untouched (WO-0075 §8 item 2). *)
    List.mapi
      (fun idx word ->
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
         idx, word, out)
      stimulus
  in
  let transaction = accumulate trace in
  Canonical.write_file output_path transaction;
  (* WO-0078 §5.2 / FINDING RV-0075-2: forward the idle-count sidecar,
     frame for frame. [frame_count] is EVERY frame [accumulate] recorded
     (Accept or Discard alike, admission order) -- the same count
     [stimulus_gen.ml]'s sidecar was written against, since both walk the
     identical stimulus. A sidecar present but of the WRONG length is a NEW
     harness-defect refusal (WO-0078 §2.3's census is about producer
     refusals reaching a distinct non-zero code; this extends that census
     by one entry this file itself introduces, flagged as such in the
     Return log rather than silently folded into the original six) --
     `failwith`, exactly like this file's existing refusals, rather than
     silently truncating or padding a count that no longer corresponds to
     the frames actually admitted. *)
  let frame_count = List.length transaction in
  let idle_counts =
    match read_idle_sidecar (stimulus_path ^ ".idle") with
    | None -> List.init frame_count (fun _ -> 0)
    | Some counts ->
      if List.length counts <> frame_count
      then
        failwith
          (Printf.sprintf
             "ours_run: stimulus idle sidecar %s declares %d frame(s) but %d were admitted \
              -- the sidecar and the stimulus it accompanies have drifted apart"
             (stimulus_path ^ ".idle")
             (List.length counts)
             frame_count);
      counts
  in
  write_idle_sidecar (output_path ^ ".idle") idle_counts
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
