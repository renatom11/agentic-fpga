(* SPEC-M19 §4.1, lifted verbatim into
   docs/specs/ifc_check/udp_complete_64_ifc.ml (SPEC-TEMPLATE.md rule 6).
   Records and signatures only — no logic, no implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Udp_header] come from there. [Udp_ip_tx_64_ifc] is where SPEC-M18
   §4.1 declares [Udp_tx_request], because M01 is FROZEN at f78766e and a
   record added there would be a breaking post-freeze interface change;
   the declare-once rule batch D adopted is that such a record is declared
   at the module that owns it and OPENED by every counterpart (SPEC-M10
   §4.1, §11.2; SPEC-M15 §4.1 is its first cross-batch instance). Opening
   [Udp_ip_tx_64_ifc] does not re-export what THAT file opened, so
   [Axi64_ifc] is opened here too; there is no cycle, because M18's lift
   references nothing of M19's.

   M19 restates nothing from SPEC-M16 or SPEC-M17 either: its ports are a
   subset of theirs, and the only thing this record adds is that three
   children share one clock, one clear and one configuration fan-out.
   M19 does NOT open [Ip_complete_64_ifc] or [Udp_ip_rx_64_ifc], because
   no record of theirs appears at ITS ports — the IPv4 header pair between
   M16 and M17, and the IPv4 pair between M18 and M16, are internal
   signals of M19's hierarchy (§6.1), exactly as M13's and M16's own
   children's edges are internal to them (architecture.md §6.4). A lift
   that opened a module it does not use would compile and would still be
   a lie about the dependency (SPEC-M12 §4.1's rule).

   [rx], [app_rx_hdr] and [app_rx_payload] are the receive ports:
   [Source] with no [Dest] anywhere for them, REQ-003 structurally,
   inherited from M16 and M17 — and at [app_rx_payload] this is also
   REQ-707 and REQ-805. [app_tx_*] and [tx] are the transmit chain,
   [Source] one way and [Dest] the other, as in SPEC-M16 and SPEC-M18. *)

open! Base
open Hardcaml
open! Axi64_ifc
open! Udp_ip_tx_64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; rx : 'a Axi64.Source.t [@rtlprefix "rx_"]
    ; app_tx_request : 'a Udp_tx_request.t [@rtlprefix "app_tx_request_"]
    ; app_tx_payload : 'a Axi64.Source.t [@rtlprefix "app_tx_payload_"]
    ; tx_dest : 'a Axi64.Dest.t [@rtlprefix "tx_"]
    ; cfg_local_mac : 'a [@bits 48]
    ; cfg_local_ip : 'a [@bits 32]
    ; cfg_subnet_mask : 'a [@bits 32]
    ; cfg_gateway_ip : 'a [@bits 32]
    ; cfg_multicast_group : 'a [@bits 32]
    ; cfg_multicast_enable : 'a
    ; cfg_listen_port : 'a [@bits 16]
    ; cfg_accept_all_ports : 'a
    ; cfg_ttl : 'a [@bits 8]
    ; cfg_tx_enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { app_rx_hdr : 'a Udp_header.t [@rtlprefix "app_rx_hdr_"]
    ; app_rx_payload : 'a Axi64.Source.t [@rtlprefix "app_rx_payload_"]
    ; app_tx_payload_dest : 'a Axi64.Dest.t [@rtlprefix "app_tx_payload_"]
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
    ; error_udp_bad_length : 'a
    ; error_udp_port : 'a
    ; error_tx_length_mismatch : 'a
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
