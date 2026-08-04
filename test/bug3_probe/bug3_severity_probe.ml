(* THROWAWAY — BUG-0003 §V.2 / WO-0063 §10. Never committed to the working
   branch. It exists for exactly one CI run against a transient tree whose
   libs/hardcaml_ethernet/src/xgmii_rx_64.ml carries fafb83d's (PRE-FIX)
   content, and is deleted with that tree. It is outside the row denominator,
   outside the unit inventory, and outside every campaign scorecard
   (WO-0063 §10.1).

   {2 What it is for}

   BUG-0003's fix verdict (§V.2) refused to record a severity conversion on
   evidence the fix return itself labels "Derived, not measured (the run stops
   at word 0's cycle)". §9.2 of that packet derives two quantities about the
   PRE-FIX design at one stimulus, and dv_lead declined to write CRITICAL on a
   designer's derivation from RTL dv may not read. This probe measures the two
   quantities instead. Both are printed; NEITHER is judged here.

     (a) the count of mid-frame output words with tkeep <> 0xFF and tlast = 0
         (BUG-0003 §9.2 predicts 7), and
     (b) how many of the 60 required frame octets arrive in their gapless byte
         positions (§9.2 predicts 4, the remainder being the injected idle
         word's own filler /I/ = 0x07).

   {2 Zero assertions — deliberately, and it is the point}

   There is no assert, no failwith, no exception raised by this file, and no
   comparison whose result changes what the process does. A probe that can fail
   is a test, a test carries a verdict, and the whole reason this artefact
   exists is that the verdict is dv_lead's to write in BUG-0003 over its own
   signature after reading the numbers — not a thing to be inferred from an
   exit code. Every derived figure printed below is recomputable by hand from
   the raw per-word lines printed above it; the raw lines are the evidence and
   the summary is a convenience.

   {2 Why an executable on the runtest alias}

   test/cost_probe/'s precedent, for its reason: the result must reach the CI
   log, and it can never be promoted into an expect snapshot (that would put a
   measurement of a design nobody intends to keep into the tree the build
   workflow diffs). (deps (universe)) keeps dune from serving a cached stale
   run. Every line carries the prefix BUG3-PROBE so it greps out of a build log.

   {2 Independence (PROTOCOL §10)}

   No file under libs/ or rtl_snapshots/ was opened to write this. The DUT is
   reached exactly as test/cosim/ours_run.ml and test/xgmii_rx_64/bench.ml
   reach it — through the published
   Cyclesim.With_interface (Xgmii_rx_64.I) (Xgmii_rx_64.O) entry point, by
   field-name projection off the live inputs/outputs records — and the
   stimulus comes from dv_xgmii's own DUT-independent schedule model. The
   ~clock_edge:Side.Before sampling convention and the one-cycle clear pulse
   are carried from that same reviewed reasoning (RV-0038-R6 / BUG-0001): M03's
   rx stream and its strobes are combinational in the CURRENT XGMII word, so
   Before is the view that reads a cycle's actual wire value.

   {2 The stimulus, and why it is one cell and not a sweep}

   BUG-0003 §V.2 names it: 64 octets, start lane 4, k = 1 idle cycle, through
   REQ-016's commissioned idle-injection wrapper — the single cell §9.2's
   derivation is about. Widening it here would produce numbers no pre-committed
   decision rule covers, which is how a measurement becomes an argument. *)

open Hardcaml
module Arrival = Dv_xgmii.Arrival
module Frame = Dv_xgmii.Frame
module Idle_injection = Dv_xgmii.Idle_injection
module Xgmii_word = Dv_xgmii.Xgmii_word
module Stream_word = Dv_monitors.Stream_word
module Xgmii_probe = Dv_xgmii_probe.Xgmii_probe
module Axi64_probe = Dv_axi64_probe.Axi64_probe

module Sim =
  Cyclesim.With_interface (Hardcaml_ethernet.Xgmii_rx_64.I) (Hardcaml_ethernet.Xgmii_rx_64.O)

let p fmt = Printf.printf ("BUG3-PROBE " ^^ fmt ^^ "\n")

(* ------------------------------------------------------------------ *)
(* The stimulus.                                                       *)
(* ------------------------------------------------------------------ *)

(* test/xgmii_rx_64/bench.ml's [directed_frame_octets], inlined so this probe
   links against no test library — only against the same DUT-independent
   machinery test/cosim/'s executables use. Reproduced verbatim in arithmetic
   from that file at fafb83d; if it ever disagrees with the bench's own, the
   per-word lines below still stand on their own, because the expected octet
   sequence is printed beside the observed one rather than assumed. *)
let directed_frame_octets ~length =
  let payload_len = length - 4 in
  let da_through_payload =
    (* Parenthesised deliberately: OCaml binds [land] at the [*] level, tighter
       than [+], so dropping the outer parentheses would mask 7 alone and leave
       the sum unmasked. The Base original reads
       [(length * 3 + (j * 5) + 7) land 0xFF]. *)
    List.init payload_len (fun j -> ((length * 3) + (j * 5) + 7) land 0xFF)
  in
  Frame.with_fcs da_through_payload
;;

let length = 64
let lane = 4
let idles = 1

(* REQ-101 / §0.3's lane mapping, the same one Bench.frames_at applies:
   first_start = 8 at a lane-0 start, 12 at a lane-4 one. *)
let first_start = 12

(* ------------------------------------------------------------------ *)
(* Rendering helpers. Total, and none of them can raise.               *)
(* ------------------------------------------------------------------ *)

let hex2 v = Printf.sprintf "%02X" (v land 0xFF)
let hex_list vs = String.concat " " (List.map hex2 vs)

let print_sequence label vs =
  let n = List.length vs in
  p "%s length=%d" label n;
  let arr = Array.of_list vs in
  let rec chunk i =
    if i < n
    then (
      let stop = min (i + 16) n in
      let rec take j acc = if j >= stop then List.rev acc else take (j + 1) (arr.(j) :: acc) in
      p "%s [%3d..%3d] %s" label i (stop - 1) (hex_list (take i []));
      chunk stop)
  in
  chunk 0
;;

(* ------------------------------------------------------------------ *)
(* Drive.                                                              *)
(* ------------------------------------------------------------------ *)

let () =
  p "begin -- THROWAWAY severity measurement for BUG-0003 §V.2 / WO-0063 §10.";
  p
    "context -- this run is meaningful ONLY on a transient tree whose \
     libs/hardcaml_ethernet/src/xgmii_rx_64.ml carries fafb83d's PRE-FIX content. \
     Nothing here enters history.";
  p "stimulus -- length=%d octets, start lane=%d, idle cycles k=%d (REQ-016 §10)" length lane idles;
  p "adjudication -- dv_lead's, per WO-0063 §10.2. This probe judges nothing and asserts nothing.";
  let octets = directed_frame_octets ~length in
  p "stimulus -- injected frame octets (DA through FCS) length=%d" (List.length octets);
  let sched = Arrival.create ~first_start ~fcs_valid:true [ octets ] in
  (* Standing obligation 5's check, REPORTED rather than enforced: a probe that
     raises here would tell the operator nothing about the design. *)
  (match Arrival.check sched with
   | [] -> p "schedule -- Arrival.check clean"
   | descriptions ->
     p "schedule -- Arrival.check returned %d description(s):" (List.length descriptions);
     List.iter (fun d -> p "schedule --   %s" d) descriptions);
  let frame = (Arrival.frames sched).(0) in
  p
    "schedule -- start_octet_time=%d start_lane=%d start_cycle=%d terminate_octet_time=%d \
     base_cycles=%d"
    frame.Arrival.start_octet_time
    frame.Arrival.start_lane
    (Arrival.start_cycle frame)
    (Arrival.terminate_octet_time frame)
    (Arrival.cycles sched);
  let inj = Idle_injection.uniform sched ~idles in
  (match Idle_injection.errors inj with
   | [] -> p "wrapper -- Idle_injection clean (is_clean=%b)" (Idle_injection.is_clean inj)
   | errs ->
     p "wrapper -- Idle_injection reported %d error(s) (is_clean=%b):" (List.length errs) (Idle_injection.is_clean inj);
     List.iter (fun e -> p "wrapper --   %s" e) errs);
  p
    "wrapper -- injected=%d injected_cycles=%d c45_sites=%d"
    (Idle_injection.injected inj)
    (Idle_injection.cycles inj)
    (List.length (Idle_injection.c45_sites inj));
  (* run_i4_case's own drive extent: the base schedule's cycles, plus the
     injected words, plus 8 drain cycles. Idle_injection.word_at is total, so
     cycles past the injected line return /I/. *)
  let drain = Idle_injection.injected inj + 8 in
  let total_cycles = Arrival.cycles sched + drain in
  p "drive -- cycles=%d (base %d + injected %d + drain 8)" total_cycles (Arrival.cycles sched) (Idle_injection.injected inj);
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (Hardcaml_ethernet.Xgmii_rx_64.create scope) in
  let i = Cyclesim.inputs sim in
  (* REQ-009: one clear cycle; cfg_rx_enable held at 1 for the whole run. *)
  Xgmii_probe.to_refs ~d:i.xgmii_rx.d ~c:i.xgmii_rx.c Xgmii_word.idle;
  i.clear := Bits.vdd;
  i.cfg_rx_enable := Bits.vdd;
  Cyclesim.cycle sim;
  i.clear := Bits.gnd;
  let trace = ref [] in
  for cycle = 0 to total_cycles - 1 do
    (* Before-view convention: take the ref before driving and stepping,
       dereference it (inside Axi64_probe.of_refs) only after. *)
    let o_before = Cyclesim.outputs ~clock_edge:Side.Before sim in
    Xgmii_probe.to_refs
      ~d:i.xgmii_rx.d
      ~c:i.xgmii_rx.c
      (Idle_injection.word_at inj ~cycle);
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
    trace := (cycle, out) :: !trace
  done;
  let trace = List.rev !trace in
  let delivered = List.filter (fun (_, o) -> o.Stream_word.tvalid) trace in
  p "observed -- tvalid words=%d over %d driven cycles" (List.length delivered) total_cycles;
  (* ---------------- the raw evidence: one line per tvalid word -------- *)
  List.iteri
    (fun m (cycle, (o : Stream_word.t)) ->
       p
         "word m=%d cycle=%d tkeep=0x%02X tlast=%d tuser=0x%X tdata8=[ %s ] kept=[ %s ]"
         m
         cycle
         o.Stream_word.tkeep
         (if o.Stream_word.tlast then 1 else 0)
         o.Stream_word.tuser
         (hex_list (Array.to_list o.Stream_word.tdata))
         (hex_list (Stream_word.octets o)))
    delivered;
  (* ---------------- the two sequences --------------------------------- *)
  let expected = Frame.delivered octets in
  (* [List.concat (List.map …)] rather than [List.concat_map], which needs
     OCaml >= 4.10 and buys nothing here. *)
  let observed = List.concat (List.map (fun (_, o) -> Stream_word.octets o) delivered) in
  print_sequence "expected-delivered" expected;
  print_sequence "observed-delivered" observed;
  (* ---------------- the two numbers, recomputable from the above ------- *)
  let n_words = List.length delivered in
  let a_count =
    List.length
      (List.filter
         (fun (_, (o : Stream_word.t)) ->
            o.Stream_word.tkeep <> 0xFF && not o.Stream_word.tlast)
         delivered)
  in
  let exp_arr = Array.of_list expected in
  let obs_arr = Array.of_list observed in
  let common = min (Array.length exp_arr) (Array.length obs_arr) in
  let b_count = ref 0 in
  let mismatches = ref [] in
  for k = 0 to common - 1 do
    if exp_arr.(k) = obs_arr.(k)
    then incr b_count
    else if List.length !mismatches < 20
    then mismatches := Printf.sprintf "%d(exp %02X obs %02X)" k exp_arr.(k) obs_arr.(k) :: !mismatches
  done;
  (* Counted over the list rather than with [Array.fold_left]: this file is
     compiled with [open Hardcaml] and no local toolchain exists to iterate
     against (ADR-0005), so it stays inside the exact stdlib surface
     test/cosim/ours_run.ml already proves green in CI — unlabelled [List.*],
     [Array.of_list] / [Array.length] / [Array.to_list] / [a.(i)] (identical in
     both stdlib and Base), and nothing whose Base counterpart is spelled
     differently. [Array.fold_left] is exactly such a call and is avoided. *)
  let filler = List.length (List.filter (fun v -> v = Xgmii_word.idle_char) observed) in
  p "summary -- output words = %d" n_words;
  p
    "summary -- (a) mid-frame words with tkeep <> 0xFF and tlast = 0 = %d   [BUG-0003 §9.2 \
     predicts 7]"
    a_count;
  p
    "summary -- (b) required octets in their gapless byte positions = %d of %d   [BUG-0003 \
     §9.2 predicts 4]"
    !b_count
    (Array.length exp_arr);
  p
    "summary -- observed delivered length = %d, compared positions = %d, occurrences of /I/ \
     0x07 in observed = %d"
    (Array.length obs_arr)
    common
    filler;
  p "summary -- first mismatched positions: %s"
    (match List.rev !mismatches with
     | [] -> "none"
     | ms -> String.concat " " ms);
  p
    "summary -- both figures above are recomputable by hand from the per-word and sequence \
     lines printed above; neither is judged here.";
  p "end"
;;
