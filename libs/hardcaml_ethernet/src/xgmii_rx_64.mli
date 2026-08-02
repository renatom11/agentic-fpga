(** M03 [Xgmii_rx_64] — the exported surface of the XGMII receive decode
    (SPEC-M03 §4.1, FROZEN at f78766e).

    {b The line-rate invariant is structural here, not behavioural.} There is
    no [tready] in {!I} and no [Axi64.Dest] in {!O}: M06 cannot stall M03 and
    an XGMII word is accepted on every cycle unconditionally (REQ-003,
    REQ-112). A future revision that wanted backpressure could not be written
    without changing these records, which is a spec diff to SPEC-M03 §4.

    [@bits] attributes are deliberately absent below: in a signature the
    deriver does not consume them, and an unconsumed attribute is a compile
    error. The widths are the implementation's and are SPEC-M03 §4.2's. *)

open! Base
open Hardcaml
open! Axi64

module I : sig
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; xgmii_rx : 'a Xgmii.t
    ; cfg_rx_enable : 'a
    }
  [@@deriving hardcaml]
end

module O : sig
  type 'a t =
    { rx : 'a Axi64.Source.t
    ; error_bad_fcs : 'a
    ; error_bad_frame : 'a
    ; error_runt : 'a
    ; error_oversize : 'a
    ; error_start_without_terminate : 'a
    }
  [@@deriving hardcaml]
end

(** The decode. Instantiates M02 {!Crc32_eth} and nothing else (REQ-018). *)
val create : Scope.t -> Signal.t I.t -> Signal.t O.t

(** [create] wrapped for hierarchical emission, so [xgmii_rx_64] is a module of
    its own in the generated Verilog (REQ-808, REQ-903). *)
val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
