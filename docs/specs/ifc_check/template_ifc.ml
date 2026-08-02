(* SPEC-TEMPLATE.md §4.1 example block, lifted verbatim per the template's
   own rule 6. Its presence here proves the compile-check lane works
   end-to-end (hardcaml_axi installs; [@@deriving hardcaml] elaborates)
   before the first real module spec needs it. *)

open! Base
open Hardcaml

(* ---- programme-wide types, defined once in Axi64 (M01) and repeated
   here only in M01's own specification; other specs write
   [open Ifc_check_axi64] instead of restating them. ---- *)

module Axi64_config = struct
  let data_bits = 64
  let user_bits = 1
end

module Axi64 = Hardcaml_axi.Stream.Make (Axi64_config)

module Eth_header = struct
  type 'a t =
    { valid : 'a
    ; dst_mac : 'a [@bits 48]
    ; src_mac : 'a [@bits 48]
    ; ethertype : 'a [@bits 16]
    }
  [@@deriving hardcaml]
end

(* ---- this module ---- *)

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
