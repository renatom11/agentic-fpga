(* SPEC-M02 §4.1, lifted verbatim into docs/specs/ifc_check/crc32_eth_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1). M02 takes no record
   from it: REQ-306 makes M02 a pure function of a word, an octet count
   and a running CRC, so it has no stream port and no configuration port.
   The [open!] is here so that this lift, like every other in this
   directory, has exactly one place to obtain a shared type from and
   cannot grow a second [Axi64_config]; [data] below is one [Axi64] word
   wide (REQ-002, SPEC-M01 §5).

   No [clock] and no [clear]: REQ-306. No [Config]: §4.3. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { crc_in : 'a [@bits 32]
    ; data : 'a [@bits 64]
    ; octet_count : 'a [@bits 4]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t = { crc_out : 'a [@bits 32] }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end
