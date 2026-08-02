(* SPEC-M14 §4.1, lifted verbatim into docs/specs/ifc_check/ip_eth_rx_64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64], [Eth_header]
   and [Ip_header] all come from there and are restated nowhere. Batch E
   declares NO new record: the declare-once rule batch D adopted
   (SPEC-M10 §4.1, §11.2) is honoured here by having nothing to declare,
   because M01 froze [Ip_header] at f78766e and this module's two header
   ports are exactly M01's two records. Nothing in a FROZEN §4.1 is
   touched, and the batch-A/B compile evidence still witnesses both.

   Receive-path module: [payload] and [ip_payload] are [Axi64.Source]
   and there is no [Axi64.Dest] anywhere in either record, which is
   REQ-003 structurally. Both header records carry a [valid] and no
   [ready] for the same reason: on this path nothing may stall its
   producer. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; cfg_local_ip : 'a [@bits 32]
    ; cfg_subnet_mask : 'a [@bits 32]
    ; cfg_multicast_group : 'a [@bits 32]
    ; cfg_multicast_enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { ip_hdr : 'a Ip_header.t [@rtlprefix "ip_hdr_"]
    ; ip_payload : 'a Axi64.Source.t [@rtlprefix "ip_payload_"]
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
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity at both stream ports, and the first compile-time
   witness that [Ip_header]'s seven field names are what SPEC-M01 §4.2
   writes — the record was frozen with no user until this batch. *)

let _witness_streams_are_the_programme_type
      (x : Signal.t Axi64.Source.t)
      (y : Signal.t Axi64.Source.t)
  =
  x, y
;;

let _witness_ip_header_field_names (h : Signal.t Ip_header.t) =
  let open Ip_header in
  [ h.valid; h.src_ip; h.dst_ip; h.protocol; h.ttl; h.dscp; h.total_length ]
;;
