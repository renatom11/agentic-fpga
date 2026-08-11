(** Octet time and the per-octet latency tagger of requirements.md §0.5.

    §0.5 (normative, FROZEN at f78766e) defines the octet time of an octet on an
    XGMII lane pair as [8 × cycle + lane index], and on an [Axi64] stream as
    [8 × cycle + byte position], where byte position [k] is
    [tdata\[8k+7 : 8k\]] (SPEC-M01 §6.1). The latency of octet [n] at a module
    is its octet time at the output minus its octet time at the input, and the
    module has constant latency iff that value is a single constant for every
    octet of every frame, at every length and content it accepts (REQ-005,
    REQ-111) — {e per start lane} at the XGMII boundary, see "Three quantities"
    below.

    {2 Why this formulation and not word-in to word-out}

    This is the D-4 correction, and the reason it exists is worth keeping next
    to the code. At a module that strips a header whose length is not a
    multiple of eight (Ethernet 14, IPv4 20, UDP 8) and at a lane-4 XGMII
    start, one output word is assembled from two input words, so the
    cycle-counted per-octet difference takes {e two} values inside a single
    frame and a monitor built on it fails a conformant design. In octet times
    the realignment cancels exactly: a module stripping [h] octets that takes
    its first input word at cycle [Ci] and emits its first output word at cycle
    [Co] has [L = 8(Co − Ci) − h] for every octet, at both start lanes. The
    unit test [D-4: the cycle metric takes two values at a lane-4 start] is
    that argument made executable, so the finding cannot quietly regress.

    Because the tagger consumes the octet times a stress run already produces,
    REQ-005's constant-latency evidence is a by-product of the REQ-004 10 000
    frame run rather than a separate six-frame bench.

    {2 Three quantities, deliberately separate (WO-0012 deliverable 1)}

    Until WO-0012 this module had one [~strip_octets] parameter and used it for
    three different things. They coincide at a stream-to-stream stripping stage
    and part company at exactly the module the machinery exists for, M03
    [Xgmii_rx_64], so the conflation was invisible in the unit tests and would
    have surfaced as a wrong number in M03's own sign-off packet. The three:

    - [strip_octets] — {b octet correspondence}. Output octet [j] is input octet
      [j + strip_octets] of the same frame. At M03 this is the 8 preamble
      octets (REQ-102), at {b both} start lanes.
    - [tail_octets] — {b octets removed from the back}, which change the frame's
      length without shifting the correspondence. At M03 this is the 4 FCS
      octets (REQ-103). Nothing else in Phase 1 has one; it exists because
      without it M03's own frame cannot be handed to this tagger without lying
      about its input trace.
    - the {b front offset h} of §0.5, which is what the word delay
      [ΔC = (L + h − q)/8] is computed from. §0.5 states it as "(the octets the
      module removes from the front of the frame) + (the position, within the
      input word named by the measurement event, of the frame's first octet)",
      so at M03 it is {b 8} at a lane-0 start and {b 12} at a lane-4 start — a
      property of the module {e and the start lane}, pinned in the module spec
      §7 (SPEC-M03 §7: h = 8 / 12, L = 16 / 12, ΔC = 3 at both).

    The divergence, stated as the number it would have produced: for a
    conformant M03 frame at a lane-4 start, L = 12 and h = 12, so ΔC = 3 — the
    figure SPEC-M03 §7 pins and REQ-019 compares against §1.1's ceiling of 4.
    Computing it from the correspondence term instead gives (12 + 8)/8 = {b 2},
    understating the hardest receive module by a cycle in its own packet. The
    regression test [WO-0010's divergent case] drives that exact trace and shows
    both formulations on it.

    h is {b not} taken on trust: the tagger computes the observed front offset
    of every frame from its input trace — [in_times.(strip_octets) − 8 ×
    (in_times.(0) / 8)], the §0.5 definition verbatim, with the measurement
    event's octet-time base being the word carrying the frame's first octet at
    the input — and reports one whose value is not in the spec-declared
    [~front_offsets] set. That is REQ-019's second check ("the per-octet latency
    measured by the REQ-004 stress run … with h taken from the spec") made
    mechanical rather than clerical.

    {2 Constancy is per front offset, because §0.5 says so}

    §0.5's "Start lanes" paragraph: "At the XGMII boundary the two start lanes
    yield two constants differing by the 4-octet-time difference in the start
    character's position within its word; both are pinned in the module spec and
    SHALL differ by no more than 8 octet times (one cycle). Everywhere else L is
    a single value." SPEC-M03 §8's stress schedule alternates the start lanes,
    so a conformant M03 produces L = 16 and L = 12 in the {e same} run, and
    check 3 of §8 asks for "one value per start lane across all 10 000 frames,
    not a mean". A tagger that demanded a single L over such a run would fail a
    conformant design — the same defect class as D-4 — so constancy here is
    evaluated {e within} each front-offset class, and the relation {e between}
    classes is checked against §0.5's own bound: ordered by ascending h,
    [ΔC(larger h) ∈ { ΔC(smaller h), ΔC(smaller h) + 1 }].

    {2 The output offset q, and why this module carries it}

    §0.5's third quantity, added by the `C-RL-8` ruling and countersigned at
    [J-dv_lead-0180]: the {b output offset q} is the position, within the output
    word ΔC's output event names, of the first octet {e of the frame} at that
    output; equivalently (the octets the module inserts ahead of the frame)
    mod 8. It is the exact mirror of h's second term — h measures where the
    frame's first octet sits inside the {e input} word the measurement event
    names, q where it sits inside the {e output} word ΔC counts to — and like h
    it is a property of the module {e and the start lane}, pinned in the module
    spec §7 and not a free choice. q = 0 at every module that inserts nothing
    and at every module whose insertion is a whole number of words, which is
    every Phase-1 module except {b M07} (q = 6, a 14-octet insertion) and
    {b M15} (q = 4, a 20-octet insertion).

    {b Why an instrument that ignored it was a defect and not merely
    incomplete.} Keyed on h alone this module's conversion returns [None] for
    M07's (h = 0, L = 22) and M15's (h = 0, L = 28) and prints "no conformant
    module has this pair" — refusing two {e conformant} designs in those words.
    That is the same shape as [SCR-M03-I4] and as [FINDING AP-M04-1]: machinery
    built from an arithmetic statement no conformant design can satisfy. The
    finding against this file is [FINDING Q-1]'s consequence in DV's own lane
    ([J-dv_lead-0180] §6): a checker parameterised over the quantities a rule
    names is a site of that rule, and no search for the rule's subjects finds
    it, because it names none of them.

    {b REQ-021 does not make q zero and this module must not assume it does.}
    REQ-021 aligns the first octet a module {e emits}; q measures the first
    octet it {e forwards}, which at an inserting module is a later octet in a
    later word. So [Latency.frame_out]'s check on the first output octet's byte
    position is a check against the module's {e declared} [~output_offsets],
    which is REQ-021's alignment exactly when that set is [[0]].

    {2 Cycles: one normative conversion, one superseded}

    C-1 is CLOSED and SEALED (dv_lead's batch-B countersignature at f78766e):
    §0.5 converts a latency constant to cycles as the word delay
    [ΔC = (L + h − q)/8], and that is the unit of §1.1's ceilings and REQ-006's
    budget. [word_cycles] is that conversion and takes [~front_offset], not the
    correspondence term, plus [?output_offset]; it returns [None] rather than
    truncating when [(L + h − q)] is not a multiple of 8, because §0.5 makes
    that closure normative ("ΔC is a whole number … A specification pinning an L
    for which it is not describes a module that cannot exist"). Silently
    rounding past a free check is how a spec defect reaches a sign-off packet.

    [cycles_floor] is §0.5's superseded conversion, [floor (L / 8)]. It is kept
    — it is what the C-1 finding is {e about}, and the regression test needs to
    show both — but nothing this module prints quotes it any more. *)

val of_xgmii : cycle:int -> lane:int -> int
val of_axi64 : cycle:int -> byte_position:int -> int

(** §0.5's superseded conversion [floor (L / 8)]. Retained for the C-1 record
    only; not the unit of §1.1 or REQ-006. *)
val cycles_floor : int -> int

(** §0.5's front offset, from its own equivalence: h = (octets removed from the
    front of the frame) + (the position, within the input word named by the
    measurement event, of the frame's first octet). At M03,
    [front_offset ~strip_octets:8 ~start_lane:0 = 8] and
    [~start_lane:4 = 12] — SPEC-M03 §7's two rows. *)
val front_offset : strip_octets:int -> start_lane:int -> int

(** The normative conversion:
    [word_cycles ?output_offset:q ~front_offset:h L = Some ((L + h − q)/8)] when
    [(L + h − q)] is a non-negative multiple of 8, and [None] otherwise (§0.5:
    ΔC is a whole number). [?output_offset] defaults to 0, which is §0.5's own
    default — a specification stating no q is stating q = 0 — so every call
    written before q existed keeps its meaning and its answer. At M07 it is 6
    and at M15 it is 4, and without it those two conformant modules are refused
    (see "The output offset q" above). *)
val word_cycles : ?output_offset:int -> front_offset:int -> int -> int option

(** Octet times of the octets a word carries, ascending; the empty list for a
    word with [tvalid] = 0. Reads only positions whose [tkeep] bit is set
    (SPEC-M01 §6.3 item 5). *)
val of_word : cycle:int -> Stream_word.t -> int list

(** Octet times of a whole observed stream, in order, given (cycle, word)
    pairs. This is the array a bench hands to [Latency.frame_in] /
    [Latency.frame_out]. *)
val of_words : (int * Stream_word.t) list -> int array

module Latency : sig
  type t

  (** One class: every frame whose observed (h, q) pair was the same. A
      non-XGMII module that inserts nothing has one class; M03 has two
      (SPEC-M03 §7). The key is the pair because §0.5 makes q, like h, a
      property of the module {e and the start lane}. *)
  type observed =
    { front_offset : int
    ; output_offset : int
          (** the observed q of this class — the byte position, within the
              output word ΔC names, of the frame's first octet at the output.
              0 at every Phase-1 module but M07 (6) and M15 (4). *)
    ; latencies : int list
          (** distinct L values observed in this class, ascending; exactly one
              on a conformant module *)
    ; word_delay : int option
          (** [ΔC = (L + h − q)/8] when the class has a single L and the triple
              closes mod 8; [None] otherwise *)
    ; frames : int
    ; octets : int
    }

  (** [create ~name ~strip_octets ~tail_octets ~front_offsets ?ceiling ()].

      - [strip_octets]: leading octets the module removes (output octet [j] is
        input octet [j + strip_octets]). 8 at M03 (REQ-102), 14 at M06, 0 where
        the whole frame is forwarded.
      - [tail_octets]: trailing octets the module removes. 4 at M03 (the FCS,
        REQ-103), 0 everywhere else in Phase 1.
      - [front_offsets]: the h values the module's spec §7 pins, one per start
        lane. [[8; 12]] at M03; [[14]] at M06; [[0]] at a non-stripping stage.
        A frame whose observed h is outside this set is reported as an error,
        not silently classified.
      - [output_offsets]: the q values the module's spec §7 pins, one per start
        lane, defaulting to [[0]] — §0.5's own default, a specification stating
        no q is stating q = 0. [[6]] at M07 and [[4]] at M15, the two Phase-1
        modules whose insertion is not a whole number of words. A frame whose
        observed q is outside this set is reported, on the same discipline as
        h: at a module declaring [[0]] that report {e is} REQ-021's
        producer-side alignment failing; at an inserting module it is a q the
        specification does not pin.
      - [ceiling]: the §1.1 ceiling on ΔC, when the module has one (4 at M03).
        Supplied, the tagger reports a ΔC above it as a REQ-019 failure; the
        cost C-1's closure imposes on a sign-off packet is then paid by the
        machinery rather than by hand. *)
  val create
    :  name:string
    -> strip_octets:int
    -> tail_octets:int
    -> front_offsets:int list
    -> ?output_offsets:int list
    -> ?ceiling:int
    -> unit
    -> t

  (** Octet times of every octet of one frame at the module's input, in wire
      order — at M03 the eight preamble octets from the start character
      inclusive, then the frame's octets DA through FCS. Frames are matched to
      outputs in order. *)
  val frame_in : t -> int array -> unit

  (** Octet times of every octet of the corresponding output frame.

      {2 The per-frame output extent (WO-0033 items X-5 and X-9 — one repair,
      two customers)}

      Without [?expected_octets] the extent is the {b clean-frame identity}
      (input length − [strip_octets] − [tail_octets]), which is what a frame
      that runs to completion satisfies and what every WO-0009 caller relies
      on. That identity is {e false} for every frame a module cuts short, and
      both receive modules with an attack plan have such frames:

      - **M03** (`AP-xgmii_rx_64.md` rows E1, F1, G1, G2, H1, H2): a frame
        aborted under REQ-105 or REQ-110 is truncated at the octet before the
        closing character and {b no FCS is removed} (SPEC-M03 §9), so the
        identity's [tail_octets] = 4 is wrong by four octets; REQ-108's
        truncation delivers exactly 1514 octets whatever the frame's length.
      - **M14** (`AP-ip_eth_rx_64.md` row I2, family E, every directed length):
        the removed tail is the Ethernet padding N − N′, which varies {e per
        datagram} while [tail_octets] is a run constant, and on REQ-605's
        truncation rows the payload is shorter still.

      [frame_dropped] covers only the frames that emit {e nothing}. A frame
      that emits a {e short} output frame had no entry point at all, so the
      alternative was to leave those rows untagged — which would exempt exactly
      the frames whose latency is most likely to be wrong, since an abort path
      that holds octets back is the defect REQ-005 exists to catch.

      [?expected_octets] is the number of octets the {b specification} says
      this frame delivers, computed by the bench from spec text (at M03,
      `Dv_xgmii.Injection.outcome.delivered`; at M14, total length − 20). It
      replaces the identity and nothing else: the delivered octets are always a
      {b prefix} of the frame's octets at both modules — truncation and padding
      removal both take from the back, and an abort forwards what arrived — so
      output octet [j] is still input octet [j + strip_octets] and the
      per-octet latency comparison is unchanged. Supplying an extent that is
      negative, or longer than the input trace less [strip_octets], is
      reported as an error rather than silently clamped.

      A caller that passes [~expected_octets] equal to the identity gets
      exactly the old behaviour; the regression test drives that equality so
      the repair cannot change a clean frame's verdict. *)
  val frame_out : t -> ?expected_octets:int -> int array -> unit

  (** The oldest unmatched input frame produced no output frame (it was
      discarded under §0.6, or is a §0.7 zero-payload frame). Pops it without
      comparing. *)
  val frame_dropped : t -> unit

  val name : t -> string

  (** Output frames offered to the tagger, whether or not they matched an input
      frame — so that the frame index in an error message is stable when one
      does not. *)
  val frames_compared : t -> int

  val octets_compared : t -> int

  (** One entry per front-offset class, ascending by h. *)
  val observed : t -> observed list

  (** Every distinct L observed, ascending, across all classes. At M03 over an
      alternating-lane run this is [[12; 16]] and that is conformant — read
      [observed] or [is_constant], not this, to judge REQ-005. *)
  val distinct : t -> int list

  (** True iff at least one octet was compared and every front-offset class has
      a single L (REQ-005, REQ-111, §0.5 "Start lanes"). *)
  val is_constant : t -> bool

  (** The single L, when the run produced exactly one front-offset class and
      that class has one value. [None] at M03 over a two-lane run — use
      [observed] there. *)
  val constant : t -> int option

  (** The single word delay ΔC, when every class has one and they all agree.
      This is the figure REQ-019 compares against §1.1, and the one a sign-off
      packet quotes. *)
  val word_delay : t -> int option

  (** The first octet whose latency differed from the first one observed {e in
      its own front-offset class}, rendered as text, or [None]. *)
  val first_offender : t -> string option

  (** Structural and derived problems: an output frame with no matching input;
      a frame whose octet count does not match input − strip − tail; an observed
      output offset outside the declared set — which at a module declaring
      [[0]] is an output frame that is not word-aligned (REQ-021); an observed
      front offset outside the declared set (§0.5); an (L + h − q) that is not a
      multiple of 8 (§0.5); a ΔC above the declared ceiling (REQ-019); two
      start-lane classes whose word delays are further apart than §0.5's
      bound. *)
  val errors : t -> string list

  (** [is_constant] and no errors. *)
  val is_clean : t -> bool

  (** Deterministic summary for an expect block: one header line, then one line
      per front-offset class carrying its L, its ΔC and the ceiling comparison,
      then the first offender and any errors. Never prints more than eight
      latency values per class, so a 10 000-frame stress run stays reviewable
      (WO-0003 findings §13.2). *)
  val report : t -> string
end
