(** M02 [Crc32_eth] — the exported surface of the combinational CRC-32 update
    (SPEC-M02 §4.1, FROZEN at f78766e).

    There is no [clock] and no [clear] in {!I}: REQ-306 makes this module a
    pure function of a running CRC, a word and an octet count, and the
    absence of those two ports is the mechanically checked half of that
    requirement. There is no [Config] either (SPEC-M02 §4.3).

    The ports carry {b finished} CRC-32 values (ADR-0006): [crc_in] =
    0x00000000 is the CRC of the empty octet string and is what a caller
    drives at the start of a frame — not REQ-301's initial value 0xFFFFFFFF,
    which is internal to a register this module does not expose. [octet_count]
    is 1 to 8; SPEC-M02 §6.3 item 1 leaves [crc_out] unconstrained outside
    that domain.

    [@bits] attributes are deliberately absent below: in a signature the
    deriver does not consume them, and an unconsumed attribute is a compile
    error. [crc_in] and [crc_out] are 32 bits, [data] 64 and [octet_count] 4,
    as SPEC-M02 §4.2 fixes them and as the implementation's attributes
    declare them. *)

open! Base
open Hardcaml

module I : sig
  type 'a t =
    { crc_in : 'a
    ; data : 'a
    ; octet_count : 'a
    }
  [@@deriving hardcaml]
end

module O : sig
  type 'a t = { crc_out : 'a } [@@deriving hardcaml]
end

(** The combinational update, taking a [Scope.t] like every other module in
    this library even though it holds no state to name. *)
val create : Scope.t -> Signal.t I.t -> Signal.t O.t

(** [create] wrapped for hierarchical emission, so [crc32_eth] is a module of
    its own in the generated Verilog rather than being inlined into M03 and
    M04 (REQ-808, REQ-903). *)
val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
