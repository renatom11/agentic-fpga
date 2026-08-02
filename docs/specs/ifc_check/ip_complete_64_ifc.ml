(* SPEC-M16 §4.1, lifted verbatim into
   docs/specs/ifc_check/ip_complete_64_ifc.ml (SPEC-TEMPLATE.md rule 6).
   Records and signatures only — no logic, no implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Ip_header] come from there. M16 restates nothing from SPEC-M06,
   M07, M08, M09, M13, M14 or M15 either: its ports are a subset of
   theirs, and the only thing this record adds is that seven children
   share one clock, one clear and one configuration fan-out.

   Batch E declares NO record, here as at M14 and M15: the declare-once
   rule (SPEC-M10 §4.1, §11.2) is honoured by having nothing to declare.
   M16 does not [open! Arp_ifc] or [open! Ip_eth_rx_64_ifc] either,
   because no record of theirs appears at ITS ports — the ARP query and
   response, the [Arp_packet] and the three cache records are all
   internal signals of M16's hierarchy (§6.1), exactly as M13's own
   children's edges are internal to M13 (architecture.md §6.4). A lift
   that opened a module it does not use would compile and would still be
   a lie about the dependency (SPEC-M12 §4.1's rule).

   [rx], [ip_rx_hdr] and [ip_rx_payload] are the receive ports: [Source]
   with no [Dest] anywhere for them, REQ-003 structurally, inherited
   from M06 and M14. [ip_tx_*] and [tx] are the transmit chain, [Source]
   one way and [Dest] the other, as in SPEC-M07 and SPEC-M09. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; rx : 'a Axi64.Source.t [@rtlprefix "rx_"]
    ; ip_tx_hdr : 'a Ip_header.t [@rtlprefix "ip_tx_hdr_"]
    ; ip_tx_payload : 'a Axi64.Source.t [@rtlprefix "ip_tx_payload_"]
    ; tx_dest : 'a Axi64.Dest.t [@rtlprefix "tx_"]
    ; cfg_local_mac : 'a [@bits 48]
    ; cfg_local_ip : 'a [@bits 32]
    ; cfg_subnet_mask : 'a [@bits 32]
    ; cfg_gateway_ip : 'a [@bits 32]
    ; cfg_multicast_group : 'a [@bits 32]
    ; cfg_multicast_enable : 'a
    ; cfg_ttl : 'a [@bits 8]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { ip_rx_hdr : 'a Ip_header.t [@rtlprefix "ip_rx_hdr_"]
    ; ip_rx_payload : 'a Axi64.Source.t [@rtlprefix "ip_rx_payload_"]
    ; ip_tx_payload_dest : 'a Axi64.Dest.t [@rtlprefix "ip_tx_payload_"]
    ; tx : 'a Axi64.Source.t [@rtlprefix "tx_"]
    ; error_short_frame : 'a
    ; error_unknown_ethertype : 'a
    ; error_arp_unsupported : 'a
    ; error_arp_miss : 'a
    ; error_arp_reply_dropped : 'a
    ; error_ip_bad_header : 'a
    ; error_ip_bad_checksum : 'a
    ; error_ip_fragment : 'a
    ; error_ip_not_for_us : 'a
    ; error_ip_truncated : 'a
    ; error_ip_bad_protocol : 'a
    ; error_ip_oversize : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create
    :  ?retry_count:int
    -> ?retry_interval_cycles:int
    -> ?entry_lifetime_cycles:int
    -> Scope.t
    -> Signal.t I.t
    -> Signal.t O.t

  val hierarchical
    :  ?instance:string
    -> ?retry_count:int
    -> ?retry_interval_cycles:int
    -> ?entry_lifetime_cycles:int
    -> Scope.t
    -> Signal.t I.t
    -> Signal.t O.t
end
