(* SPEC-M05 §4.1, lifted verbatim into docs/specs/ifc_check/eth_mac_10g_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1). M05 restates nothing
   from SPEC-M03 or SPEC-M04 either: its ports are their ports, and the
   only thing this record adds is that the two children share one clock,
   one clear and one wire.

   [rx] carries [Axi64.Source] with no [Axi64.Dest] anywhere in scope of
   it — REQ-003 structurally, inherited from M03. [tx] and [tx_dest] are
   the transmit stream's two directions, as in SPEC-M04. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; xgmii_rx : 'a Xgmii.t [@rtlprefix "xgmii_rx"]
    ; tx : 'a Axi64.Source.t [@rtlprefix "tx_"]
    ; cfg_rx_enable : 'a
    ; cfg_tx_enable : 'a
    ; cfg_ifg : 'a [@bits 8]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { rx : 'a Axi64.Source.t [@rtlprefix "rx_"]
    ; tx_dest : 'a Axi64.Dest.t [@rtlprefix "tx_"]
    ; xgmii_tx : 'a Xgmii.t [@rtlprefix "xgmii_tx"]
    ; error_bad_fcs : 'a
    ; error_bad_frame : 'a
    ; error_runt : 'a
    ; error_oversize : 'a
    ; error_start_without_terminate : 'a
    ; error_underflow : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end
