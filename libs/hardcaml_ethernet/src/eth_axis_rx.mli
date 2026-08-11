(** M06 [Eth_axis_rx] — the exported surface of the Ethernet header/payload
    split (SPEC-M06 §4.1, FROZEN at 508eea2).

    {b The line-rate invariant is structural here, not behavioural.} Neither
    {!I} nor {!O} contains an [Axi64.Dest] and neither contains a [tready]:
    M08 cannot stall M06 and M06 cannot stall M03 (REQ-003). The
    [Eth_header] carries a [valid] and no [ready] for the same reason. A
    revision that wanted backpressure could not be written without changing
    these records, which is a spec diff to SPEC-M06 §4.

    [@bits] attributes are deliberately absent below: in a signature the
    deriver does not consume them, and an unconsumed attribute is a compile
    error. The widths are the implementation's and are SPEC-M06 §4.2's. *)

open! Base
open Hardcaml
open! Axi64

module I : sig
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; rx : 'a Axi64.Source.t
    }
  [@@deriving hardcaml]
end

module O : sig
  type 'a t =
    { hdr : 'a Eth_header.t
    ; payload : 'a Axi64.Source.t
    ; error_short_frame : 'a
    }
  [@@deriving hardcaml]
end

(** The split. Instantiates nothing (SPEC-M06 §1). *)
val create : Scope.t -> Signal.t I.t -> Signal.t O.t

(** [create] wrapped for hierarchical emission, so [eth_axis_rx] is a module of
    its own in the generated Verilog (REQ-808, REQ-903). *)
val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
