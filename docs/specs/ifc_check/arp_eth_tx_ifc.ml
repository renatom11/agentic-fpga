(* SPEC-M11 §4.1, lifted verbatim into docs/specs/ifc_check/arp_eth_tx_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Eth_header] come from there. [Arp_eth_rx_ifc] is where SPEC-M10 §4.1
   declares [Arp_packet], because M01 is FROZEN and a record added there
   would be a breaking post-freeze interface change; the rule batch D
   adopts is that such a record is declared once, at the module that
   produces it, and opened by every consumer (SPEC-M10 §4.1, §11.2).
   M11 restates nothing.

   Transmit-path module, so [Source] one way and [Dest] the other on the
   one logical stream: the payload stream's [Source] is an output and
   its [Dest] an input. Both directions share the "payload_" prefix with
   no collision, because [Source]'s field names and [Dest]'s are
   disjoint (SPEC-M04 §4.1 fixes that pattern).

   [arp_ready] is a bare output bit and not a field of a [Dest] record.
   ADR-0008's acceptance event — the acceptance of the frame's first
   payload word — does not exist at this port, because the [Arp_packet]
   M11 consumes has no payload stream travelling with it: M11 GENERATES
   the payload. §7 states the substitution and §11.3 flags it for
   dv_lead. [hdr] carries no [ready] for ADR-0008's own reason. *)

open! Base
open Hardcaml
open! Axi64_ifc
open! Arp_eth_rx_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; arp : 'a Arp_packet.t [@rtlprefix "arp_"]
    ; payload_dest : 'a Axi64.Dest.t [@rtlprefix "payload_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { arp_ready : 'a
    ; hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity in both directions of the one stream, and that
   [Arp_packet] here is the same type SPEC-M10 §4.1 declares. *)

let _witness_both_directions
      (s : Signal.t Axi64.Source.t)
      (d : Signal.t Axi64.Dest.t)
  =
  s, d
;;

let _witness_arp_packet_is_m10s (p : Signal.t Arp_packet.t) = p
