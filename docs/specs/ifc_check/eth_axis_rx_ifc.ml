(* SPEC-M06 §4.1, lifted verbatim into docs/specs/ifc_check/eth_axis_rx_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Eth_header] come from there and are restated nowhere. This is the
   first specification to use [Eth_header], and it uses it unchanged —
   the record was frozen at f78766e and batch C adds no field to it.

   Receive-path module: [rx] and [payload] are [Axi64.Source] and there
   is no [Axi64.Dest] anywhere in either record, which is REQ-003
   structurally. The [Eth_header] carries a [valid] and no [ready] for
   the same reason: on this path nothing may stall its producer. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; rx : 'a Axi64.Source.t [@rtlprefix "rx_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; error_short_frame : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity at both stream ports, and the first compile-time
   witness that [Eth_header]'s field names are what SPEC-M01 §4.2 writes. *)

let _witness_streams_are_the_programme_type
      (x : Signal.t Axi64.Source.t)
      (y : Signal.t Axi64.Source.t)
  =
  x, y
;;

let _witness_eth_header_field_names (h : Signal.t Eth_header.t) =
  let open Eth_header in
  [ h.valid; h.dst_mac; h.src_mac; h.ethertype ]
;;
