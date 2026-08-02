(* SPEC-M08 §4.1, lifted verbatim into docs/specs/ifc_check/eth_demux_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Eth_header] come from there and are restated nowhere.

   Receive-path module: three [Axi64.Source] ports and no [Axi64.Dest]
   anywhere, which is REQ-003 structurally. A demultiplexer is the module
   at which a designer is most tempted to add backpressure — "stall the
   input while the slow port drains" — and the absence of the type is
   what makes that a spec diff rather than a decision. *)

open! Base
open Hardcaml
open! Axi64_ifc

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
    { ip_hdr : 'a Eth_header.t [@rtlprefix "ip_hdr_"]
    ; ip_payload : 'a Axi64.Source.t [@rtlprefix "ip_payload_"]
    ; arp_hdr : 'a Eth_header.t [@rtlprefix "arp_hdr_"]
    ; arp_payload : 'a Axi64.Source.t [@rtlprefix "arp_payload_"]
    ; error_unknown_ethertype : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity at all three stream ports. *)

let _witness_streams_are_the_programme_type
      (a : Signal.t Axi64.Source.t)
      (b : Signal.t Axi64.Source.t)
      (c : Signal.t Axi64.Source.t)
  =
  a, b, c
;;
