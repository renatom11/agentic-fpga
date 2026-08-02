(* SPEC-M15 §4.1, lifted verbatim into docs/specs/ifc_check/ip_eth_tx_64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64], [Eth_header]
   and [Ip_header] come from there. [Arp_ifc] is where SPEC-M13 §4.1
   declares [Arp_query] and [Arp_response], because M01 is FROZEN at
   f78766e and a record added there would be a breaking post-freeze
   interface change; the declare-once rule batch D adopted is that such a
   record is declared at the module that owns it and OPENED by every
   counterpart (SPEC-M10 §4.1, §11.2; SPEC-M13 §11.5). This is that
   rule's first cross-batch instance and M15 restates neither record.

   Batch E declares NO record of its own. Opening [Arp_ifc] does not
   re-export what THAT file opened, so [Axi64_ifc] is opened here too;
   there is no cycle, because M13's lift references nothing of M15's.

   Transmit-path module, so [Source] one way and [Dest] the other on each
   of the two logical streams: the payload stream's [Source] is an input
   and its [Dest] an output; the body stream's [Source] is an output and
   its [Dest] an input. Each stream's two directions share a prefix with
   no collision, because [Source]'s field names and [Dest]'s are disjoint
   (SPEC-M04 §4.1 fixes that pattern).

   Neither header record carries a [ready]: [hdr]'s acceptance event is
   the acceptance of the frame's first payload word by THIS module, and
   [eth_hdr]'s is the acceptance of the frame's first body word by M09
   (ADR-0008). [arp_query] and [arp_response] carry neither a [ready] nor
   an acceptance event: M13 can never refuse a query (SPEC-M13 §7). *)

open! Base
open Hardcaml
open! Axi64_ifc
open! Arp_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; hdr : 'a Ip_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; eth_payload_dest : 'a Axi64.Dest.t [@rtlprefix "eth_payload_"]
    ; arp_response : 'a Arp_response.t [@rtlprefix "arp_response_"]
    ; cfg_local_mac : 'a [@bits 48]
    ; cfg_local_ip : 'a [@bits 32]
    ; cfg_ttl : 'a [@bits 8]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { payload_dest : 'a Axi64.Dest.t [@rtlprefix "payload_"]
    ; eth_hdr : 'a Eth_header.t [@rtlprefix "eth_hdr_"]
    ; eth_payload : 'a Axi64.Source.t [@rtlprefix "eth_payload_"]
    ; arp_query : 'a Arp_query.t [@rtlprefix "arp_query_"]
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity in both directions of both streams, and a
   compile-time witness that the two resolution records here are the same
   types SPEC-M13 §4.1 declares — the check that the declare-once rule
   held across a batch boundary. *)

let _witness_both_directions
      (s : Signal.t Axi64.Source.t)
      (d : Signal.t Axi64.Dest.t)
  =
  s, d
;;

let _witness_resolution_records_are_m13s
      (q : Signal.t Arp_query.t)
      (r : Signal.t Arp_response.t)
  =
  q, r
;;
