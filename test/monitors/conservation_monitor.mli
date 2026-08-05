(** Frame-conservation monitor for requirements.md §0.6.

    §0.6 states, over any bench run, at every module:

    {v
    (frames presented at the input) = (frames emitted at the output)
                                    + (zero-payload frames reported by a
                                       header-record valid pulse with no
                                       payload frame, §0.7)
                                    + (discard-strobe pulses)
    v}

    with aborted-but-forwarded frames counted as emitted. Any discrepancy is a
    silent discard and a REQ-008 violation. §0.6 makes this monitor mandatory
    in every bench, which is why it lives here, DUT-independent, and not inside
    any one module's bench.

    Derived from requirements.md at b4b4cf4 §0.6, §0.7, §12, REQ-007, REQ-008,
    REQ-009 and REQ-810. No RTL was read.

    {2 Three deviations from §0.6's literal text, each deliberate}

    {b 1. Discards are counted as frames, not as strobe pulses (carry-forward
    C-2).} §0.6's own "Strobe multiplicity" paragraph says that if two locally
    detected conditions apply to one frame, {e each} applicable condition's
    strobe pulses once. A frame discarded for two reasons therefore produces
    two pulses, and the equation as written over-counts it and reports a
    phantom surplus. This monitor takes [discarded ~strobes] — one call per
    discarded {e frame}, carrying the set of strobes that pulsed for it — and
    balances on frames. The raw pulse histogram is kept separately by
    [strobe_pulse], because REQ-008(a) and REQ-804 need per-strobe pulse counts
    and the two questions are genuinely different.

    {b 2. A discard with no strobe is an error, not a balanced discard.} It is
    exactly the silent discard REQ-008 prohibits, so [discarded ~strobes:\[\]]
    is refused rather than counted.

    {b 3. Exempt inputs (carry-forward C-2).} A frame presented while [clear]
    is asserted (REQ-009) or while receive-enable is 0 (REQ-810) is never
    accepted, so it is neither emitted nor discarded, and REQ-810 says
    explicitly that this "creates no silent-discard hole under REQ-008".
    Counting such frames as presented would make every reset and enable test
    report a false silent discard. [frame_in_exempt] records them, with a
    reason, outside the equation.

    A frame the module ACCEPTED and then abandoned mid-flight under [clear]
    is exempt too, and for a different reason: it is not emitted, because
    there is no output [tlast], and it cannot be attributed to a strobe,
    because REQ-009 is the one clause in SPEC-M03 that licenses a frame to
    vanish without one (SPEC-M03 §9's own "one real exception"). The common
    test is not "was it accepted" but "does §0.6 have a term for it" -- the
    stated ground above covers only the never-accepted case, and this
    sentence extends it to the mid-flight one without changing what the
    machinery below already does (WO-0072 §10.1, FINDING K-1).

    A zero-payload datagram at the top level (carry-forward C-3) is
    [zero_payload_header]: requirements.md §0.7 says the header record's
    [valid] pulse is the frame's only report, and §0.6 counts the frame as
    accounted for by that pulse. *)

type t

val create : name:string -> t

(** One frame presented at the module's input. *)
val frame_in : t -> unit

(** One frame presented at the input that the module was never able to accept
    — [clear] asserted (REQ-009) or receive-enable 0 (REQ-810). Recorded with
    its reason and excluded from the §0.6 equation. *)
val frame_in_exempt : t -> reason:string -> unit

(** One frame emitted at the module's output, i.e. one output [tlast].
    [aborted] records REQ-007's [tuser]\[0\] marking; an aborted frame is
    still an emitted frame under §0.6. *)
val frame_out : t -> aborted:bool -> unit

(** A frame whose output would have had zero payload octets, reported by a
    header record's [valid] pulse with no payload frame (§0.7). *)
val zero_payload_header : t -> unit

(** One frame discarded before any of its words was emitted, attributed to the
    strobes that pulsed for it (§0.6). Every name must be one of
    requirements.md §12's. *)
val discarded : t -> strobes:string list -> unit

(** One strobe pulse observed, for the raw per-strobe histogram REQ-008(a) and
    REQ-804 need. Independent of [discarded]: a bench calls both. *)
val strobe_pulse : t -> name:string -> unit

val name : t -> string
val frames_in : t -> int
val frames_out : t -> int
val frames_exempt : t -> int
val zero_payload : t -> int
val discards : t -> int
val aborts : t -> int

(** [frames_in - (frames_out + zero_payload + discards)]. Zero iff §0.6 holds.
    A positive residual is a silent discard; a negative one is a frame the
    module invented. *)
val residual : t -> int

(** Structural problems found while recording: an unknown strobe name, a
    discard with no strobe. Distinct from a non-zero residual. *)
val errors : t -> string list

(** True iff the residual is zero and [errors] is empty. *)
val is_clean : t -> bool

(** Deterministic summary: the equation, the residual, the strobe histogram
    sorted by name, and any errors. Belongs in an expect block. *)
val report : t -> string
