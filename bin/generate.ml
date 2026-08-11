(** RTL emission. Writes hierarchical Verilog to rtl_snapshots/ so generated
    output is diff-reviewable and CI can prove regeneration is deterministic
    (same source => byte-identical Verilog). *)

open! Base
open Hardcaml
open Hardcaml_ethernet

let emit_word_counter out_channel =
  let scope = Scope.create ~flatten_design:false () in
  let module Circuit = Circuit.With_interface (Word_counter.I) (Word_counter.O) in
  (* The wrapper needs a name distinct from the hierarchical module it
     instantiates: with both named "word_counter", Rtl.output drops the inner
     module (its logic) and emits a self-instantiating shell. *)
  let circuit =
    Circuit.create_exn ~name:"word_counter_top" (Word_counter.hierarchical scope)
  in
  Rtl.output
    ~database:(Scope.circuit_database scope)
    ~output_mode:(Rtl.Output_mode.To_channel out_channel)
    Verilog
    circuit
;;

(* The design modules take the other horn of that same naming problem.
   [Word_counter] is emitted through [hierarchical], so its top had to be
   renamed to [word_counter_top]; a design module may not do that, because
   [word_counter_top] is only tolerated in rtl_snapshots/ by the explicit
   bootstrap allowance in tools/check_emitted_verilog.sh, and any other
   non-inventory module name is a REQ-808 FAIL there ("emitted module(s) not in
   the architecture.md §4 inventory"). So the top circuit is built from
   [create] instead: the module's own name is then free for its own logic, and
   the scope database still supplies every child that [create] instantiated
   through [hierarchical]. Nothing is flattened and no shell is emitted —
   SPEC-M03/M04/M05/M06 §10's REQ-808/REQ-903 rows ask for a distinct emitted
   module per inventory name, which is exactly what this produces.

   Emitted top names are the module names those §10 rows and REQ-808 fix
   (`xgmii_rx_64`, `xgmii_tx_64`, `eth_mac_10g`, `eth_axis_rx`) — identical to
   the names each module's own [hierarchical] already registers, so a module has
   one name in the netlist whether it is emitted here or instantiated by a
   parent. Each file is named after its top. §12 of all four specs is the freeze
   record and says nothing about emission; see WO-0026's Return log.

   M06 takes the [create] horn for the same REQ-808 reason as M03–M05 and not
   because it has children to supply: SPEC-M06 §1 says it instantiates nothing,
   so its scope database is empty and [Rtl.output] emits exactly one module. The
   choice still matters — through [hierarchical] under a top of the same name,
   the word_counter_top failure mode returns and the file becomes a shell
   instantiating a module that is not in it. *)

let emit_xgmii_rx_64 out_channel =
  let scope = Scope.create ~flatten_design:false () in
  let module Circuit = Circuit.With_interface (Xgmii_rx_64.I) (Xgmii_rx_64.O) in
  let circuit = Circuit.create_exn ~name:"xgmii_rx_64" (Xgmii_rx_64.create scope) in
  Rtl.output
    ~database:(Scope.circuit_database scope)
    ~output_mode:(Rtl.Output_mode.To_channel out_channel)
    Verilog
    circuit
;;

let emit_xgmii_tx_64 out_channel =
  let scope = Scope.create ~flatten_design:false () in
  let module Circuit = Circuit.With_interface (Xgmii_tx_64.I) (Xgmii_tx_64.O) in
  let circuit = Circuit.create_exn ~name:"xgmii_tx_64" (Xgmii_tx_64.create scope) in
  Rtl.output
    ~database:(Scope.circuit_database scope)
    ~output_mode:(Rtl.Output_mode.To_channel out_channel)
    Verilog
    circuit
;;

let emit_eth_mac_10g out_channel =
  let scope = Scope.create ~flatten_design:false () in
  let module Circuit = Circuit.With_interface (Eth_mac_10g.I) (Eth_mac_10g.O) in
  let circuit = Circuit.create_exn ~name:"eth_mac_10g" (Eth_mac_10g.create scope) in
  Rtl.output
    ~database:(Scope.circuit_database scope)
    ~output_mode:(Rtl.Output_mode.To_channel out_channel)
    Verilog
    circuit
;;

let emit_eth_axis_rx out_channel =
  let scope = Scope.create ~flatten_design:false () in
  let module Circuit = Circuit.With_interface (Eth_axis_rx.I) (Eth_axis_rx.O) in
  let circuit = Circuit.create_exn ~name:"eth_axis_rx" (Eth_axis_rx.create scope) in
  Rtl.output
    ~database:(Scope.circuit_database scope)
    ~output_mode:(Rtl.Output_mode.To_channel out_channel)
    Verilog
    circuit
;;

(* One scope per emitter, so a file's contents are a function of its own module
   and this list's order cannot leak into any of them. The order is fixed
   regardless: what a file is named and what it holds are both part of what
   REQ-902 holds constant across runs. *)
let () =
  let dir = "rtl_snapshots" in
  if not (Stdlib.Sys.file_exists dir) then Stdlib.Sys.mkdir dir 0o755;
  List.iter
    [ "rtl_snapshots/word_counter.v", emit_word_counter
    ; "rtl_snapshots/xgmii_rx_64.v", emit_xgmii_rx_64
    ; "rtl_snapshots/xgmii_tx_64.v", emit_xgmii_tx_64
    ; "rtl_snapshots/eth_mac_10g.v", emit_eth_mac_10g
    ; "rtl_snapshots/eth_axis_rx.v", emit_eth_axis_rx
    ]
    ~f:(fun (path, emit) ->
      Stdio.Out_channel.with_file path ~f:emit;
      Stdio.printf "wrote %s\n" path)
;;
