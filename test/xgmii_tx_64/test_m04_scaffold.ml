(** U1 — the scaffolding smoke unit. No [M04-] row id, and it claims no
    coverage: with no frame in flight the underflow condition cannot hold
    under any stimulus, so an idle-run silence assertion would be vacuous by
    construction (AP-xgmii_tx_64.md §5 item 7). This unit asserts that the
    SEAM works — elaborate, drive, sample, decode, count — and nothing about
    M04's conformance. WO-0080 §6.11.

    It does not go through {!Bench.run_lengths}: that runner's own liveness
    bound would fail here by design (nothing is ever offered, so nothing is
    ever accepted), so this unit drives its own twelve idle cycles directly
    through {!Bench.sample_cycle}. *)

open! Base

let row = "U1 scaffold"
let fail msg = failwith (String.concat [ row; ": "; msg ])

let run_scaffold () =
  let t = Bench.create () in
  let rec drive cycle acc =
    if cycle >= 12
    then List.rev acc
    else (
      let s = Bench.sample_cycle t ~cycle (Dv_monitors.Stream_word.idle ()) in
      drive (cycle + 1) (s :: acc))
  in
  let samples = drive 0 [] in
  (* Assertion 1: elaborated and twelve cycles driven and sampled. *)
  if List.length samples <> 12
  then
    fail
      (String.concat
         [ "expected 12 cycles driven and sampled, got "
         ; Int.to_string (List.length samples)
         ]);
  (* Assertion 2. *)
  (match Dv_xgmii.Tx_decoder.frames (Bench.decoder t) with
   | [] -> ()
   | fs ->
     fail
       (String.concat
          [ "Tx_decoder.frames: expected [], got "
          ; Int.to_string (List.length fs)
          ; " frame(s)"
          ]));
  (* Assertion 3. *)
  (match Dv_xgmii.Tx_decoder.violations (Bench.decoder t) with
   | [] -> ()
   | vs ->
     fail
       (String.concat
          [ "Tx_decoder.violations: expected [], got "; Int.to_string (List.length vs) ]));
  (* Assertion 4 — the one that earns its place: it proves [sample] is
     called on EVERY cycle, including ones where nothing is high (C-23's
     counting convention), which every other unit in this round then
     relies on. *)
  let sampled = Dv_monitors.Strobe_monitor.cycles_sampled (Bench.strobes t) in
  if sampled <> 12
  then
    fail (String.concat [ "Strobe_monitor.cycles_sampled: expected 12, got "; Int.to_string sampled ])
;;

let%expect_test
  "scaffolding smoke test: elaborate, drive twelve idle cycles, sample and \
   decode — no frame in flight, no M04- row id, no coverage claimed"
  =
  run_scaffold ();
  [%expect {||}]
;;
