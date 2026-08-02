(* SPEC-M17 §4.1, lifted verbatim into docs/specs/ifc_check/udp_ip_rx_64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64], [Ip_header]
   and [Udp_header] all come from there and are restated nowhere. M17
   declares NO record: M01 froze [Udp_header] at f78766e with no user
   until this batch, and this module's two header ports are exactly M01's
   two records. Batch F declares one record in total and it is M18's
   ([Udp_tx_request], SPEC-M18 §4.1, at the module REQ-705 makes its
   owner), under the declare-once rule batch D adopted (SPEC-M10 §4.1,
   §11.2).

   Receive-path module: [ip_payload] and [payload] are [Axi64.Source] and
   there is no [Axi64.Dest] anywhere in either record, which is REQ-003
   structurally — and this is the port at which REQ-805's obligation on
   the Phase-2 consumer becomes a statement about the type. Both header
   records carry a [valid] and no [ready] for the same reason.

   The input pair carries the [ip_] prefix and the output pair is bare —
   the mirror image of M14, whose inputs are bare and whose outputs carry
   [ip_] (SPEC-M14 §4.1). Either arrangement keeps the emitted names
   distinct inside one Verilog module, which is the property that matters;
   architecture.md §6.4.1 gave M17 this shape before either spec existed,
   so this batch confirms those rows rather than amending them. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; ip_hdr : 'a Ip_header.t [@rtlprefix "ip_hdr_"]
    ; ip_payload : 'a Axi64.Source.t [@rtlprefix "ip_payload_"]
    ; cfg_listen_port : 'a [@bits 16]
    ; cfg_accept_all_ports : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { hdr : 'a Udp_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; error_udp_bad_length : 'a
    ; error_udp_port : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity at both stream ports, and the first compile-time
   witness that [Udp_header]'s five field names are what SPEC-M01 §4.2
   writes — the record was frozen at f78766e with no user until this
   batch, exactly as [Ip_header] was until batch E (SPEC-M14 §4.1). *)

let _witness_streams_are_the_programme_type
      (x : Signal.t Axi64.Source.t)
      (y : Signal.t Axi64.Source.t)
  =
  x, y
;;

let _witness_udp_header_field_names (h : Signal.t Udp_header.t) =
  let open Udp_header in
  [ h.valid; h.src_port; h.dst_port; h.length; h.checksum ]
;;
