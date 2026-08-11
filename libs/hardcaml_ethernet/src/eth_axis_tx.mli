(** M07 [Eth_axis_tx] — the exported surface of the Ethernet header/payload
    join (SPEC-M07 §4.1, FROZEN at 508eea2).

    {b Both directions of both streams appear here, and that is the transmit
    pattern rather than an oversight.} [payload] carries the [Axi64.Source]
    coming in and [payload_dest] the [Axi64.Dest] going back; [tx] carries the
    [Axi64.Source] going out and [tx_dest] the [Axi64.Dest] coming back. M07 is
    allowed both because it is not a receive-path module (requirements.md
    §0.4), and REQ-208 — not REQ-003 — is what keeps that backpressure away
    from the receive datapath: M07 has no receive-side port at all, so no path
    from here into it exists to be argued about.

    The [Eth_header] is the same record M06 emits, used here as an input. It
    carries a [valid] and no [ready] in both directions; on this side its
    acceptance event is the acceptance of the frame's first payload word
    (ADR-0008), which is what lets one record serve both datapath directions.

    [@bits] attributes are deliberately absent below: in a signature the
    deriver does not consume them, and an unconsumed attribute is a compile
    error. The widths are the implementation's and are SPEC-M07 §4.2's. *)

open! Base
open Hardcaml
open! Axi64

module I : sig
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; hdr : 'a Eth_header.t
    ; payload : 'a Axi64.Source.t
    ; tx_dest : 'a Axi64.Dest.t
    }
  [@@deriving hardcaml]
end

module O : sig
  type 'a t =
    { payload_dest : 'a Axi64.Dest.t
    ; tx : 'a Axi64.Source.t
    }
  [@@deriving hardcaml]
end

(** The join. Instantiates nothing (SPEC-M07 §1). *)
val create : Scope.t -> Signal.t I.t -> Signal.t O.t

(** [create] wrapped for hierarchical emission, so [eth_axis_tx] is a module of
    its own in the generated Verilog (REQ-808, REQ-903). *)
val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
