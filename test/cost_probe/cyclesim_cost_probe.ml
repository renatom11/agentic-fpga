(** THROWAWAY — WO-0009 deliverable 1. Delete this directory once the figure
    is recorded.

    {2 What it is for}

    `WO-0003_testability-findings.md` §13.2 sized the REQ-004 line-rate stress
    at roughly 110 000 Cyclesim cycles per module bench and 10 000 frames at
    `nic_top`, and said plainly that ADR-0005 makes every one of those numbers
    an engineering estimate: no Hardcaml runs in the development container, so
    nothing local can measure a cycles-per-second figure. This probe is the
    falsification point that note named. It runs a trivial synthetic design for
    a fixed number of cycles on the CI runner and prints the rate, so the DV
    plan commits to 10 000 frames against a measurement instead of a guess. If
    the rate comes back badly, reducing the frame count is an E2 scope decision
    with numbers attached (charter §7), not a quiet narrowing.

    {2 Why a synthetic DUT and not word_counter}

    Two reasons. It keeps the probe honestly DUT-independent — this measures
    the simulator on this runner, not any module's cost — and it means the
    probe reads nothing under `libs/**` (PROTOCOL §10), so no independence
    question attaches to a throwaway.

    Three sizes are run, because one number does not size anything: what the
    plan needs is the slope. `narrow` is one 64-bit register and is close to
    the per-cycle floor of [Cyclesim.cycle]; `wide` is thirty-two, which is
    nearer the register count of a real receive-path module. A per-module bench
    is bounded below by `narrow` and a `nic_top` bench above by something worse
    than `wide`, so the two bracket the estimate.

    {2 Why the result is not an expect test}

    Wall-clock is not deterministic, so a timing figure can never live in a
    promoted snapshot: the CI step that verifies nothing was left unpromoted
    (`git diff --cached --exit-code`) would fail on every run forever. The
    probe is therefore an executable attached to the `runtest` alias with
    `(deps (universe))` so dune never serves it from cache, and its output goes
    to the CI log where the orchestrator reads it. Every line is prefixed
    `COST-PROBE` so it is greppable out of a build log.

    CPU time, not wall-clock: [Sys.time] measures processor time, which is what
    a simulation loop consumes, and it does not move when a shared CI runner is
    descheduled. *)

open! Base
open Hardcaml

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t = { result : 'a [@bits 64] } [@@deriving hardcaml]
end

(* [stages] 64-bit registers, each mixing its own previous value with the
   accumulated result. Nothing about it is meaningful; it exists to give
   [Cyclesim] a fixed, parameterised amount of per-cycle work. *)
let create ~stages (i : Signal.t I.t) =
  let open Signal in
  let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in
  let seed = wire 64 in
  seed <== reg spec ~enable:i.enable (seed +:. 1);
  let rec build n acc =
    if n <= 0
    then acc
    else (
      let w = wire 64 in
      w <== reg spec ~enable:i.enable ((w <<: 1) ^: (acc +:. n));
      build (n - 1) (acc ^: w))
  in
  { O.result = build stages seed }
;;

module Sim = Cyclesim.With_interface (I) (O)

let probe ~label ~stages ~cycles =
  let sim = Sim.create (create ~stages) in
  let inputs = Cyclesim.inputs sim in
  inputs.clear := Bits.vdd;
  Cyclesim.cycle sim;
  inputs.clear := Bits.gnd;
  inputs.enable := Bits.vdd;
  let start = Stdlib.Sys.time () in
  for _ = 1 to cycles do
    Cyclesim.cycle sim
  done;
  let elapsed = Stdlib.Sys.time () -. start in
  let rate =
    if Stdlib.( > ) elapsed 0.0 then Stdlib.float_of_int cycles /. elapsed else 0.0
  in
  Stdlib.Printf.printf
    "COST-PROBE %-7s registers=%-3d cycles=%d cpu_s=%.3f cycles_per_s=%.0f\n"
    label
    stages
    cycles
    elapsed
    rate;
  Stdlib.flush Stdlib.stdout;
  rate
;;

let () =
  Stdlib.Printf.printf
    "COST-PROBE begin (THROWAWAY, WO-0009 deliverable 1; delete test/cost_probe/ once \
     recorded)\n";
  Stdlib.flush Stdlib.stdout;
  let cycles = 100_000 in
  let narrow = probe ~label:"narrow" ~stages:1 ~cycles in
  let medium = probe ~label:"medium" ~stages:8 ~cycles in
  let wide = probe ~label:"wide" ~stages:32 ~cycles in
  (* The sizing question this probe exists to answer: a per-module line-rate
     stress is ~110 000 cycles (WO-0003 findings §13.2), and nic_top's is the
     same cycle count against twenty elaborated modules. Both estimates are
     printed against the measured rates rather than left to be re-derived from
     the log. *)
  let stress_cycles = 110_000.0 in
  let seconds rate =
    if Stdlib.( > ) rate 0.0 then stress_cycles /. rate else Stdlib.nan
  in
  Stdlib.Printf.printf
    "COST-PROBE sizing 110k-cycle stress: narrow %.2f s, medium %.2f s, wide %.2f s\n"
    (seconds narrow)
    (seconds medium)
    (seconds wide);
  Stdlib.Printf.printf "COST-PROBE end\n";
  Stdlib.flush Stdlib.stdout
;;
