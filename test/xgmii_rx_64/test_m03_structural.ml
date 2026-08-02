(** WO-0038 scaffolding smoke test, and M03-L6.

    The scaffolding test is WO-0038 §6 rule 1: elaborate the DUT, run ten
    idle cycles, assert nothing but "the simulation built" (plus that idle
    means idle, which the standing monitors already give for free). Every
    other test in this packet reuses {!Bench.create} and {!Bench.run}
    unchanged, so a red here is the seam, not a row.

    M03-L6 (STRUCTURAL, REQ-003, REQ-112, AP-xgmii_rx_64.md row M03-L6):
    "the module exposes no [tready] on the stream under test and no
    [tready] input exists." WO-0038 §2 asks for a compile-time witness, not
    a runtime check that can pass vacuously — three record patterns below,
    each naming every field [Hardcaml_ethernet.Xgmii_rx_64]'s [I]/[O]
    records and the [O.rx] stream actually have. Record-pattern
    exhaustiveness (warning 9, fatal under dune's default [dev] profile
    flags — no local project override exists, confirmed by there being no
    root [dune] or [dune-workspace] file) is what makes this a REAL
    compile-time check rather than a naming exercise: a future [tready]
    field on [I], on [O], or inside [O.rx] fails every affected witness to
    compile, whatever it is named. These bindings are never called from any
    [%expect_test] — they are witnessed by compiling at all. *)

[@@@warning "@9"]

(* RV-0038 addendum D2 (J-dv_lead-0023): warning 9 (missing-record-field-pattern)
   sits inside CI's fatal `@5..28` range today, but that is a fact about
   dune's default `dev` profile flags, not about this file — and M03-L6's
   entire content is the claim that its witnesses cannot silently stop
   witnessing. Making warning 9 fatal *in this file*, via the attribute
   rather than the ambient flag set, means the three record-pattern
   witnesses below keep their teeth even if the project's warning flags ever
   drift; checked against the strongest possible suppression
   (`ocamlc -w -a` with this attribute present still errors on a partial
   pattern). *)

open! Base
open Hardcaml
open Bench

let%expect_test "WO-0038 scaffolding: Xgmii_rx_64 elaborates and runs idle cycles" =
  let bench = create () in
  let sched = Dv_xgmii.Arrival.create ~first_start:8 [] in
  let samples = run bench sched ~drain:10 () in
  if List.length samples < 10
  then failwith "scaffolding: fewer than 10 cycles were driven";
  if not (List.for_all samples ~f:(fun s -> not s.out.Dv_monitors.Stream_word.tvalid))
  then failwith "scaffolding: an all-idle run produced a tvalid word";
  if not (List.is_empty (error_pulses samples))
  then failwith "scaffolding: an all-idle run pulsed an error strobe";
  assert_monitors_clean bench ~row:"scaffolding";
  [%expect {||}]
;;

let _witness_i_has_no_tready
  ({ clock = _; clear = _; xgmii_rx = _; cfg_rx_enable = _ }
    : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.I.t)
  =
  ()
;;

let _witness_o_has_no_tready
  ({ rx = _
   ; error_bad_fcs = _
   ; error_bad_frame = _
   ; error_runt = _
   ; error_oversize = _
   ; error_start_without_terminate = _
   }
    : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.O.t)
  =
  ()
;;

let _witness_rx_is_source_without_dest (o : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.O.t) =
  let { tvalid = _; tdata = _; tkeep = _; tstrb = _; tlast = _; tuser = _ } = o.rx in
  ()
;;
