(** M05 [Eth_mac_10g] — the exported surface of the MAC wrapper (SPEC-M05
    §4.1, FROZEN at f78766e).

    [rx] carries [Axi64.Source] with no [Axi64.Dest] anywhere in scope of it —
    REQ-003 structurally, inherited from M03. The [Dest] that does appear,
    [tx_dest], belongs to the transmit stream, which requirements.md §0.4
    excludes from the receive path by name for exactly this module.

    §6.3 item 2 leaves it to rtl_lead whether this file re-exports the child
    modules' types. It does not: M05's ports are built from M01's records, a
    consumer already has them through {!Axi64}, and a re-export would be a
    second place for the same names to be stated.

    [@bits] attributes are deliberately absent below: in a signature the
    deriver does not consume them, and an unconsumed attribute is a compile
    error. *)

open! Base
open Hardcaml
open! Axi64

module I : sig
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; xgmii_rx : 'a Xgmii.t
    ; tx : 'a Axi64.Source.t
    ; cfg_rx_enable : 'a
    ; cfg_tx_enable : 'a
    ; cfg_ifg : 'a
    }
  [@@deriving hardcaml]
end

module O : sig
  type 'a t =
    { rx : 'a Axi64.Source.t
    ; tx_dest : 'a Axi64.Dest.t
    ; xgmii_tx : 'a Xgmii.t
    ; error_bad_fcs : 'a
    ; error_bad_frame : 'a
    ; error_runt : 'a
    ; error_oversize : 'a
    ; error_start_without_terminate : 'a
    ; error_underflow : 'a
    }
  [@@deriving hardcaml]
end

(** The wiring. Instantiates {!Xgmii_rx_64} and {!Xgmii_tx_64} exactly once
    each and adds no logic (REQ-018's whitelist, §6.1's total table). *)
val create : Scope.t -> Signal.t I.t -> Signal.t O.t

(** [create] wrapped for hierarchical emission, so [eth_mac_10g] is a distinct
    emitted module containing both children (REQ-808, REQ-903). *)
val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
