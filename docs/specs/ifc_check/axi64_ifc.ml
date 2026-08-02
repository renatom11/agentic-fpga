(* SPEC-M01 §4.1, lifted verbatim into docs/specs/ifc_check/axi64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   This file is the programme's single types home: every other module
   spec's lift writes [open! Axi64_ifc] and restates none of these
   records. M01 declares no [I], no [O] and no [module type S], because it
   has no circuit and therefore no ports and no entry points (§4.2, §6.2).

   [open!] rather than [open] on both lines below: this file declares no
   entry point, so neither [Base] nor [Hardcaml] is necessarily referenced
   outside the code [@@deriving hardcaml] generates. *)

open! Base
open! Hardcaml

(* ---- the stream fabric (REQ-002, REQ-010) ----
   [Hardcaml_axi.Stream.Make] yields
     Axi64.Source = { tvalid; tdata; tkeep; tstrb; tlast; tuser }
     Axi64.Dest   = { tready }
   A receive-path port carries [Axi64.Source] alone; the absence of a
   matching [Dest] is how REQ-003 is enforced structurally. *)

module Axi64_config = struct
  let data_bits = 64
  let user_bits = 1
end

module Axi64 = Hardcaml_axi.Stream.Make (Axi64_config)

(* ---- header records: numeric values, network byte order already
   decoded (REQ-012, REQ-409) ---- *)

module Eth_header = struct
  type 'a t =
    { valid : 'a
    ; dst_mac : 'a [@bits 48]
    ; src_mac : 'a [@bits 48]
    ; ethertype : 'a [@bits 16]
    }
  [@@deriving hardcaml]
end

module Ip_header = struct
  type 'a t =
    { valid : 'a
    ; src_ip : 'a [@bits 32]
    ; dst_ip : 'a [@bits 32]
    ; protocol : 'a [@bits 8]
    ; ttl : 'a [@bits 8]
    ; dscp : 'a [@bits 6]
    ; total_length : 'a [@bits 16]
    }
  [@@deriving hardcaml]
end

module Udp_header = struct
  type 'a t =
    { valid : 'a
    ; src_port : 'a [@bits 16]
    ; dst_port : 'a [@bits 16]
    ; length : 'a [@bits 16]
    ; checksum : 'a [@bits 16]
    }
  [@@deriving hardcaml]
end

(* ---- configuration (REQ-802). Widths here; reset values and permitted
   ranges are requirements.md §9.1 and are not restated. Instantiated with
   [@rtlprefix "cfg_"], which is what makes REQ-802's [cfg_ifg] name
   true. ---- *)

module Config = struct
  type 'a t =
    { local_mac : 'a [@bits 48]
    ; local_ip : 'a [@bits 32]
    ; subnet_mask : 'a [@bits 32]
    ; gateway_ip : 'a [@bits 32]
    ; multicast_group : 'a [@bits 32]
    ; multicast_enable : 'a
    ; listen_port : 'a [@bits 16]
    ; accept_all_ports : 'a
    ; ttl : 'a [@bits 8]
    ; ifg : 'a [@bits 8]
    ; rx_enable : 'a
    ; tx_enable : 'a
    }
  [@@deriving hardcaml]
end

(* ---- status (REQ-804): one field per strobe of requirements.md §12,
   named exactly as §12 names it, in §12's order. Twenty-one fields for
   twenty-one conditions. ---- *)

module Status = struct
  type 'a t =
    { error_bad_fcs : 'a
    ; error_bad_frame : 'a
    ; error_runt : 'a
    ; error_oversize : 'a
    ; error_start_without_terminate : 'a
    ; error_underflow : 'a
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
