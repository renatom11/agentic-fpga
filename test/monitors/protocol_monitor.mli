(** Stream-legality monitor for the SPEC-M01 §6.1 encoding contract.

    Derived from SPEC-M01 (`docs/specs/modules/axi64.md`) at 22145b5 §6.1 and
    §6.3, and from requirements.md at b4b4cf4 REQ-011, REQ-013, REQ-014,
    REQ-015 and REQ-009. No RTL was read; the contract is encoded by citation.

    {2 What it asserts, and the clause each rule comes from}

    Every rule below is evaluated {b only} on words with [tvalid] = 1
    (SPEC-M01 §6.3 item 5).

    - [Tkeep_zero] — SPEC-M01 §6.1 "[tkeep] = 0 with [tvalid] = 1 is never
      produced" (REQ-011). A zero-octet frame has no encoding; §0.7 gives the
      encoding it has instead.
    - [Tkeep_not_contiguous] — §6.1 "the ones are contiguous from bit 0"
      (REQ-011).
    - [Tkeep_partial_on_non_last] — §6.1 "on every such word except the one
      carrying [tlast] the value is [0xFF]" (REQ-011).
    - [Tstrb_nonzero] — §6.1 "[tstrb] … driven to 0 by every producer"
      (REQ-014). This is the producer-side half of REQ-014; the consumer-side
      half is REQ-014's differential run (same stimulus with [tstrb] = 0x00 and
      0xFF, byte-identical output traces), which is a bench-level obligation
      and not a monitor rule.
    - [Frame_exceeds_max_words] — REQ-015's checkable residue: at most the
      number of words the stream's maximum payload requires, pinned by the
      producing module's spec (e.g. 190 words on the [Xgmii_rx_64] output
      stream). Only checked when [max_words_per_frame] is supplied; no default
      is invented here, because SPEC-M01 §6.1 explicitly leaves per-stream
      maxima to the producing specification.

    {2 What it deliberately does not assert}

    - Anything at all on a cycle with [tvalid] = 0 (§6.3 item 5). The test
      [garbage on idle cycles] proves this.
    - The value of [tdata] at positions where [tkeep] is 0 (§6.3 item 5). The
      monitor only ever reads [Stream_word.octets].
    - Any constraint on [tuser]. REQ-013 gives [tuser]\[0\] a meaning on the
      [tlast] word and says it is ignored elsewhere; it constrains no producer
      to any particular value, so there is nothing here to falsify. The
      monitor counts [tuser] = 1 on [tlast] words as {e aborts} so a bench can
      reconcile them against REQ-007, but never flags one.
    - Anything across a [clear]. REQ-009 and REQ-015 require the monitor to
      reset its frame-in-progress state on [clear] and make no assertion across
      it; [on_clear] is how a bench discharges that, and it is why a truncated
      in-flight frame is not reported as a violation.

    {2 Attaching it to a simulation}

    [sink] returns a per-cycle closure over a sampling function. That is the
    whole attachment mechanism: a [Cyclesim] loop calls it after each
    [Cyclesim.cycle], and a [hardcaml_step_testbench] coroutine calls it from
    its cycle hook. The monitor itself never names a simulator type, so it
    cannot rot when the driver layer changes. `test/axi64_probe/` supplies the
    sampler for a live [Axi64.Source]. *)

type violation_kind =
  | Tkeep_zero
  | Tkeep_not_contiguous
  | Tkeep_partial_on_non_last
  | Tstrb_nonzero
  | Frame_exceeds_max_words

type violation =
  { cycle : int
  ; kind : violation_kind
  ; detail : string
  }

type t

(** [create ~name ?max_words_per_frame ()]. [max_words_per_frame] is the
    producing module's pinned maximum (REQ-015); omit it on a stream whose
    spec has not pinned one yet, and the length rule is simply not evaluated
    rather than silently invented. *)
val create : name:string -> ?max_words_per_frame:int -> unit -> t

(** Present one cycle of the stream. Safe to call on every cycle including
    idle ones; that is the intended use. *)
val observe : t -> cycle:int -> Stream_word.t -> unit

(** Tell the monitor [clear] was asserted on this cycle (REQ-009). Drops any
    frame-in-progress state without reporting a violation. *)
val on_clear : t -> cycle:int -> unit

val name : t -> string
val violations : t -> violation list
val is_clean : t -> bool

(** Frames completed, i.e. words carrying [tlast] with [tvalid] = 1. *)
val frames : t -> int

(** Words with [tvalid] = 1. *)
val words : t -> int

(** Octets carried, summed over [tkeep] popcounts. *)
val octets : t -> int

(** Words carrying [tlast] with [tuser]\[0\] = 1 (REQ-007 abort marking).
    Counted, never flagged. *)
val aborts : t -> int

(** Frames dropped by a [clear] while in progress. Reported, never flagged. *)
val cleared_mid_frame : t -> int

val string_of_violation : violation -> string

(** Deterministic single-line summary plus one line per violation. This is
    what belongs in an expect block. *)
val report : t -> string

(** [sink t ~sample] is the per-cycle closure described above. *)
val sink : t -> sample:(unit -> Stream_word.t) -> cycle:int -> unit
