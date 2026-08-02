(** M02 [Crc32_eth] — the CRC-32 (IEEE 802.3) update by 1 to 8 octets, in one
    cycle and with no state of its own (SPEC-M02, FROZEN at f78766e).

    Two modules need exactly this function and must agree on it bit for bit:
    M03 checks a received FCS with it (REQ-104) and M04 generates a
    transmitted FCS with it (REQ-202). It is therefore one module, and it is
    combinational: REQ-306 forbids it a register, a [clock] and a [clear],
    which is what keeps its contribution to M03's and M04's pinned latency
    constants at zero (REQ-005).

    {2 The value convention (ADR-0006, REQ-301)}

    The ports carry the {e finished} CRC-32 value — REQ-301's final XOR
    already applied — not the internal shift-register state. The identity
    element is therefore [crc_in] = 0x00000000, which is CRC32(empty string):
    REQ-301's initial value 0xFFFFFFFF and its final XOR 0xFFFFFFFF cancel
    over an empty input. A caller seeds a frame with zero, not with all-ones.
    Conversion for a reader coming from prior art that carries the raw
    register: [register = port value XOR 0xFFFFFFFF], which is exactly the
    two [xor_mask] applications in {!create}.

    {2 The formulation, and why this one}

    SPEC-M02 §6.3 item 2 leaves the internal formulation unconstrained —
    table-driven, matrix-unrolled, per-count networks or one masked network
    are all legal and none is observable. This implementation elaborates the
    reflected bit recurrence itself, once, as a 64-step prefix chain, and taps
    it after each octet:

    - it is the definition of REQ-301's parameterisation written out, so it is
      checkable against the requirement by reading rather than by trusting an
      elaboration-time matrix computation no test of mine may gate
      (PROTOCOL §10 — dv_lead owns every test that gates this module);
    - the chain shares all eight octet counts, so the eight results cost one
      network plus one 16-way multiplexer rather than eight networks;
    - REQ-302's ignored-position clause holds by construction rather than by
      masking: the tap for n octets is a function of [data\[8n-1:0\]] only.

    It is a linear XOR network, so it is deep as written and shallow after
    synthesis restructuring. Phase 1 is simulation-only at the hardware
    boundary (REQ-018) and SPEC-M02 §7 requires no static timing closure of
    it; if a later phase cannot close the path, §7 says the remedy is a spec
    diff to REQ-306 and an ADR — never an internal register here. The
    matrix formulation is the drop-in replacement at that point, observably
    identical for every input in REQ-302's domain. *)

open! Base
open Hardcaml

(* [Axi64] is M01's types home (SPEC-M01 §4.1). M02 takes no record from it:
   REQ-306 makes M02 a pure function of a word, an octet count and a running
   CRC, so it has no stream port and no configuration port. The [open!] is
   here so that this module, like every other in this library, has exactly
   one place to obtain a shared type from and cannot grow a second
   [Axi64_config]; [data] below is one [Axi64] word wide (REQ-002,
   SPEC-M01 §5).

   No [clock] and no [clear]: REQ-306. No [Config]: SPEC-M02 §4.3. *)
open! Axi64

module I = struct
  type 'a t =
    { crc_in : 'a [@bits 32]
    ; data : 'a [@bits 64]
    ; octet_count : 'a [@bits 4]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t = { crc_out : 'a [@bits 32] } [@@deriving hardcaml]
end

let crc_bits = 32
let max_octets = 8

(* REQ-301's polynomial 0x04C11DB7 as a reflected implementation carries it:
   bit-reversed, so that the register shifts towards its least significant
   bit and octets enter least significant bit first. REQ-301's input-and-
   output-reflected clause is this reversal; it is not a second
   polynomial. *)
let reflected_polynomial = 0xedb8_8320

(* REQ-301's final XOR, which is also its initial value, and which ADR-0006
   makes the conversion between the ports' finished values and the register
   this module shifts. *)
let final_xor = 0xffff_ffff

let create (_scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
  let open Signal in
  let polynomial = of_int ~width:crc_bits reflected_polynomial in
  let xor_mask = of_int ~width:crc_bits final_xor in
  (* Finished value in, register out (ADR-0006). [crc_in] = 0x00000000 —
     what a caller drives at the first octet of a frame — starts the register
     at REQ-301's initial value 0xFFFFFFFF, so no first-update special case
     exists anywhere in this module or in its callers. *)
  let register_in = i.crc_in ^: xor_mask in
  (* One bit of the reflected recurrence: exclusive-or the incoming bit with
     the register's least significant bit, shift the register down, and add
     the polynomial back when that feedback bit is 1. *)
  let step register data_bit =
    let feedback = lsb register ^: data_bit in
    (* (register >> 1) XOR (feedback ? polynomial : 0) *)
    srl register 1 ^: mux2 feedback polynomial (zero crc_bits)
  in
  (* Octet k of [data] is [data\[8k+7:8k\]] (REQ-012) and each octet is
     consumed least significant bit first, so the bit order of the whole
     update is simply [data] bit 0 upward: [bits_lsb] is already the
     consumption order, and [chunks_of ~length:8] cuts it back into octets.

     [after_octet] holds the register after 1, 2, ... 8 octets. It is a
     prefix chain, so entry n-1 is a function of [data\[8n-1:0\]] and of
     nothing above it — REQ-302's ignored-position clause (positions at and
     above octet_count do not affect crc_out) holds by construction, with no
     masking to get wrong. Entry n-1 is also, by the same construction, n
     consecutive one-octet updates, which is REQ-302's serial equivalence. *)
  let after_octet =
    List.folding_map
      (List.chunks_of (bits_lsb i.data) ~length:8)
      ~init:register_in
      ~f:(fun register octet_bits ->
        let register = List.fold octet_bits ~init:register ~f:step in
        register, register)
  in
  let after_eight_octets = List.last_exn after_octet in
  (* [octet_count] selects the tap: 1 selects one octet, 8 selects eight.
     0 and 9 through 15 are outside REQ-302's domain and SPEC-M02 §6.3 item 1
     leaves [crc_out] unconstrained for them; they select the eight-octet tap
     and deliberately NOT [crc_in]. ADR-0007's argument is the reason: an
     identity meaning for 0 would make an accidental update-by-zero silently
     correct-looking, where any other value keeps it a caller defect a bench
     can catch. M03 and M04 gate their accumulator register instead, so no
     caller drives 0 (SPEC-M02 §11.2). *)
  let taps =
    List.init 16 ~f:(fun index ->
      if index >= 1 && index <= max_octets
      then List.nth_exn after_octet (index - 1)
      else after_eight_octets)
  in
  (* Register out, finished value out (ADR-0006). One exclusive-or after the
     multiplexer rather than eight before it: the mask is constant, so the
     two orders are the same function. *)
  { O.crc_out = mux i.octet_count taps ^: xor_mask }
;;

let hierarchical ?instance scope (i : Signal.t I.t) : Signal.t O.t =
  let module H = Hierarchy.In_scope (I) (O) in
  H.hierarchical ?instance ~scope ~name:"crc32_eth" create i
;;
