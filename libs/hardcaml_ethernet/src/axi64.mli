(** M01 [Axi64] — the exported surface of the programme's vocabulary module
    (SPEC-M01 §4.1, FROZEN at f78766e).

    REQ-903 requires this file and excuses M01, and only M01, from the
    [hierarchical] entry point: M01 is types-only, so there is nothing to
    instantiate and nothing to emit (REQ-808). Everything SPEC-M01 §4.1
    declares is exported here and nothing else is; the widths live in the
    implementation's [@bits] attributes, which [@@deriving hardcaml] carries
    into each record's [port_names_and_widths].

    [@bits] attributes are deliberately absent below: in a signature the
    deriver does not consume them, and an unconsumed attribute is a
    compile error. The widths are the implementation's, checked against
    SPEC-M01 §4.1 by the interface compile check (ADR-0005). *)

open! Base
open! Hardcaml

(** REQ-002, REQ-013: the two functor arguments of the one [Stream.Make]
    application this programme makes. Neither is overridable — a run at
    another width is not a run of this programme (SPEC-M01 §5). *)
module Axi64_config : sig
  val data_bits : int
  val user_bits : int
end

(** REQ-010: the programme stream type. [Axi64.Source] and [Axi64.Dest] are
    distinct records, which is how a receive-path port is declared with no
    [tready] in it (REQ-003).

    [module type of struct include ... end] rather than a hand-written
    signature: the field names and the generated [Interface] surface are
    [hardcaml_axi]'s, and restating them here would create a second place for
    them to drift from the library — the exact failure REQ-010 exists to
    prevent. *)
module Axi64 : module type of struct
  include Hardcaml_axi.Stream.Make (Axi64_config)
end

(** REQ-017: one XGMII lane pair, one direction. [d] is 64 bits (lane k at
    [d\[8k+7:8k\]], lane 0 the earlier octet on the wire); [c] is 8 bits, bit
    k marking lane k as a control character. *)
module Xgmii : sig
  type 'a t =
    { d : 'a
    ; c : 'a
    }
  [@@deriving hardcaml]
end

(** REQ-012, REQ-409: header fields as numeric values, network byte order
    already decoded. *)
module Eth_header : sig
  type 'a t =
    { valid : 'a
    ; dst_mac : 'a
    ; src_mac : 'a
    ; ethertype : 'a
    }
  [@@deriving hardcaml]
end

module Ip_header : sig
  type 'a t =
    { valid : 'a
    ; src_ip : 'a
    ; dst_ip : 'a
    ; protocol : 'a
    ; ttl : 'a
    ; dscp : 'a
    ; total_length : 'a
    }
  [@@deriving hardcaml]
end

module Udp_header : sig
  type 'a t =
    { valid : 'a
    ; src_port : 'a
    ; dst_port : 'a
    ; length : 'a
    ; checksum : 'a
    }
  [@@deriving hardcaml]
end

(** REQ-802: exactly the twelve fields of requirements.md §9.1, at §9.1's
    widths and in §9.1's order. Instantiated [@rtlprefix "cfg_"] at every
    site, which is what makes REQ-802's [cfg_ifg] port name true. *)
module Config : sig
  type 'a t =
    { local_mac : 'a
    ; local_ip : 'a
    ; subnet_mask : 'a
    ; gateway_ip : 'a
    ; multicast_group : 'a
    ; multicast_enable : 'a
    ; listen_port : 'a
    ; accept_all_ports : 'a
    ; ttl : 'a
    ; ifg : 'a
    ; rx_enable : 'a
    ; tx_enable : 'a
    }
  [@@deriving hardcaml]
end

(** REQ-804: one one-bit field per strobe of requirements.md §12, named as
    §12 names it, in §12's order. Twenty-one fields for twenty-one
    conditions. *)
module Status : sig
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
