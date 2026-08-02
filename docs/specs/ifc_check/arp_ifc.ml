(* SPEC-M13 §4.1, lifted verbatim into docs/specs/ifc_check/arp_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home. [Arp_eth_rx_ifc] declares
   [Arp_packet] (SPEC-M10 §4.1) and [Arp_cache_ifc] declares the three
   cache records (SPEC-M12 §4.1); M01 is FROZEN at f78766e, so batch D
   declares each new record once at the module that owns it and opens it
   everywhere else (SPEC-M10 §11.2). M13 restates none of them.

   [Arp_query] and [Arp_response] are declared HERE because M13 is what
   answers them: they are the M15 -> M13 -> M15 resolution interface of
   architecture.md §6.4.3, and M15 (batch E) will open this module.

   [Arp_query] has the same SHAPE as [Arp_cache_query] and is a
   different type on purpose. Its [ip] is the datagram's DESTINATION,
   which M13 has not yet classified; [Arp_cache_query]'s [ip] is the
   RESOLUTION TARGET, which is the destination for an on-subnet
   datagram and the gateway for an off-subnet one (REQ-507). Merging
   them would let a future edit connect M15 straight to M12 and skip the
   class evaluation, which is the one thing REQ-507 exists to prevent.

   Receive ports: [rx_payload] is [Axi64.Source] with no [Axi64.Dest]
   anywhere for it, which is REQ-003 structurally and is what REQ-510
   rests on. Transmit ports: [Source] out and [Dest] in on the one
   transmit stream. [tx_hdr] carries no [ready] (ADR-0008). *)

open! Base
open Hardcaml
open! Axi64_ifc
open! Arp_eth_rx_ifc
open! Arp_cache_ifc

module Arp_query = struct
  type 'a t =
    { valid : 'a
    ; ip : 'a [@bits 32]
    }
  [@@deriving hardcaml]
end

module Arp_response = struct
  type 'a t =
    { valid : 'a
    ; found : 'a
    ; mac : 'a [@bits 48]
    }
  [@@deriving hardcaml]
end

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; rx_hdr : 'a Eth_header.t [@rtlprefix "rx_hdr_"]
    ; rx_payload : 'a Axi64.Source.t [@rtlprefix "rx_payload_"]
    ; tx_payload_dest : 'a Axi64.Dest.t [@rtlprefix "tx_payload_"]
    ; tx_query : 'a Arp_query.t [@rtlprefix "tx_query_"]
    ; cfg_local_mac : 'a [@bits 48]
    ; cfg_local_ip : 'a [@bits 32]
    ; cfg_subnet_mask : 'a [@bits 32]
    ; cfg_gateway_ip : 'a [@bits 32]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { tx_hdr : 'a Eth_header.t [@rtlprefix "tx_hdr_"]
    ; tx_payload : 'a Axi64.Source.t [@rtlprefix "tx_payload_"]
    ; tx_response : 'a Arp_response.t [@rtlprefix "tx_response_"]
    ; error_arp_unsupported : 'a
    ; error_arp_miss : 'a
    ; error_arp_reply_dropped : 'a
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

(* REQ-010 type identity on both streams, and a compile-time witness of
   the records on M13's INTERNAL edges (architecture.md §6.4): M10's
   [Arp_packet] on [arp_rx] and [arp_tx], and M12's three records on
   [cache_query], [cache_result] and [cache_write]. Those are signals
   inside M13's hierarchy, not ports, so they appear in neither [I] nor
   [O]; this is what ties the internal vocabulary to the specifications
   that declare it. *)

let _witness_both_directions
      (s : Signal.t Axi64.Source.t)
      (d : Signal.t Axi64.Dest.t)
  =
  s, d
;;

let _witness_internal_edge_types
      (p : Signal.t Arp_packet.t)
      (q : Signal.t Arp_cache_query.t)
      (r : Signal.t Arp_cache_result.t)
      (w : Signal.t Arp_cache_write.t)
  =
  p, q, r, w
;;
