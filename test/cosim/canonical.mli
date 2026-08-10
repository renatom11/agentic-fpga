(** WO-0046 §2.3 — the canonical transaction form, PINNED as the interface
    between tb_writer's half of the co-simulation lane (this file, plus
    [ours_run.ml] and [tb_xgmii_rx_64.v], which each produce a file in this
    grammar) and data_wrangler's half ([tools/cosim/run_cosim.sh], which
    sequences the two producers and this module's own [compare] binary
    against their output). Neither producer may deviate from the grammar
    below; it is what makes a "theirs.canon" written by a Verilog testbench
    and an "ours.canon" written by an OCaml driver comparable at all.

    This module is also, per the packet, "the canonical form: writer, parser,
    and the domain comparison" — i.e. it owns REQ-901's comparison itself;
    [compare.ml] is a thin CLI wrapper (argument handling, [--self-test],
    exit code) around the functions below. *)

(** One captured output word, in emission order within its frame.

    - [tkeep]: 0..0xFF, the word's tkeep extent (REQ-901: compared on EVERY
      word, not only the final one — CD-xgmii_rx_64_cosim.md §0-bis's
      correction of its own §5.1).
    - [tlast]: this word carries the frame's last delivered octets.
    - [tuser0]: the abort/found-invalid bit (REQ-013 on our side; the
      reference's [m_axis_tuser] bit 0 — WO-0046 §6 question 2). Recorded on
      every word by the pinned grammar even though it is only MEANINGFUL on
      the [tlast] word; a reader must not assert on it elsewhere.
    - [cycle]: WO-0075 §2 — the shared time base (§3.0 below) index at which
      this word was observed on the DUT's own stream ([rx] on our side,
      [m_axis_t*] on the reference's). Compared by NEITHER [compare_words]
      NOR [compare_transactions] (WO-0075 §4 bars a cross-side cycle
      comparison as the exact quantity REQ-901's own closing sentence
      excludes by name); it exists only for [check_timing]'s T1 (against our
      own spec, never against [theirs]) and T2 (recorded, never adjudicated).
    - [octets]: the octets this word actually delivers, in ascending [tdata]
      position order. Length is exactly the popcount of [tkeep] — [write]
      and [read] both enforce this. *)
type word =
  { tkeep : int
  ; tlast : bool
  ; tuser0 : bool
  ; cycle : int
  ; octets : int list
  }

(** REQ-901's accept-or-discard decision for one INPUT frame — "the same
    accept-or-discard decision per input frame", the field CD-xgmii_rx_64_cosim.md's
    original §5.1 omitted and REQ-901 restores (§0-bis). *)
type decision =
  | Accept
  | Discard

(** One input frame's record. [index] is 0-based admission order (the order
    input start characters were recognised), not output position — a
    [Discard]ed frame contributes no output words at all (WO-0046 §2.3's
    "no output word at all" cases) but still owns an index and a [D] line, so
    that a frame present on one side and silently absent on the other is a
    detectable [Missing_frame] rather than an invisible index shift on every
    later frame. [words] is empty iff [decision = Discard].

    [admit_cycle] (WO-0075 §2): the shared time base (§3.0) index of the
    input word on which this frame's start character was recognised. Both
    producers already compute this at the exact point they test for a start
    character before driving; this field only asks them to record it. Never
    added to [compare_transactions]'s comparison — it feeds only
    [check_timing]'s T0 (calibration: agreement between the two producers'
    own indexing of the same stimulus, never a claim about either design). *)
type frame =
  { index : int
  ; admit_cycle : int
  ; words : word list
  ; decision : decision
  }

type transaction = frame list

