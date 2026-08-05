(** WO-0038 scaffolding smoke test, and M03-L6.

    The scaffolding test is WO-0038 §6 rule 1: elaborate the DUT, run ten
    idle cycles, assert nothing but "the simulation built" (plus that idle
    means idle, which the standing monitors already give for free). Every
    other test in this packet reuses {!Bench.create} and {!Bench.run}
    unchanged, so a red here is the seam, not a row.

    M03-L6 (STRUCTURAL, REQ-003, REQ-112, AP-xgmii_rx_64.md row M03-L6):
    "the module exposes no [tready] on the stream under test and no
    [tready] input exists." WO-0038 §2 asks for a compile-time witness, not
    a runtime check that can pass vacuously — three record CONSTRUCTIONS
    below, each rebuilding [Hardcaml_ethernet.Xgmii_rx_64]'s [I]/[O]
    records (and the [O.rx] stream) from exactly the fields
    [docs/specs/ifc_check/xgmii_rx_64_ifc.ml] and [axi64_ifc.ml] — the
    countersigned lift — declare, with the expected type induced from the
    live [i]/[o] argument so no module path has to be named. A CONSTRUCTION
    fails to compile, as a hard type error with every warning switched off,
    both when a declared field is missing and when the record gains one —
    which is exactly the "a future [tready] field fails to compile,
    whatever it is named" property M03-L6 needs. These bindings are never
    called from any [%expect_test] — they are witnessed by compiling at
    all. *)

(* History of M03-L6's discharge mechanism, kept here because the packet
   record matters as much as the code:
   - RV-0038 (`J-dv_lead-0022`) first asked for record CONSTRUCTIONS, for
     exhaustiveness reasons independent of any warning flag.
   - The RV-0038 ADDENDUM (`J-dv_lead-0023`) narrowed that to the cheaper
     `[@@@warning "@9"]` attribute kept above the original record
     PATTERNS, judging the two equivalent for L6's purpose.
   - They were not equivalent. RV-0038-R3 (`J-dv_lead-0025`), on CI run
     30769770945: an unannotated record PATTERN — the form the attribute
     was protecting — gets no type-directed label resolution from its
     scrutinee, so the pattern-form witnesses failed to build with
     `Unbound record field tvalid`, a scoping error the attribute cannot
     reach (it governs exhaustiveness, not name resolution; the real
     `Axi64.Source` field names were never wrong). A CONSTRUCTION
     sidesteps that resolution problem *and* keeps the exhaustiveness
     property `[@@@warning "@9"]` existed to protect, so the attribute is
     removed rather than left pointing at nothing — with all three
     witnesses in construction form there is no record pattern left in
     this file for it to protect. *)

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

(* WO-0068 §7.5: the cycle-0 guard repair's own witness -- four pure facts
   about {!Bench.Enable.change_cycles} (repair A, WO-0068 §7.2), none of
   them touching the design. First use of {!Bench.Enable.low} anywhere in
   test/** -- closes half of RV-0067-VERDICT §6.1's specified-but-unused
   finding, by use rather than by deletion. Title carries no [M03-] row id
   (T8, BOUNCE B16): the guard's own entry condition is the seam this
   file's own docstring already promises to hold, not a row. Not a
   guard-raises test (WO-0068 §7.5's own rejection): this suite has no
   raise-assertion idiom, and coupling a unit to the guard's own message
   text is exactly what the compatibility bar's literal clause exists to
   keep stable -- the guard's own walk at cycle 0 is already exercised as a
   non-violation by M03-J1's landed [~initial:false] schedule; what was
   broken was only the entry condition, and these four assertions plus the
   Return log's quoted entry-condition line are that condition's complete
   evidence. *)
let%expect_test "Bench.Enable.change_cycles: the cycle-0 guard repair (WO-0068 §7)" =
  let cc_equal (c1, v1) (c2, v2) = c1 = c2 && Bool.equal v1 v2 in
  if not (List.is_empty (Enable.change_cycles Enable.high))
  then failwith "change_cycles Enable.high is not []";
  if not (List.equal cc_equal (Enable.change_cycles Enable.low) [ 0, false ])
  then failwith "change_cycles Enable.low is not [ (0, false) ]";
  if not
       (List.equal
          cc_equal
          (Enable.change_cycles (Enable.changes ~initial:false [ 7, true ]))
          [ 0, false; 7, true ])
  then
    failwith
      "change_cycles (changes ~initial:false [ (7, true) ]) is not [ (0, false); (7, true) ]";
  if not
       (List.equal
          cc_equal
          (Enable.change_cycles (Enable.changes ~initial:true [ 7, false ]))
          [ 7, false ])
  then failwith "change_cycles (changes ~initial:true [ (7, false) ]) is not [ (7, false) ]";
  [%expect {||}]
;;

let _witness_i_has_no_tready
  (b : Bits.t ref)
  (i : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.I.t)
  : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.I.t
  =
  { clock = b; clear = b; xgmii_rx = i.xgmii_rx; cfg_rx_enable = b }
;;

let _witness_o_has_no_tready
  (b : Bits.t ref)
  (o : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.O.t)
  : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.O.t
  =
  { rx = o.rx
  ; error_bad_fcs = b
  ; error_bad_frame = b
  ; error_runt = b
  ; error_oversize = b
  ; error_start_without_terminate = b
  }
;;

let _witness_rx_is_source_without_dest
  (b : Bits.t ref)
  (o : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.O.t)
  : Bits.t ref Hardcaml_ethernet.Xgmii_rx_64.O.t
  =
  { o with
    rx = { tvalid = b; tdata = b; tkeep = b; tstrb = b; tlast = b; tuser = b }
  }
;;
