(* SPEC-M18 §4.1, lifted verbatim into docs/specs/ifc_check/udp_ip_tx_64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64] and
   [Ip_header] come from there and are restated nowhere.

   [Udp_tx_request] is DECLARED HERE and is batch F's only new record.
   The declare-once rule batch D adopted (SPEC-M10 §4.1, §11.2) puts a
   record in the specification of the module that OWNS it and has every
   counterpart [open!] that module: REQ-705 makes the transmit request
   this module's, so it is declared here and SPEC-M19 and SPEC-M20 open
   [Udp_ip_tx_64_ifc] for it. It is not added to M01, which is FROZEN at
   f78766e; a record added there would be a breaking post-freeze
   interface change to the specification five freeze records cite.

   The request carries a [valid] and NO [ready]: its acceptance event is
   the acceptance of the frame's first application payload word by THIS
   module, which is ADR-0008's decision 3 applied one port further out
   than batch C applied it. [payload_length] counts UDP PAYLOAD octets
   only — not the UDP header and no lower-layer header (REQ-705) — which
   is the one field of this record a reader can get wrong, so its width
   and its unit are both stated here and in §4.2.

   Transmit-path module, so [Source] one way and [Dest] the other on each
   of the two logical streams: the application stream's [Source] is an
   input and its [Dest] an output; the output stream's [Source] is an
   output and its [Dest] an input. Each stream's two directions share a
   prefix with no collision, because [Source]'s field names and [Dest]'s
   are disjoint (SPEC-M04 §4.1 fixes that pattern). *)

open! Base
open Hardcaml
open! Axi64_ifc

module Udp_tx_request = struct
  type 'a t =
    { valid : 'a
    ; dst_ip : 'a [@bits 32]
    ; dst_port : 'a [@bits 16]
    ; src_port : 'a [@bits 16]
    ; payload_length : 'a [@bits 16]
    }
  [@@deriving hardcaml]
end

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; request : 'a Udp_tx_request.t [@rtlprefix "request_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; ip_payload_dest : 'a Axi64.Dest.t [@rtlprefix "ip_payload_"]
    ; cfg_tx_enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { payload_dest : 'a Axi64.Dest.t [@rtlprefix "payload_"]
    ; ip_hdr : 'a Ip_header.t [@rtlprefix "ip_hdr_"]
    ; ip_payload : 'a Axi64.Source.t [@rtlprefix "ip_payload_"]
    ; error_tx_length_mismatch : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity in both directions of both streams. No witness is
   written for [Ip_header]'s field names: SPEC-M14 §4.1's lift names all
   seven and settles them once (SPEC-M16 §4.1's rule for the same
   omission). *)

let _witness_both_directions
      (s : Signal.t Axi64.Source.t)
      (d : Signal.t Axi64.Dest.t)
  =
  s, d
;;
