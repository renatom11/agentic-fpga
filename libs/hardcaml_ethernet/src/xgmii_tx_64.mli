(** M04 [Xgmii_tx_64] — the exported surface of the XGMII transmit encode
    (SPEC-M04 §4.1, FROZEN at f78766e).

    [tx] and [tx_dest] are the two directions of {b one} logical stream and
    share the prefix, so the [Source] fields emit [tx_tvalid] … [tx_tuser] and
    the [Dest] field emits [tx_tready]. This is the transmit-path pattern; M04
    is allowed a [tready] precisely because it is not a receive-path module
    (requirements.md §0.4), and REQ-208 — not REQ-003 — is what keeps that
    [tready] from reaching the receive datapath.

    [@bits] attributes are deliberately absent below: in a signature the
    deriver does not consume them, and an unconsumed attribute is a compile
    error. [cfg_ifg] is 8 bits; every other scalar is one. *)

open! Base
open Hardcaml
open! Axi64

module I : sig
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; tx : 'a Axi64.Source.t
    ; cfg_ifg : 'a
    ; cfg_tx_enable : 'a
    }
  [@@deriving hardcaml]
end

module O : sig
  type 'a t =
    { tx_dest : 'a Axi64.Dest.t
    ; xgmii_tx : 'a Xgmii.t
    ; error_underflow : 'a
    }
  [@@deriving hardcaml]
end

(** The encode. Instantiates M02 {!Crc32_eth} and nothing else (REQ-018). *)
val create : Scope.t -> Signal.t I.t -> Signal.t O.t

(** [create] wrapped for hierarchical emission, so [xgmii_tx_64] is a module of
    its own in the generated Verilog (REQ-808, REQ-903). *)
val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
