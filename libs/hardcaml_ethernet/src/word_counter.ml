(** Skeleton module proving the M1 toolchain path end to end: a typed
    [Interface] record, an [Always] state element, hierarchical
    instantiation, and Verilog emission.

    It counts 64-bit datapath words accepted while [valid] is asserted —
    the shape every Phase-1 rx-path module takes (one word per cycle, no
    backpressure). Real modules replace it; the spec-freeze gate governs
    what those are. *)

open! Base
open Hardcaml

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; valid : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t = { count : 'a [@bits 16] } [@@deriving hardcaml]
end

let create (_scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
  let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in
  let count = Signal.reg_fb spec ~enable:i.valid ~width:16 ~f:(fun d -> Signal.( +:. ) d 1) in
  { O.count }
;;

let hierarchical scope =
  let module H = Hierarchy.In_scope (I) (O) in
  H.hierarchical ~scope ~name:"word_counter" create
;;
