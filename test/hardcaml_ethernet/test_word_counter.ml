(** Skeleton expect test proving the DV path: Cyclesim drives the design,
    hardcaml_waveterm renders a waveform, and ppx_expect diffs it against the
    snapshot below. `dune promote` accepts an intentional change; CI fails on
    an unpromoted one. Real per-module benches follow the same shape. *)

open! Base
open Hardcaml
open Hardcaml_waveterm
open Hardcaml_ethernet
module Sim = Cyclesim.With_interface (Word_counter.I) (Word_counter.O)

let%expect_test "counts only the cycles where valid is high" =
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (Word_counter.create scope) in
  let waves, sim = Waveform.create sim in
  let i = Cyclesim.inputs sim in
  i.clear := Bits.vdd;
  Cyclesim.cycle sim;
  i.clear := Bits.gnd;
  (* three accepted words, one idle cycle, one more accepted word *)
  List.iter [ 1; 1; 1; 0; 1 ] ~f:(fun v ->
    i.valid := (if v = 1 then Bits.vdd else Bits.gnd);
    Cyclesim.cycle sim);
  Waveform.print ~display_height:12 ~display_width:70 ~wave_width:1 waves;
  [%expect {| |}]
;;
