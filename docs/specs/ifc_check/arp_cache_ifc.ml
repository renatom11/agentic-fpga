(* SPEC-M12 §4.1, lifted verbatim into docs/specs/ifc_check/arp_cache_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   The three records below are declared HERE and not in M01, which is
   FROZEN at f78766e: adding a record to M01 §4.1 would be a breaking
   post-freeze interface change (SPEC-TEMPLATE rule 7, charter §6). The
   rule batch D adopts is that such a record is declared once, at the
   module that owns its vocabulary, and opened by every counterpart —
   SPEC-M10 §4.1 states it in full and SPEC-M13 §4.1 writes
   [open! Arp_cache_ifc] and restates nothing. M12 owns the query and
   write vocabulary because M12 is what defines what a query and a write
   MEAN; M13 is the only module that speaks it.

   No [Axi64] type appears: M12 carries no stream. It does not
   [open! Axi64_ifc] either, because it references nothing from it —
   a lift that opened a module it does not use would compile and would
   still be a lie about the dependency.

   Neither the query port nor the write port carries a [ready]: M12 can
   never refuse either (§7), so no acceptance event exists and none is
   invented. *)

open! Base
open Hardcaml

module Arp_cache_query = struct
  type 'a t =
    { valid : 'a
    ; ip : 'a [@bits 32]
    }
  [@@deriving hardcaml]
end

module Arp_cache_result = struct
  type 'a t =
    { valid : 'a
    ; hit : 'a
    ; mac : 'a [@bits 48]
    }
  [@@deriving hardcaml]
end

module Arp_cache_write = struct
  type 'a t =
    { valid : 'a
    ; ip : 'a [@bits 32]
    ; mac : 'a [@bits 48]
    }
  [@@deriving hardcaml]
end

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; query : 'a Arp_cache_query.t [@rtlprefix "query_"]
    ; write : 'a Arp_cache_write.t [@rtlprefix "write_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t = { result : 'a Arp_cache_result.t [@rtlprefix "result_"] }
  [@@deriving hardcaml]
end

module type S = sig
  val create : ?entry_lifetime_cycles:int -> Scope.t -> Signal.t I.t -> Signal.t O.t

  val hierarchical
    :  ?instance:string
    -> ?entry_lifetime_cycles:int
    -> Scope.t
    -> Signal.t I.t
    -> Signal.t O.t
end

(* Compile-time witness of the three record field names §4.2 tabulates. *)

let _witness_field_names
      (q : Signal.t Arp_cache_query.t)
      (r : Signal.t Arp_cache_result.t)
      (w : Signal.t Arp_cache_write.t)
  =
  [ q.Arp_cache_query.valid
  ; q.Arp_cache_query.ip
  ; r.Arp_cache_result.valid
  ; r.Arp_cache_result.hit
  ; r.Arp_cache_result.mac
  ; w.Arp_cache_write.valid
  ; w.Arp_cache_write.ip
  ; w.Arp_cache_write.mac
  ]
;;
