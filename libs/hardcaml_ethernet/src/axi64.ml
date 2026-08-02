(** M01 [Axi64] — the programme's vocabulary module: the types every other
    module's port record is built from (SPEC-M01, FROZEN at f78766e).

    Types only. M01 instantiates no logic, declares no port and appears in no
    instance hierarchy, so it has no [create], no [hierarchical] and no
    entry in {!rtl_snapshots} (REQ-808, REQ-903, SPEC-M01 §4.1). What it does
    have is an [.mli]: that file fixes which records are exported and at what
    widths, which is the surface every other module's REQ-010 compile check
    binds to (REQ-903's [.mli] half, carry-forward C-8).

    The record blocks below are SPEC-M01 §4.1 as frozen, field for field and
    width for width, and are byte-identical to the compile-checked lift
    [docs/specs/ifc_check/axi64_ifc.ml]. Field names and widths here are
    normative, not stylistic: REQ-010 exists to stop nineteen modules growing
    nineteen dialects of one agreement. A change to any of them is a spec diff
    to SPEC-M01 §4.1, not an edit to this file. *)

(* [open!] rather than [open] on both lines below: this module declares no
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

(* ---- the XGMII lane pair (REQ-017, REQ-018) ----
   One record for one direction. The field names are IEEE 802.3's
   [RXD]/[RXC], lower-cased to [d] and [c], so that the instantiation
   prefixes [@rtlprefix "xgmii_rx"] and [@rtlprefix "xgmii_tx"] emit
   exactly [xgmii_rxd], [xgmii_rxc], [xgmii_txd], [xgmii_txc] — the four
   port names REQ-017 fixes. Longer field names cannot produce them.
   [c] bit k is the control indication for lane k, whose octet is
   [d][8k+7:8k]: the same octet-position convention [tdata] uses
   (REQ-012, §6.1). *)

module Xgmii = struct
  type 'a t =
    { d : 'a [@bits 64]
    ; c : 'a [@bits 8]
    }
  [@@deriving hardcaml]
end

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
