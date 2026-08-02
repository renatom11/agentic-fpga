(* TRANSCRIPTION — this is NOT Base. See tools/precompile_stubs/README.md.
   Consumed only by tools/precompile_check.sh lane 2. Never linked, never run.

   WHY IT EXISTS AT ALL
     test/axi64_probe/axi64_probe.ml opens Base. J-dv_lead-0018's scratch
     harness could not compile that file and stubbed the whole module out
     instead, which meant the one DV file that names every hardcaml_axi
     [Source] field was the one file lane 2 never type-checked. Stubbing the
     single Base name it uses is strictly better: the real file compiles, and
     the residual is one signature instead of a whole module.

   SOURCE
     Base v0.17's [Array.init : int -> f:(int -> 'a) -> 'a t]. The labelled
     [~f] is the whole point of the transcription — it is what distinguishes
     Base's [Array.init] from Stdlib's, and it is the difference a missing
     stub would hide.

   UNVERIFIED — stated plainly, because it cannot be otherwise here
     base is not installed and its sources are not present in this container
     (ADR-0005), so lane 2b has nothing to re-read and reports
     UNVERIFIED-TRANSCRIPTION for this file. The signature above is quoted
     from Base's published interface, not from a local copy.

   SCOPE, AND THE LIMIT THAT MATTERS
     One name. Everything else an [open! Base] would shadow — the comparison
     operators, Int, List, String, the Poly restrictions — resolves to Stdlib
     under this stub. So lane 2 checks the file's SCOPING and ARITIES, and
     does NOT reproduce Base's shadowing semantics. A DV file that depends on
     a Base-specific meaning of a shadowed name is outside what lane 2 can
     see, and CI is the authority for it. *)

module Array : sig
  val init : int -> f:(int -> 'a) -> 'a array
end = struct
  let init n ~f = Stdlib.Array.init n f
end
