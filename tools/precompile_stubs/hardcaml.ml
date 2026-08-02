(* TRANSCRIPTION — this is NOT Hardcaml. See tools/precompile_stubs/README.md.
   Consumed only by tools/precompile_check.sh lane 2. Never linked, never run.

   SOURCE
     hardcaml v0.17.1, src/comb_intf.ml (the [Comb.S] signature [Bits]
     satisfies) and src/bits.mli. In this container the opam switch keeps the
     package's unpacked sources at
       $(opam var switch)/.opam-switch/sources/hardcaml/src/
     even though the package itself is not installed (ADR-0005). That path is
     what lane 2b re-reads.

   VERIFIED
     Mechanically, by precompile_check.sh lane 2b, whenever those sources are
     findable: every [val] line below must appear verbatim in comb_intf.ml or
     bits.mli. When they are NOT findable, lane 2b prints
     UNVERIFIED-TRANSCRIPTION and the harness's summary says so — it does not
     quietly treat the stub as anchored.

   SCOPE
     The six [Bits] names the DV tree uses, and nothing else:
       t  vdd  gnd  width  concat_lsb  select  to_int
     They are the names test/xgmii_probe/xgmii_probe.ml,
     test/axi64_probe/axi64_probe.ml and test/axi64_probe/axi64_driver.ml
     call. A DV file that reaches for a seventh name gets "Unbound value" from
     lane 2, which is the intended behaviour: a new API name is a new CI risk
     and must be declared here before it can be type-checked here.

   WHY THE TYPE IS ABSTRACT
     [t] is sealed by the signature below so that no DV file can accidentally
     type-check against a representation this stub invented. The only things
     that compile against it are the seven names above — exactly as against
     the real library. *)

module Bits : sig
  type t

  val vdd : t
  val gnd : t
  val width : t -> int
  val concat_lsb : t list -> t
  val select : t -> int -> int -> t
  val to_int : t -> int
end = struct
  type t = Stub

  let unimplemented name =
    failwith
      ("tools/precompile_stubs/hardcaml.ml: Hardcaml.Bits."
       ^ name
       ^ " is a type-check transcription with no implementation; it must never \
          be linked or run")
  ;;

  let vdd = Stub
  let gnd = Stub
  let width _ = unimplemented "width"
  let concat_lsb _ = unimplemented "concat_lsb"
  let select _ _ _ = unimplemented "select"
  let to_int _ = unimplemented "to_int"
end