(** {2 Grammar (WO-0046 §2.3, pinned; amended WO-0075 §2 — the first amendment
    since pinning, adding [admit-cycle] and [cycle] and nothing else)}

    Text, one record per line, ASCII, LF endings, no trailing whitespace:
    {v
      F <frame-index> <admit-cycle>
      W <tkeep-hex-2> <tlast 0|1> <tuser0 0|1> <cycle> <octet-hex-2>*
      D <frame-index> <accept|discard>          (UNCHANGED)
    v}
    Per frame, in the literal order the grammar block above states: one [F]
    line, then its [W] lines (zero or more) in emission order, then its [D]
    line. Frame indices are 0-based admission order and repeated verbatim on
    the [F] and [D] lines of the same frame ([read] rejects a mismatch).
    Hex fields ([tkeep-hex-2] and each [octet-hex-2]) are exactly 2 digits,
    lowercase, no [0x] prefix. Nothing else may appear in the file: no
    version string, tool name, path, timestamp or host identifier (those are
    the sidecar's business, WO-0046 §2.3, and the sidecar is never compared).

    {3 [E] — a reserved, always-rejected record kind (WO-0078 §2.3,
    FINDING WO-0078-1)}

    An [E] line is never emitted by [write] and never valid input: [read]
    recognises it explicitly and raises immediately, regardless of whether a
    frame is open, naming it as a PRODUCER REFUSAL rather than reporting the
    generic "unrecognised record kind" a stray [E] line would otherwise draw.
    [tb_xgmii_rx_64.v] writes one deliberately, as the last thing it writes to
    [theirs.canon] before a guard-triggered [$finish] (WO-0046 §9's REQ-110
    abort guard, and the reference's own no-open-frame guard) — this is what
    makes a reference-side refusal fail to read **by construction** rather
    than by the accident of a dangling open frame, which only one of the two
    guards happened to produce (WO-0078 §2.3's own finding: the other guard
    left a well-formed, merely truncated file that would otherwise parse
    clean and risk being read as a genuine content divergence). No producer
    on the [ours] side ever needs to emit one: [ours_run.ml]'s own refusals
    are plain [failwith]s that never reach [Canonical.write] at all.

    {3 [admit-cycle] and [cycle] — decimal, on purpose (WO-0075 §2)}

    Both fields are **DECIMAL, unpadded, no [0x], no leading zeros beyond the
    digit [0] itself** — the one deliberate departure from every other
    integer field in this grammar, which are hex. [cycle] sits immediately
    before a [W] line's variable-length octet list, at the exact position an
    old (pre-WO-0075) producer's first octet occupies; a decimal token there
    makes an **old-format file unparseable rather than misparseable**.
    [write]'s own output fed to the amended [read] can never silently agree:
    an old octet token containing any hex-only digit ([a]-[f]) fails decimal
    parsing outright, and even an old octet token that happens to be
    all-decimal-digits (so it parses as a number) then leaves the [W] line
    one token short of its [tkeep]'s popcount, which the existing octet-count
    check (below) catches as the second net. **A producer left un-updated
    therefore produces [read_file] failure — [compare]'s exit 3 — and can
    never produce a false green.** [read] additionally rejects a negative
    [cycle] or [admit-cycle] outright (a leading [-] is not a decimal digit,
    so this falls out of the same parse rather than needing a second check). *)

(** Serialise [transaction] to [oc] in the pinned grammar. Raises if any
    [word]'s [octets] length disagrees with its [tkeep]'s popcount — a
    producer bug caught before it reaches disk rather than at the next read. *)
val write : out_channel -> transaction -> unit

val write_file : string -> transaction -> unit

(** Parse a file previously written in the pinned grammar — by [write] or by
    an independent producer speaking the same grammar (namely
    [tb_xgmii_rx_64.v]'s [$fwrite]s). Raises [Failure], naming the 1-based
    line number and the record, on any grammar violation: an unrecognised
    record kind, a [W] line outside an open frame, an [F] line while one is
    already open, an [F] line missing its [admit-cycle] token (the
    old-format-file case above), a [D] index that does not match its own
    frame's [F] index, a [W] line whose octet count disagrees with its
    [tkeep], a negative [cycle] or [admit-cycle], or a file that ends with a
    frame still open (a [D] line owed and never written). *)
val read : in_channel -> transaction

val read_file : string -> transaction

(** {2 REQ-901's comparison}

    "the same ordered sequence of output frames — payload octets, the
    [tkeep] extent of each word, and [tuser]\[0\] on each [tlast] — and the
    same accept-or-discard decision per input frame." Compared by frame
    INDEX, not list position, so a frame missing on one side is reported
    against the index it is missing at rather than silently shifting every
    later comparison out of alignment. *)

type divergence =
  | Missing_frame of
      { index : int
      ; side : [ `Ours | `Theirs ]
            (** the side the frame IS present on; it is missing on the other *)
      }
  | Decision_mismatch of
      { index : int
      ; ours : decision
      ; theirs : decision
      }
  | Word_count_mismatch of
      { index : int
      ; ours : int
      ; theirs : int
      }
  | Word_mismatch of
      { index : int
      ; word_index : int
      ; field : string (** ["tkeep"] | ["tlast"] | ["tuser0"] | ["octets"] *)
      ; ours : string
      ; theirs : string
      }

(** REQ-901 declares four divergence classes in advance (checksum
    verification, ARP cache eviction order, discard-on-miss, zero UDP
    transmit checksum) and none of them names an M03 behaviour
    (requirements.md REQ-901; WO-0046 §1: "for M03 the permitted-divergence
    set is EMPTY"). [class_of] is therefore [None] for every [divergence]
    this module can produce today: this lane reports everything as a defect,
    never invents a class locally (CD-xgmii_rx_64_cosim.md §0-bis's ruling —
    a class is added to REQ-901 by spec diff, never asserted here). The
    function exists as the extension seam a future module pairing's WO would
    fill in, not as a promise that M03 has one. *)
val class_of : divergence -> string option

val divergence_to_string : divergence -> string

(** {2 [FINDING RV-0078-S2-11] — WHAT the two sides agreed on, not merely THAT
    they agreed}

    The record below was RELATIONAL and never ABSOLUTE: it printed [frames
    compared], [frames matching] and [divergences: none], and never one value
    the two sides agreed on. That is sufficient while the interesting fact
    about a case is a RELATION — "two independent implementations did the same
    thing" — and insufficient the moment it is a VALUE. It became a value at
    the bad-FCS case, whose entire point is REQ-104's [tuser0] = 1 on the
    delivering word: for that case the record established equality without
    establishing what was equal, so a packet writing "the co-simulation agreed
    [tuser0] = 1" would have been quoting a number no log contains.

    The rule that finding minted binds whether or not this repair exists:
    {e no document may state a co-simulated value that the log does not print;
    a value established by pairing this lane's agreement with another
    instrument's assertion is written as the pair, with both cited.} These
    types discharge it on the PRODUCING side, so the pair form becomes a
    choice rather than the only lawful wording.

    ONLY THE COMPARED OBSERVABLES APPEAR HERE, and the omission is the point.
    [word.cycle] is deliberately absent: WO-0075 §4 bars a cross-side cycle
    comparison as the exact quantity REQ-901's closing sentence excludes by
    name, so [cycle] is never compared by [compare_transactions] — and a
    quantity that was never compared may not appear inside a record of what
    was agreed, where a reader would take it for one. That is why this is a
    type of its own rather than the [word list] it would otherwise be. *)
type agreed_word =
  { a_tkeep : int
  ; a_tlast : bool
  ; a_tuser0 : bool
  ; a_octets : int list
  }

(** One frame both sides carried at the same index, on which they agreed about
    everything REQ-901 compares: the accept-or-discard decision, and — where
    that decision is [Accept] — every word, field for field. [a_words] is
    empty iff [a_decision = Discard], the same invariant [frame] carries. *)
type agreed_frame =
  { a_index : int
  ; a_decision : decision
  ; a_words : agreed_word list
  }

type report =
  { frames_compared : int
  ; frames_matching : int
  ; divergences : divergence list
  ; agreed : agreed_frame list
        (** the [frames_matching] frames, ascending by index, carrying the
            values they agreed on.

            Populated PER FRAME and never gated on the transaction's
            divergence list: a frame that matched has agreed values whatever
            some OTHER frame in the same case did. Gating a per-frame print on
            the whole transaction's divergence list is the exact defect
            [FINDING RV-0078-S1-2] limb (b) repaired in
            [timing_report_to_string] — unreachable at a one-frame case,
            reachable from the first multi-frame case onward — and it is not
            reintroduced here. *)
  }

(** REQ-901's own comparison. *)
val compare_transactions : ours:transaction -> theirs:transaction -> report

(** REQ-901's Verification-column report, verbatim in shape: "frames
    compared, frames matching, and every divergence with the class it falls
    in or the defect it is" — followed by the agreed values of every frame
    that matched ([FINDING RV-0078-S2-11]).

    BOUNDED, and the bound is stated here rather than discovered later: the
    agreement block prints one line per agreed word, and the reference side
    captures at most [MAX_WORDS_PER_FRAME] words per frame, so the block is
    bounded by that constant times the number of frames the case array drives.
    The case arrays this lane has carried are single-digit frame counts, which
    is the workload this print is sized against. A stage that drives frames in
    the thousands — a fuzz or replay lane — needs a bound here BEFORE it runs,
    not a discovery afterwards: state the range a bound must cover in the same
    change that introduces it. *)
val report_to_string : report -> string

(** [true] iff [report] carries no divergences. What [compare.ml]'s exit code
    is computed from. *)
val is_clean : report -> bool

(** {2 WO-0075 §3 — the three timing tiers}

    Layered beside REQ-901's content comparison above, never inside it:
    [compare_transactions] and [compare_words] are UNCHANGED by this section
    and [cycle]/[admit_cycle] enter neither (WO-0075 §4). The shared time
    base (§3.0) both producers already write into the grammar above is the
    0-based index of the stimulus line each drove, so it is derived from a
    file rather than from either design and is identical by construction. *)

(** One tier's finding.

    - [Admit_cycle_mismatch]: **T0**. The two producers disagree about which
      stimulus line admitted frame [index] — a harness defect, never a claim
      about either design (WO-0075 §3.1).
    - [Spec_cycle_mismatch]: **T1**. Our own side's output word [word_index]
      of accepted frame [index] was observed at [observed], where
      [docs/specs/modules/xgmii_rx_64.md] §6.1's gapless [admit_cycle + m + 3]
      formula pins [expected]. A defect against OUR spec (REQ-005/REQ-111),
      never a differential finding against [theirs] (WO-0075 §3.2/§4).
    - [Unassertable]: **T1**'s guard, now with TWO triggers, one carried and
      one inferred (WO-0075 §3.2; extended WO-0078 §5.2/§5.4; trigger (2)'s
      RULE replaced by `FINDING RV-0078-S1-1`'s successor rule, landed in the
      WO-0078 Stage-1-repair round, superseding §5.4's own broken-delta
      COUNT — see below). Refused rather than computed, for frame [index],
      whenever EITHER:
      (1) [check_timing]'s [injected_idle_before_d0] reports a nonzero
      count for this frame — the stimulus itself recorded idle word(s)
      injected at or before this frame's D(0) (SPEC-M03 §6.1's own
      antecedent), which the CARRIED count rules out directly (FINDING
      RV-0075-2: this shape is invisible to (2) below, because it shifts
      every word uniformly and preserves every inter-word delta — the
      defect that made the pre-WO-0078 guard blind in exactly this
      direction); or
      (2) with the carried count at 0, the frame's own per-word DEPARTURE
      from SPEC-M03 §6.1's gapless formula — [d_m = observed_m -
      (admit_cycle + m + 3)], one per word in emission order — is NOT
      identically zero, AND [d_0 = 0], AND [d] is non-decreasing across the
      frame (each word's departure at least its predecessor's). This is
      exactly the shape a LEGITIMATE idle-injection schedule that places
      nothing before D(0) (already ruled out by trigger (1)) but
      zero-or-more idle words at or after each LATER word's own admission
      would also produce — delay only ever accumulates across a frame, it
      never retreats, so a non-decreasing, D(0)-anchored departure sequence
      is structurally indistinguishable from such a schedule by cycle
      evidence alone. `FINDING RV-0078-S1-1`: WO-0078 §5.4's original rule
      here — "exactly one broken inter-word delta refuses; two or more
      asserts" — is UNSOUND, because two (or more) idles injected at two (or
      more) DISTINCT interior positions break two (or more) deltas while
      still producing exactly this non-decreasing, D(0)-anchored shape, and
      §5.4's rule asserted it — reddening a conformant design as a
      [Spec_cycle_mismatch] for a property of the stimulus, verbatim the
      REQ-016 §10 failure the original WO-0075 guard existed to avoid. Any
      OTHER nonzero [d] (a nonzero [d_0], or a departure sequence that ever
      DECREASES) cannot be produced by any legitimate injection schedule
      under a zero carried count, and is asserted normally instead, word by
      word. [why] names the departure sequence, or the carried count, that
      tripped the guard. A tier that silently asserted a constant on a
      stimulus it was not built for, or on an antecedent it could have been
      told about but chose to infer instead, is the failure this refusal
      exists to avoid (WO-0075 §3.2, citing `RV-0057-VERDICT` Finding 1 and
      `RV-0062` FINDING B-1; WO-0078 §5.2/§5.4 for the two original
      extensions; `FINDING RV-0078-S1-1` for trigger (2)'s successor rule).
      *)
type timing_divergence =
  | Admit_cycle_mismatch of
      { index : int
      ; ours : int
      ; theirs : int
      }
  | Spec_cycle_mismatch of
      { index : int
      ; word_index : int
      ; expected : int
      ; observed : int
      }
  | Unassertable of
      { index : int
      ; why : string
      }

(** - [base_aligned]: T0's verdict — [true] iff every frame index present on
      both sides carries the same [admit_cycle] on both sides.
    - [spec_divergences]: **T0**'s [Admit_cycle_mismatch] list when
      [base_aligned = false] (T1 and T2 are withheld — never computed — in
      that case, so this is the ONLY populated field); otherwise **T1**'s
      [Spec_cycle_mismatch] and [Unassertable] findings, and never a mix of
      T0 with T1 — the two never coexist in one report (WO-0075 §3.1's
      withholding rule).
    - [admit_cycles] (`FINDING RV-0078-S1-2`, limb (a)): **T0**, printed
      alongside the "aligned" verdict rather than left inferable from T1's
      own numbers. For every frame index common to both sides when
      [base_aligned = true], its shared [admit_cycle] — [ours]'s and
      [theirs]'s values are equal by construction of [base_aligned], so one
      value per index suffices. This is what makes pass criterion 2 ("the
      harness prints that case's frame-0 [admit_cycle] as 0") checkable on a
      GREEN run without inferring it from T1's [word 0] entry: inference
      sufficed only while every landed case shared case 0's one placement,
      itself verified only by a strictly-stronger instrument (the frozen
      stimulus's byte-identical hash, pass criterion 1) — a genuinely NEW
      stimulus (WO-0078 Stage 2's C1) carries no such instrument and needs
      this printed directly. Empty when [base_aligned = false] (a T0-RED
      report already names both sides' [admit_cycle] values per mismatched
      frame).
    - [own_profile] (WO-0078 §5.1, FINDING RV-0075-1): **T1**. For every
      accepted frame this tier did NOT refuse (i.e. not [Unassertable] under
      either of its two triggers above), its per-word [(expected, observed)]
      cycle pairs — [expected] is SPEC-M03 §6.1's own [admit_cycle + m + 3],
      [observed] is [ours]'s recorded [cycle] — in emission order, list
      position [=] word index. Populated and PRINTED whether or not any
      mismatch was found: the pre-WO-0078 lane printed a sentence on the
      clean path and no numbers at all, recoverable only by subtracting
      [offsets] from [reference_profile] — a green run quoting a different
      tier's data for its own numbers. Empty when [base_aligned = false].
    - [reference_profile]: **T2**. Every frame present on [theirs], with its
      own observed per-word cycles, in emission order. Printed, never
      adjudicated (WO-0075 §3.3) — empty when [base_aligned = false].
    - [offsets]: **T2**. For every frame index present on both sides with at
      least one output word on each, the per-word [theirs.cycle - ours.cycle]
      difference, word-by-word in emission order (words beyond the shorter
      side's count are simply not offered a pairing). Data only, contributing
      to no exit code (WO-0075 §3.3) — empty when [base_aligned = false]. *)
type timing_report =
  { base_aligned : bool
  ; spec_divergences : timing_divergence list
  ; admit_cycles : (int * int) list
  ; own_profile : (int * (int * int) list) list
  ; reference_profile : (int * int list) list
  ; offsets : (int * int list) list
  }

(** Runs T0 first; on a T0 red, returns immediately with T1 and T2 withheld
    (WO-0075 §3.1). Otherwise runs T1 over [ours] alone — "T1 runs on the
    [ours] transaction alone. It takes no argument from [theirs]" (WO-0075
    §3.2), only over frames [ours] itself reports [Accept] — and records T2
    from [theirs] alone plus the two sides' per-word offsets.

    [injected_idle_before_d0] (WO-0078 §5.2, FINDING RV-0075-2): an
    association, frame index to the count of idle XGMII words the STIMULUS
    recorded as injected at or before that frame's D(0) — never derived from
    [ours] or [theirs]'s own cycles, which is exactly what the finding rules
    out (a uniform shift from an idle at D(0) is indistinguishable from a
    genuine timing defect by inspection of cycles alone). A frame index
    absent from the list, or the argument omitted entirely, reads as a count
    of 0 for that frame — the gapless case, and every case this packet's
    Stage 1 ships (including case 0, unedited). Still "no argument from
    [theirs]": the count concerns [ours]'s own admitted frames only, sourced
    from the stimulus side rather than from either canonical file. *)
val check_timing
  :  ours:transaction
  -> theirs:transaction
  -> ?injected_idle_before_d0:(int * int) list
  -> unit
  -> timing_report

(** Prints, in this order (WO-0075 §5.1; WO-0078 §5.1 adds the per-word
    numbers on the clean path; `FINDING RV-0078-S1-2` fixes two gaps found in
    that repair's own printer, both bounded to a multi-frame case a
    one-frame transaction cannot reach): T0's verdict; on [base_aligned =
    true] ALSO [admit_cycles], one line per common frame index, printed
    UNCONDITIONALLY rather than left inferable from T1's own numbers (limb
    (a)); on [base_aligned = false] instead, T0's own divergences and the
    sentence that T1 and T2 are withheld and why — never an empty section,
    which reads as a pass. Then, on alignment, T1's own verdict sentence
    (clean, or its divergence list), FOLLOWED, UNCONDITIONALLY AND
    SEPARATELY (limb (b)), by [own_profile]'s per-word expected/observed
    table for every accepted, non-refused frame it carries — printed WHETHER
    OR NOT some OTHER frame in the SAME case's transaction diverged or was
    refused, because [own_profile] already excludes only the frames the
    guard itself refused, and gating the print on the whole transaction's
    [spec_divergences] (as the pre-repair printer did) hid a clean frame's
    own numbers behind an unrelated sibling frame's divergence —
    unreachable at one frame, reachable from Stage 2's first multi-frame
    case (C2) onward. Finally T2 under a heading containing the words
    RECORDED, NEVER ADJUDICATED. *)
val timing_report_to_string : timing_report -> string
