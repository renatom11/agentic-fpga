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

(* WO-0078 §3.2/§6.1 — the case SET, Stage 1: exactly one member, case 0,
   its construction expression ([build] above) UNEDITED — the diff of
   [build] and [write_stimulus] above shows nothing touched; what follows
   only NAMES case 0 and dispatches to it. Every later stage adds a case
   BESIDE this one, never edits it (§3.1's whole argument for why a case set
   exists at all rather than a widened single stimulus).

   The table below deliberately carries METADATA only ([id], [describe],
   [idle_counts]) and never a schedule-building function value: [build]'s
   own return type is never named anywhere in this file (it is whatever
   [Dv_xgmii.Arrival.create] returns, inferred structurally), and a record
   field typed against a name this file does not otherwise need to know
   would be the one place that guess could go wrong unnoticed. [build_case]
   below dispatches by a plain [match] instead, so [build ()]'s type is
   inferred locally from its own unedited definition, never written down.

   [idle_counts]: one entry per frame this case's schedule admits, in
   admission order — WO-0078 §5.2 / FINDING RV-0075-2's carried antecedent,
   authored HERE because this is the one place in the lane that actually
   constructs the schedule and so is the only place that can state the
   count from first-hand knowledge rather than inference. Case 0 admits
   exactly one frame with its start character at [~first_start:0] (FI-1),
   the very first driven word — there is no room before it for an injected
   idle, so its count is exactly 0, by construction of case 0 itself, not
   by absence of a feature. *)
type case_meta =
  { id : string
  ; describe : string
  ; idle_counts : int list
  }

let case0_meta : case_meta =
  { id = "0"
  ; describe =
      "WO-0046 §3 -- one 64-octet good-FCS frame, lane-0 start (frozen, byte-identical, \
       never edited, WO-0078 §3.1)"
  ; idle_counts = [ 0 ]
  }
;;

let known_cases = [ case0_meta ]

let find_case_meta id =
  match List.find_opt (fun c -> String.equal c.id id) known_cases with
  | Some c -> c
  | None ->
    failwith
      (Printf.sprintf
         "stimulus_gen: unknown case id %S (known: %s)"
         id
         (String.concat ", " (List.map (fun c -> c.id) known_cases)))
;;

(* Dispatches to the case's own schedule-builder. Never called on an id
   [find_case_meta] has not already validated (see [main] below), so the
   final arm is unreachable in normal use and names that explicitly rather
   than silently returning a wrong schedule. *)
let build_case id =
  match id with
  | "0" -> build ()
  | _ ->
    failwith
      (Printf.sprintf
         "stimulus_gen: case %S is listed in known_cases but build_case has no rule for it \
          -- a bug in this file, not in the caller"
         id)
;;

(* WO-0078 §5.2: the idle-count sidecar this case's [idle_counts] authors,
   forwarded by [ours_run.ml] to [compare.ml] -- see ours_run.ml's own header
   note for the full three-file relay. One decimal integer per line, line
   order = frame admission order, matching [Canonical]'s own [F]-line
   ordering convention. *)
let write_idle_sidecar path idle_counts =
  let oc = open_out_bin path in
  Fun.protect
    ~finally:(fun () -> close_out_noerr oc)
    (fun () -> List.iter (fun n -> Printf.fprintf oc "%d\n" n) idle_counts)
;;

let () =
  (* WO-0078 §6.1's landing-order constraint, honoured here rather than
     merely stated: [tools/cosim/run_cosim.sh] (not this packet's to touch
     in Stage 1) invokes this binary with exactly ONE positional argument
     today, the output path -- that call keeps working unchanged, defaulting
     to case 0, for exactly as long as data_wrangler's own round has not yet
     landed a case argument. The case id is therefore the SECOND, optional,
     argument, never the first. *)
  let output_path, case_id =
    match Sys.argv with
    | [| _ |] -> "stimulus.txt", "0"
    | [| _; p |] -> p, "0"
    | [| _; p; c |] -> p, c
    | _ -> failwith "usage: stimulus_gen [output_path] [case_id]"
  in
  let meta = find_case_meta case_id in
  let sched = build_case case_id in
  write_stimulus output_path sched;
  write_idle_sidecar (output_path ^ ".idle") meta.idle_counts
;;
