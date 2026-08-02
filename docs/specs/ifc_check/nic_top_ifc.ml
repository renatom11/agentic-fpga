(* SPEC-M20 §4.1, lifted verbatim into docs/specs/ifc_check/nic_top_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64], [Xgmii],
   [Udp_header], [Config] and [Status] all come from there and are
   restated nowhere. This is the ONLY module in the programme whose ports
   carry [Config] and [Status]: REQ-802 and REQ-804 make the records
   top-level, every module below reads scalars, and one port each is what
   keeps requirements.md §9.1 and §12 single statements.
   [Udp_ip_tx_64_ifc] is where SPEC-M18 §4.1 declares [Udp_tx_request];
   opening it does not re-export what THAT file opened, so [Axi64_ifc] is
   opened here too, and there is no cycle because M18's lift references
   nothing of M20's.

   M20 does NOT open [Eth_mac_10g_ifc] or [Udp_complete_64_ifc]: no
   record of theirs appears at ITS ports, because both children's ports
   are a subset of the types above (SPEC-M12 §4.1's rule — a lift that
   opened a module it does not use would compile and would still be a lie
   about the dependency).

   REQ-017 is a property of THIS record and is checkable by reading it:
   the only wire-side ports are the two [Xgmii] lane pairs, whose
   [@rtlprefix] values emit exactly [xgmii_rxd], [xgmii_rxc],
   [xgmii_txd] and [xgmii_txc]. Every other field is clock, clear,
   configuration, an application stream or status.

   [app_rx_hdr] and [app_rx_payload] are [Source] with no [Dest]
   anywhere — REQ-003, REQ-707 and REQ-805 structurally, at the port the
   Phase-2 feed handler attaches to. [app_tx_*] is the transmit
   direction, [Source] one way and [Dest] the other. *)

open! Base
open Hardcaml
open! Axi64_ifc
open! Udp_ip_tx_64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; xgmii_rx : 'a Xgmii.t [@rtlprefix "xgmii_rx"]
    ; cfg : 'a Config.t [@rtlprefix "cfg_"]
    ; app_tx_request : 'a Udp_tx_request.t [@rtlprefix "app_tx_request_"]
    ; app_tx_payload : 'a Axi64.Source.t [@rtlprefix "app_tx_payload_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { xgmii_tx : 'a Xgmii.t [@rtlprefix "xgmii_tx"]
    ; app_rx_hdr : 'a Udp_header.t [@rtlprefix "app_rx_hdr_"]
    ; app_rx_payload : 'a Axi64.Source.t [@rtlprefix "app_rx_payload_"]
    ; app_tx_payload_dest : 'a Axi64.Dest.t [@rtlprefix "app_tx_payload_"]
    ; status : 'a Status.t [@rtlprefix "status_"]
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

(* REQ-802 and REQ-804 compile-time witnesses: [Config]'s twelve field
   names in requirements.md §9.1's order and [Status]'s twenty-one in
   §12's order, neither of which had a user until this module — the same
   position [Ip_header] was in until batch E and [Udp_header] until
   SPEC-M17. tools/check_records_vs_appendix.sh checks both lists against
   the requirements document; these two functions are what make a rename
   in SPEC-M01 §4.1 fail to COMPILE as well. *)

let _witness_config_field_names (c : Signal.t Config.t) =
  let open Config in
  [ c.local_mac
  ; c.local_ip
  ; c.subnet_mask
  ; c.gateway_ip
  ; c.multicast_group
  ; c.multicast_enable
  ; c.listen_port
  ; c.accept_all_ports
  ; c.ttl
  ; c.ifg
  ; c.rx_enable
  ; c.tx_enable
  ]
;;

let _witness_status_field_names (s : Signal.t Status.t) =
  let open Status in
  [ s.error_bad_fcs
  ; s.error_bad_frame
  ; s.error_runt
  ; s.error_oversize
  ; s.error_start_without_terminate
  ; s.error_underflow
  ; s.error_short_frame
  ; s.error_unknown_ethertype
  ; s.error_arp_unsupported
  ; s.error_arp_miss
  ; s.error_arp_reply_dropped
  ; s.error_ip_bad_header
  ; s.error_ip_bad_checksum
  ; s.error_ip_fragment
  ; s.error_ip_not_for_us
  ; s.error_ip_truncated
  ; s.error_ip_bad_protocol
  ; s.error_ip_oversize
  ; s.error_udp_bad_length
  ; s.error_udp_port
  ; s.error_tx_length_mismatch
  ]
;;
