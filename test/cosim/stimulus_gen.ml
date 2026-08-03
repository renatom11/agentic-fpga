(* WO-0046 §3 — Phase 1's stimulus: "One 64-octet good-FCS frame at a
   lane-0 start." Writes stimulus.txt: one line per cycle, two
   whitespace-separated hex tokens, "<16-hex xgmii_rxd> <2-hex xgmii_rxc>".

   This is NOT the pinned canonical form (canonical.mli) — that is the
   interface with data_wrangler's side. stimulus.txt is test/cosim's own
   internal seam between this file, [ours_run.ml] and [tb_xgmii_rx_64.v],
   each of which reads it independently; its format is this directory's own
   business and carries no obligation to any other worker.

   Frame content: [Dv_xgmii.Frame.stress_frame ~sequence:0 ()] — SPEC-M03
   §8's own frozen stimulus frame (destination MAC 02:00:00:00:00:01, source
   MAC 02:00:00:00:00:02, ethertype 0x0800, a 4-octet sequence number, 42
   filler octets, and the correct FCS from [Dv_golden.Crc32_ref], REQ-305's
   externally-anchored oracle) rather than a pattern invented for this file:
   reusing an already-reviewed, already-anchored content generator is a
   smaller bet than re-deriving 60 octets and a CRC by hand a second time.

   Schedule: [Dv_xgmii.Arrival.create ~first_start:0 [ octets ]] — a single
   frame, start character in lane 0 of octet time 0 (SPEC-M03 §6.1's own
   worked example: "Cycle 0 is the word carrying the start character"),
   trailed by the standard 12-octet minimum inter-frame gap. [Arrival.check]
   is asserted empty before anything is written — an unchecked stimulus
   generator is an unverified assertion about the design (the same rule
   test/xgmii_rx_64/bench.mli's [run] enforces for the main suite, restated
   here because this generator has no bench of its own to enforce it).

   Drain: [drain_cycles] extra idle cycles appended after the schedule's own
   end, so that whichever of the two implementations drains its own pipeline
   more slowly still produces every output word inside stimulus.txt's span.
   REQ-901's comparison is transactional (cycle alignment is not compared),
   so this only has to be generous, never exact (WO-0046 §1). SPEC-M03 §7's
   own drain window is 2 cycles past the terminate word; the reference's is
   unmeasured (this environment has no iverilog, WO-0046's rules, so its
   pipeline depth is not hand-derived here) — 24 cycles is comfortable
   margin over either. *)

let drain_cycles = 24

let build () =
  let octets = Dv_xgmii.Frame.stress_frame ~sequence:0 () in
  let sched = Dv_xgmii.Arrival.create ~first_start:0 [ octets ] in
  (match Dv_xgmii.Arrival.check sched with
   | [] -> ()
   | problems ->
     failwith
       (String.concat
          "\n"
          ("stimulus_gen: Arrival.check found an unconformant schedule:" :: problems)));
  sched
;;

let write_stimulus path sched =
  let oc = open_out_bin path in
  Fun.protect
    ~finally:(fun () -> close_out_noerr oc)
    (fun () ->
       let total = Dv_xgmii.Arrival.cycles sched + drain_cycles in
       for cycle = 0 to total - 1 do
         let word = Dv_xgmii.Arrival.word_at sched ~cycle in
         let d, c = Dv_xgmii.Xgmii_word.to_wire word in
         Printf.fprintf oc "%016Lx %02x\n" d c
       done)
;;

let () =
  let path = match Sys.argv with [| _; p |] -> p | _ -> "stimulus.txt" in
  write_stimulus path (build ())
;;
