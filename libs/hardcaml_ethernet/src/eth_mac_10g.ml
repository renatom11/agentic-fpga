(** M05 [Eth_mac_10g] — M03 and M04 bound to one XGMII port pair (SPEC-M05,
    FROZEN at f78766e; §13 is empty).

    This module is its wiring, and the wiring is total: every port of §4.2 is
    connected to exactly one child port or to both children, with **no logic
    between**. It holds no register, adds zero octet times in either direction
    (§7), detects no condition and raises no strobe of its own — the six it
    exposes are its children's, relayed on the same cycle they were raised.

    {b There is no connection between the receive half and the transmit half},
    and that is worth stating rather than leaving to inspection: it is
    REQ-208's structural half at this module, and it is why loopback, pause
    frames and flow control are absent here rather than disabled. The
    [create] below is the diff that would have to change for one to appear.

    Read against SPEC-M05 §6.1's connection table, the correspondence is one
    line per row, in the table's order. *)

open! Base
open Hardcaml

(* ADR-0010: the house consumer convention. M05's ports use [Axi64] and
   [Xgmii] and no other record module. *)
open! Axi64

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

let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
  (* [instance] labels are §6.3 item 1's, not normative; the *module* names
     are, and they are fixed by the children's own [hierarchical] (REQ-808).
     Naming the instances anyway keeps the emitted hierarchy readable and
     keeps M05's two children distinguishable in a waveform. *)
  let rx =
    Xgmii_rx_64.hierarchical
      ~instance:"rx"
      scope
      { Xgmii_rx_64.I.clock = i.clock
      ; clear = i.clear
      ; xgmii_rx = i.xgmii_rx
      ; cfg_rx_enable = i.cfg_rx_enable
      }
  in
  let tx =
    Xgmii_tx_64.hierarchical
      ~instance:"tx"
      scope
      { Xgmii_tx_64.I.clock = i.clock
      ; clear = i.clear
      ; tx = i.tx
      ; cfg_ifg = i.cfg_ifg
      ; cfg_tx_enable = i.cfg_tx_enable
      }
  in
  { O.rx = rx.Xgmii_rx_64.O.rx
  ; tx_dest = tx.Xgmii_tx_64.O.tx_dest
  ; xgmii_tx = tx.Xgmii_tx_64.O.xgmii_tx
  ; error_bad_fcs = rx.Xgmii_rx_64.O.error_bad_fcs
  ; error_bad_frame = rx.Xgmii_rx_64.O.error_bad_frame
  ; error_runt = rx.Xgmii_rx_64.O.error_runt
  ; error_oversize = rx.Xgmii_rx_64.O.error_oversize
  ; error_start_without_terminate = rx.Xgmii_rx_64.O.error_start_without_terminate
  ; error_underflow = tx.Xgmii_tx_64.O.error_underflow
  }
;;

let hierarchical ?instance scope (i : Signal.t I.t) : Signal.t O.t =
  let module H = Hierarchy.In_scope (I) (O) in
  H.hierarchical ?instance ~scope ~name:"eth_mac_10g" create i
;;
