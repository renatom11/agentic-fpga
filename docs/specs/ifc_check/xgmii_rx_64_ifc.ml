(* SPEC-M03 §4.1, lifted verbatim into docs/specs/ifc_check/xgmii_rx_64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64], [Xgmii] and
   [Config] come from there and are restated nowhere.

   The witness at the bottom is not circuit logic — this library is never
   instantiated and emits no hardware. It is the compile-time check
   REQ-010's verification column prescribes, extended to name every field
   of [Axi64.Source] so that SPEC-M01 §11.4 is settled by a CI run rather
   than by transcription: if [hardcaml_axi] v0.17.0 spells any of these
   names differently, this file fails to compile and the divergence is
   found before freeze instead of at the first bench. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; xgmii_rx : 'a Xgmii.t [@rtlprefix "xgmii_rx"]
    ; cfg_rx_enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { rx : 'a Axi64.Source.t [@rtlprefix "rx_"]
    ; error_bad_fcs : 'a
    ; error_bad_frame : 'a
    ; error_runt : 'a
    ; error_oversize : 'a
    ; error_start_without_terminate : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity, and the SPEC-M01 §11.4 field-name witness. *)

let _witness_source_is_the_programme_type (x : Signal.t Axi64.Source.t) = x

let _witness_source_field_names (x : Signal.t Axi64.Source.t) =
  let open Axi64.Source in
  [ x.tvalid; x.tdata; x.tkeep; x.tstrb; x.tlast; x.tuser ]
;;
