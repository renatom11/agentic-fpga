(* SPEC-M07 §4.1, lifted verbatim into docs/specs/ifc_check/eth_axis_tx_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Eth_header] come from there and are restated nowhere.

   Transmit-path module, so [Source] one way and [Dest] the other on each
   of the two logical streams. The payload stream's [Source] is an input
   and its [Dest] an output; the frame stream's [Source] is an output and
   its [Dest] an input. The two directions of one stream share a prefix —
   "payload_" and "tx_" — with no collision, because [Source]'s field
   names and [Dest]'s are disjoint (SPEC-M04 §4.1 fixes that pattern).

   [hdr] carries no [ready]: its acceptance event is the acceptance of
   the frame's first payload word (ADR-0008), which is what lets M01's
   [Eth_header] serve both datapath directions unchanged. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; tx_dest : 'a Axi64.Dest.t [@rtlprefix "tx_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { payload_dest : 'a Axi64.Dest.t [@rtlprefix "payload_"]
    ; tx : 'a Axi64.Source.t [@rtlprefix "tx_"]
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity in both directions of both streams. *)

let _witness_both_directions
      (s : Signal.t Axi64.Source.t)
      (d : Signal.t Axi64.Dest.t)
  =
  s, d
;;
