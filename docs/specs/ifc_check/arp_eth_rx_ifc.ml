(* SPEC-M10 §4.1, lifted verbatim into docs/specs/ifc_check/arp_eth_rx_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Eth_header] come from there and are restated nowhere.

   [Arp_packet] is declared HERE and not in M01. M01 is FROZEN at
   f78766e; adding a record to its §4.1 would be a breaking interface
   change to a frozen specification and would invalidate the compile
   evidence five freeze records cite (SPEC-TEMPLATE rule 7, charter §6).
   The rule batch D adopts for a record M01 does not carry is therefore:
   it is declared once, in the specification of the module that
   PRODUCES it, and every consumer opens that module. M10 produces
   [Arp_packet] (architecture.md §6.4.1), so SPEC-M11 §4.1 and SPEC-M13
   §4.1 write [open! Arp_eth_rx_ifc] and restate nothing. §11.2 tracks
   the promotion of the batch-D records into M01 if a later phase
   reopens it.

   Receive-path module: [payload] is [Axi64.Source] with no [Axi64.Dest]
   anywhere, and [Arp_packet] carries a [valid] and no [ready] — both
   for the same reason, that nothing on this path may stall its producer
   (REQ-003). That is also why REQ-510's remedy for a reply that cannot
   be sent is to drop the reply and never the packet. *)

open! Base
open Hardcaml
open! Axi64_ifc

module Arp_packet = struct
  type 'a t =
    { valid : 'a
    ; operation : 'a [@bits 16]
    ; sender_mac : 'a [@bits 48]
    ; sender_ip : 'a [@bits 32]
    ; target_mac : 'a [@bits 48]
    ; target_ip : 'a [@bits 32]
    }
  [@@deriving hardcaml]
end

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { arp : 'a Arp_packet.t [@rtlprefix "arp_"]
    ; error_arp_unsupported : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity at the one stream port, and the first
   compile-time witness of [Arp_packet]'s six field names. *)

let _witness_stream_is_the_programme_type (x : Signal.t Axi64.Source.t) = x

let _witness_arp_packet_field_names (p : Signal.t Arp_packet.t) =
  let open Arp_packet in
  [ p.valid; p.operation; p.sender_mac; p.sender_ip; p.target_mac; p.target_ip ]
;;
