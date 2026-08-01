(** RTL emission. Writes hierarchical Verilog to rtl_snapshots/ so generated
    output is diff-reviewable and CI can prove regeneration is deterministic
    (same source => byte-identical Verilog). *)

open! Base
open Hardcaml
open Hardcaml_ethernet

let emit_word_counter out_channel =
  let scope = Scope.create ~flatten_design:false () in
  let module Circuit = Circuit.With_interface (Word_counter.I) (Word_counter.O) in
  let circuit =
    Circuit.create_exn ~name:"word_counter" (Word_counter.hierarchical scope)
  in
  Rtl.output ~database:(Scope.circuit_database scope) ~output_mode:(To_channel out_channel)
    Verilog circuit
;;

let () =
  let path = "rtl_snapshots/word_counter.v" in
  Stdio.Out_channel.with_file path ~f:emit_word_counter;
  Stdio.printf "wrote %s\n" path
;;
