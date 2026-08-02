(** Octet time and the per-octet latency tagger of requirements.md §0.5.

    §0.5 (normative, at b4b4cf4) defines the octet time of an octet on an XGMII
    lane pair as [8 × cycle + lane index], and on an [Axi64] stream as
    [8 × cycle + byte position], where byte position [k] is
    [tdata\[8k+7 : 8k\]] (SPEC-M01 §6.1). The latency of octet [n] at a module
    is its octet time at the output minus its octet time at the input, and the
    module has constant latency iff that value is a single constant for every
    octet of every frame, at every length and content it accepts (REQ-005,
    REQ-111).

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

    {2 Cycles: two conversions, deliberately both offered}

    §0.5 converts a latency constant to cycles as [floor (L / 8)], and
    REQ-006's budget and REQ-019's §1.1 ceilings are compared against that
    figure. [cycles_floor] is that conversion, exactly as written.

    [word_cycles] is carry-forward C-1: §1.1's ceilings are word-cycle
    allocations, but [floor (L / 8)] understates a stripping stage's word-cycle
    delay by [ceil (h / 8)], since [L] has the stripped header subtracted out
    of it. [word_cycles ~strip_octets:h L = (L + h) / 8] is [Co − Ci], the
    figure the ceilings were actually allocated in — the quantity C-1 calls the
    word delay ΔC. The difference is lenient, not false — no conformant design
    fails the §0.5 comparison — but a sign-off packet should quote both, and
    C-1 asks for the spec to say which one §1.1 means. Offering only one of
    them here would decide that question by omission.

    If requirements.md adopts ΔC as the normative conversion (C-1's requested
    fix), nothing here changes: [word_cycles] becomes the figure a sign-off
    packet quotes and [cycles_floor] the superseded one, and the tagger keeps
    reporting both so a packet written against either wording is checkable. *)

val of_xgmii : cycle:int -> lane:int -> int
val of_axi64 : cycle:int -> byte_position:int -> int

(** §0.5 as written: [floor (L / 8)]. *)
val cycles_floor : int -> int

(** Carry-forward C-1: [(L + h) / 8], the word-cycle delay [Co − Ci]. *)
val word_cycles : strip_octets:int -> int -> int

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

  (** [create ~name ~strip_octets ()]. [strip_octets] is the number of leading
      octets the module under test removes from each frame (0 where it
      forwards the whole frame); output octet [j] is then input octet
      [j + strip_octets] of the same frame. *)
  val create : name:string -> strip_octets:int -> unit -> t

  (** Octet times of every octet of one frame at the module's input, in wire
      order. Frames are matched to outputs in order. *)
  val frame_in : t -> int array -> unit

  (** Octet times of every octet of the corresponding output frame. *)
  val frame_out : t -> int array -> unit

  (** The oldest unmatched input frame produced no output frame (it was
      discarded under §0.6, or is a §0.7 zero-payload frame). Pops it without
      comparing. *)
  val frame_dropped : t -> unit

  val name : t -> string
  val frames_compared : t -> int
  val octets_compared : t -> int

  (** Distinct latency values observed, ascending. *)
  val distinct : t -> int list

  val is_constant : t -> bool

  (** The single latency value when constant. *)
  val constant : t -> int option

  (** The first octet whose latency differed from the first one observed,
      rendered as text, or [None]. *)
  val first_offender : t -> string option

  (** Structural problems: an output frame with no matching input, a frame
      whose octet count does not match [input length − strip_octets]. *)
  val errors : t -> string list

  val is_clean : t -> bool

  (** Deterministic summary for an expect block: constant-or-not, the value in
      octet times and in both cycle conversions, the first offender when there
      is one. Never prints a histogram longer than eight entries, so a
      10 000-frame stress run stays reviewable (WO-0003 findings §13.2). *)
  val report : t -> string
end
