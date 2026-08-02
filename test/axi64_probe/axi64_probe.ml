(** Sampling adapter: a live [Axi64.Source] in a [Cyclesim] simulation becomes
    the plain [Stream_word.t] values every monitor in [dv_monitors] consumes.

    {2 Why this is the only file in DV that names a hardcaml_axi field}

    WO-0009 sanctions exactly one import into the DUT-independent bench layer:
    the [Axi64] type module, "the signed public interface, not
    implementation". Everything else in `test/monitors/` and `test/golden/` is
    plain OCaml over [Stream_word.t], so the monitors are unit-testable with no
    simulator and cannot rot when the driver layer changes. This file is the
    seam, and it is deliberately one function long.

    {2 Two entry points, and why both exist}

    [of_refs] names no [hardcaml_axi] type at all: a bench passes the six
    [Bits.t ref]s it already holds. It therefore works against {e any}
    application of [Hardcaml_axi.Stream.Make], today's and tomorrow's, and
    needs no maintenance.

    [of_source] is the sanctioned import made concrete, against
    [Ifc_check.Axi64_ifc.Axi64] — the lift of SPEC-M01 §4.1, byte-identical to
    the specification and countersigned at 22145b5, which is the only [Axi64]
    that exists at this SHA. [libs/hardcaml_ethernet/src/axi64.ml] is
    specified but not yet built, and libs/** stays unopened here (PROTOCOL
    §10). When rtl_lead builds M01, the programme's [Axi64] moves there and
    this one function retargets to it — a one-line change, with [of_refs]
    carrying every bench in the meantime. That obligation is recorded as an
    open question in J-dv_lead-0004 rather than left to be discovered.

    {2 What compiling this file settles}

    SPEC-M01 §11.4 records that [Axi64.Source]'s field names are transcribed
    from [hardcaml_axi] v0.17.0's [stream_intf.ml] and are {e unverified by
    compilation}: the green CI run 30727252770 elaborated the functor
    application, but no lift names a field anywhere outside a comment, so a
    divergence in v0.17.0 would not have been caught. [of_source] below is the
    first code in the repository to name [tvalid], [tdata], [tkeep], [tstrb],
    [tlast] and [tuser] on a real [Source]. A green build discharges §11.4; a
    red one is §11.4's answer, and the repair is editorial and confined to this
    file. *)

open! Base
open Hardcaml

(** Octet position [k] of a 64-bit word is [tdata\[8k+7 : 8k\]] (SPEC-M01
    §6.1). *)
let octet_of_word bits ~position =
  Bits.to_int (Bits.select bits ((8 * position) + 7) (8 * position))
;;

(** Build a per-cycle sampler from the six [Bits.t ref]s of a [Source]. Names
    no stream type, so it survives any change of [Axi64]'s home. *)
let of_refs ~tvalid ~tdata ~tkeep ~tstrb ~tlast ~tuser () =
  { Dv_monitors.Stream_word.tvalid = Bits.to_int !tvalid <> 0
  ; tdata = Array.init 8 ~f:(fun position -> octet_of_word !tdata ~position)
  ; tkeep = Bits.to_int !tkeep
  ; tstrb = Bits.to_int !tstrb
  ; tlast = Bits.to_int !tlast <> 0
  ; tuser = Bits.to_int !tuser
  }
;;

(** The sanctioned import: sample a whole [Axi64.Source] record. *)
let of_source (source : Bits.t ref Ifc_check.Axi64_ifc.Axi64.Source.t) () =
  of_refs
    ~tvalid:source.Ifc_check.Axi64_ifc.Axi64.Source.tvalid
    ~tdata:source.Ifc_check.Axi64_ifc.Axi64.Source.tdata
    ~tkeep:source.Ifc_check.Axi64_ifc.Axi64.Source.tkeep
    ~tstrb:source.Ifc_check.Axi64_ifc.Axi64.Source.tstrb
    ~tlast:source.Ifc_check.Axi64_ifc.Axi64.Source.tlast
    ~tuser:source.Ifc_check.Axi64_ifc.Axi64.Source.tuser
    ()
;;
