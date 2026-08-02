(** The XGMII seam: [Dv_xgmii.Xgmii_word.t] to and from a live [Xgmii] port in
    a [Cyclesim] simulation. WO-0033 item **X-2**, the counterpart of
    `test/axi64_probe/` on the wire side, which `test/xgmii/dune` recorded as
    landing "with the first M03 bench".

    {2 Why a separate library, and why it is two functions long}

    Exactly the reasons `test/axi64_probe/dune` gives for its own existence.
    [dv_xgmii] and [dv_monitors] depend on no Hardcaml at all, so the link
    partner's own unit tests fail when the {e model} is wrong rather than when
    an elaboration is; and if a transcription of the [Xgmii] record's field
    names turns out wrong, the failure is confined to this directory and every
    other WO-0033 deliverable still builds.

    [Ifc_check.Axi64_ifc.Xgmii] is the lift of SPEC-M01 §4.1 under `docs/specs/`
    — the signed public interface, byte-identical to the specification and
    countersigned at 22145b5 — and its two fields are [d] (64 bits) and [c]
    (8 bits). `libs/**` is not depended on and was not opened (PROTOCOL §10).

    {2 Both directions, because the boundary has both}

    M03 {e receives} XGMII: its `xgmii_rx` port is an input, so a bench
    {b drives} it from the link partner's schedule ([to_refs], [to_port]).
    M04 {e transmits} it: its `xgmii_tx` port is an output, so a bench
    {b samples} it and hands the words to [Dv_xgmii.Tx_decoder]
    ([of_refs], [of_port]). One boundary, two ports, two directions; a probe
    offering only one of them would leave half the XGMII contract undrivable.

    [to_refs] and [of_refs] name no [Ifc_check] type at all — a bench passes
    the two [Bits.t ref]s it already holds — so they survive any change of the
    [Xgmii] record's home when rtl_lead's M01 lands. That is the same split, and
    for the same reason, that [Axi64_probe.of_refs] and [of_source] make on the
    stream side.

    {2 The packing convention lives in one place}

    REQ-012 and SPEC-M01 §6.1: lane [k] occupies [d]\[8k+7 : 8k\] and bit [k] of
    [c] marks it as a control character. [Xgmii_word] already states that
    convention once, in [to_wire] / [of_wire]; this file re-states it in terms
    of [Bits.select] rather than of [Int64] arithmetic, because a 64-bit lane
    word whose lane 7 holds 0x80 or above does not fit in OCaml's 63-bit [int]
    and going through [Int64] to reach a [Bits.t] would add a conversion that
    can silently wrap. Building the word from eight 8-bit lane values makes the
    wrap impossible rather than merely unlikely. *)

open Hardcaml

(* Only [Bits.vdd], [Bits.gnd], [Bits.concat_lsb], [Bits.select] and
   [Bits.to_int] are used in this file. The first two and the last two are the
   calls `test/axi64_probe/axi64_probe.ml` and `test/hardcaml_ethernet/` have
   already carried through a green CI run; [concat_lsb] is the only new name,
   and it is used here rather than an integer constructor so that no width
   argument and no 63-bit intermediate exists to be wrong. *)
let bit b = if b then Bits.vdd else Bits.gnd

let bits_of_int ~width value =
  Bits.concat_lsb (List.init width (fun i -> bit ((value lsr i) land 1 = 1)))
;;

let octet_of_bits bits ~lane =
  Bits.to_int (Bits.select bits ((8 * lane) + 7) (8 * lane))
;;

(** Drive one XGMII word onto the two [Bits.t ref]s of a live [Xgmii] port.
    Lane 0 is the earlier octet on the wire and occupies bits [7:0] (REQ-012).
    A control lane carries its character's value in [d] and a 1 in [c]; a data
    lane carries its octet and a 0. *)
let to_refs ~d ~c (word : Dv_xgmii.Xgmii_word.t) =
  let lane_value k =
    match Dv_xgmii.Xgmii_word.lane word k with
    | Dv_xgmii.Xgmii_word.Data octet -> octet
    | Dv_xgmii.Xgmii_word.Control value -> value
  in
  d := Bits.concat_lsb (List.init 8 (fun k -> bits_of_int ~width:8 (lane_value k)));
  c := bits_of_int ~width:8 word.Dv_xgmii.Xgmii_word.control
;;

(** [to_refs] against the lifted record. The one place in DV that names the
    [Xgmii] record's fields on a driven port. *)
let to_port (port : Bits.t ref Ifc_check.Axi64_ifc.Xgmii.t) word =
  to_refs
    ~d:port.Ifc_check.Axi64_ifc.Xgmii.d
    ~c:port.Ifc_check.Axi64_ifc.Xgmii.c
    word
;;

(** Sample one XGMII word from a live port. The inverse of [to_refs] on every
    word both can represent, which is what [test_xgmii_probe.ml] drives. *)
let of_refs ~d ~c () =
  let control = Bits.to_int !c in
  Dv_xgmii.Xgmii_word.of_lanes
    (List.init 8 (fun k ->
       let octet = octet_of_bits !d ~lane:k in
       if (control lsr k) land 1 = 1
       then Dv_xgmii.Xgmii_word.Control octet
       else Dv_xgmii.Xgmii_word.Data octet))
;;

(** [of_refs] against the lifted record — the transmit-side entry point
    [Dv_xgmii.Tx_decoder] consumes. *)
let of_port (port : Bits.t ref Ifc_check.Axi64_ifc.Xgmii.t) () =
  of_refs
    ~d:port.Ifc_check.Axi64_ifc.Xgmii.d
    ~c:port.Ifc_check.Axi64_ifc.Xgmii.c
    ()
;;
