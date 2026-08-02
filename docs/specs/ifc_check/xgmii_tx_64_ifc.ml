(* SPEC-M04 §4.1, lifted verbatim into docs/specs/ifc_check/xgmii_tx_64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1).

   [tx] and [tx_dest] are the two directions of **one** logical stream and
   share the prefix "tx_": the [Source] fields emit tx_tvalid … tx_tuser
   and the [Dest] field emits tx_tready, with no collision because the
   field names are disjoint. This is the transmit-path pattern
   architecture.md §2.3 fixes — [Source] one way, [Dest] the other — and
   it is the only place in Phase 1 where a [Dest] legitimately appears
   beside a frame stream.

   The [Dest] witness at the bottom completes SPEC-M01 §11.4: M03's lift
   names the six [Source] fields, this one names [tready]. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; tx : 'a Axi64.Source.t [@rtlprefix "tx_"]
    ; cfg_ifg : 'a [@bits 8]
    ; cfg_tx_enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { tx_dest : 'a Axi64.Dest.t [@rtlprefix "tx_"]
    ; xgmii_tx : 'a Xgmii.t [@rtlprefix "xgmii_tx"]
    ; error_underflow : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* SPEC-M01 §11.4 field-name witness, Dest half. *)

let _witness_dest_field_names (x : Signal.t Axi64.Dest.t) =
  let open Axi64.Dest in
  [ x.tready ]
;;
