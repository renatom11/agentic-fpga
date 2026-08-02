(* SPEC-M09 §4.1, lifted verbatim into docs/specs/ifc_check/eth_arb_mux_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Eth_header] come from there and are restated nowhere.

   Transmit-path module with two input ports and one output port, so
   [Source] one way and [Dest] the other on each of the three logical
   streams: the two inputs' [Source]s are inputs and their [Dest]s are
   outputs, and the output stream is the reverse. Each stream's two
   directions share a prefix, with no collision because [Source]'s field
   names and [Dest]'s are disjoint (SPEC-M04 §4.1 fixes that pattern).

   A port requests by asserting its [Eth_header]'s [valid] together with
   its first payload word, and holds both until that word is accepted
   (ADR-0008). That is why no [ready] appears beside a header record
   here: acceptance of the first payload word IS the grant, observable on
   one wire that already exists. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; arp_hdr : 'a Eth_header.t [@rtlprefix "arp_hdr_"]
    ; arp_payload : 'a Axi64.Source.t [@rtlprefix "arp_payload_"]
    ; ip_hdr : 'a Eth_header.t [@rtlprefix "ip_hdr_"]
    ; ip_payload : 'a Axi64.Source.t [@rtlprefix "ip_payload_"]
    ; payload_dest : 'a Axi64.Dest.t [@rtlprefix "payload_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { arp_payload_dest : 'a Axi64.Dest.t [@rtlprefix "arp_payload_"]
    ; ip_payload_dest : 'a Axi64.Dest.t [@rtlprefix "ip_payload_"]
    ; hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity on all three streams, both directions. *)

let _witness_three_sources_and_three_dests
      (a : Signal.t Axi64.Source.t)
      (b : Signal.t Axi64.Source.t)
      (c : Signal.t Axi64.Source.t)
      (d : Signal.t Axi64.Dest.t)
  =
  a, b, c, d
;;
