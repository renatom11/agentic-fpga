(** The link partner's arrival scheduler and XGMII emitter (REQ-018).

    REQ-018 makes the link partner a simulation model owned by DV under
    [test/], with a stated contract: "it emits start characters in lane 0 and
    lane 4 including the REQ-004 alternation; it injects each condition named in
    REQ-104, REQ-105, REQ-107, REQ-108 and REQ-110; and it decodes transmit-side
    XGMII well enough to validate REQ-201 through REQ-205." This module is the
    first clause; [Tx_decoder] is the third. The second — error injection —
    lands with `test/attack_plans/AP-xgmii_rx_64.md`, because an injection
    catalogue written before the attack plan is a catalogue nobody has reviewed
    for coverage. One of its rows also has no ruling as of this commit — an
    error character arriving during REQ-108's `Discard` state, carry-forward
    C-12 — and is marked NO-ASSERT until requirements.md settles it.

    Derived from requirements.md §0.3 (the gap convention, the DIC paragraph and
    the 84-octet budget), REQ-004 (the line-rate invariant), REQ-101 (start
    lanes), REQ-102 (the eight preamble octets), REQ-106 (the terminate
    character) and SPEC-M03 §8 (the stress stimulus), all FROZEN at f78766e. No
    RTL was read.

    {2 The schedule is arithmetic, not a policy}

    §0.3 fixes one convention: the inter-frame gap is counted {b from the
    terminate character inclusive} and its minimum is 12 octets. For a frame of
    [n] octets DA through FCS starting at octet time [s], the eight preamble
    octets occupy [s … s+7], the frame octets [s+8 … s+7+n], the terminate
    character sits at [s+8+n], and the next start character is 12 octet times
    later. At the minimum frame length that is 8 + 64 + 12 = {b 84} octet times
    between start characters — §0.3's own budget figure, 14.88 Mpps.

    Two things then fall out rather than being imposed, which is why the
    scheduler has one parameter and no choices:

    - 84 is not a multiple of 8, so the start lane {b alternates} 0, 4, 0, 4 …
      That is REQ-004's alternation and SPEC-M03 §8's "start characters
      alternating lane 0 and lane 4".
    - 84 octet times is 10.5 cycles, so the start-to-start spacing alternates
      {b 10 and 11 cycles} — REQ-004's figure, and the worst case the receive
      path must survive.

    A bench that asserted the alternation by construction would prove nothing
    about the arrival rate; here both are consequences of the gap arithmetic and
    are checkable against the requirement ([start_lanes], [start_spacings]).

    {2 Deficit idle count}

    §0.3: XGMII start characters may occupy only lane 0 or lane 4, so a gap must
    be rounded up to a multiple of 4 octets, and the receive-side link partner
    is assumed DIC-capable — it may shorten a later gap, {b never below 9
    octets}, so the average stays 12. That is implemented literally: rounding
    excess is banked as a credit and spent on the next gap, floored at 9. For
    SPEC-M03 §8's schedule the credit never moves (84 is already a multiple of
    4), so the worst-case cadence is produced by the gap arithmetic alone and
    the DIC path is exercised only by frame lengths that force a rounding — the
    unit tests drive one deliberately.

    {2 What the model does not decide}

    The preamble filler octets are 0x55 with an 0xD5 SFD, as SPEC-M03 §6.1's
    cycle table writes them, but REQ-102 forbids M03 from validating those
    values, so no bench may assert on them at the receiver. Nothing here emits
    a start character in a lane other than 0 or 4: SPEC-M03 §6.3 item 3 leaves
    that case deliberately unconstrained {e because} the link-partner contract
    never produces it, and producing it would commission a test for a stimulus
    the programme has decided not to make. *)

type frame =
  { index : int
  ; start_octet_time : int
  ; start_lane : int (** 0 or 4 (§0.3, REQ-101) *)
  ; octets : int array (** DA through FCS, requirements.md §0.3's length *)
  }

type t

(** [create ?ifg ?first_start ?fcs_valid frames] lays out one frame per entry of
    [frames], each given as its DA-through-FCS octets.

    - [ifg] is the minimum gap in octets counted from the terminate character
      inclusive (§0.3, default 12).
    - [first_start] is the octet time of the first start character (default 8,
      i.e. lane 0 of cycle 1, so that a bench sees one idle word before any
      frame). Must be a multiple of 4.
    - [fcs_valid] states whether every frame carries a correct FCS (default
      true). [check] verifies the REQ-304 residue over each frame when it is
      set; an injection schedule built later will clear it for the frames it
      corrupts rather than weakening the check for all of them. *)
val create
  :  ?ifg:int
  -> ?first_start:int
  -> ?fcs_valid:bool
  -> int list list
  -> t

(** SPEC-M03 §8's stress schedule: [count] minimum-length frames (64 octets DA
    through FCS) carrying incrementing sequence numbers, at the REQ-004 arrival
    rate. [count] defaults to REQ-004's 10 000. *)
val stress : ?count:int -> ?filler:(int -> int) -> unit -> t

val frames : t -> frame array
val ifg : t -> int

(** Cycle of the word carrying a frame's start character — SPEC-M03 §7's input
    measurement event and the base for its word delay. *)
val start_cycle : frame -> int

(** Octet time of the terminate character that closes a frame (REQ-106): the
    octet time immediately after its last FCS octet. *)
val terminate_octet_time : frame -> int

(** Octet times of every octet of the frame at M03's input, in wire order: the
    eight preamble octets from the start character inclusive, then the frame's
    octets DA through FCS. This is exactly the array
    [Dv_monitors.Octet_time.Latency.frame_in] expects, with [~strip_octets:8]
    and [~tail_octets:4] and the front offset the tagger then observes being 8
    at a lane-0 start and 12 at a lane-4 start (SPEC-M03 §7). *)
val in_times : frame -> int array

(** The octets M03 delivers for this frame (REQ-103): DA through the last octet
    before the FCS. The payload comparison of SPEC-M03 §8 check 2 is against
    this. *)
val delivered : frame -> int array

(** The XGMII word on [cycle], for any cycle — before the first frame, inside
    one, in a gap or after the last. Total, so a bench drives it from a plain
    cycle counter with no state of its own. *)
val word_at : t -> cycle:int -> Xgmii_word.t

(** Cycles the schedule occupies: through the gap that follows the last frame.
    A bench adds its own drain cycles for the module's word delay. *)
val cycles : t -> int

(** Every word of the schedule, paired with its cycle. Convenient for a
    hand-built schedule and deliberately not how the 10 000-frame run is
    driven — use [word_at] there. *)
val words : t -> (int * Xgmii_word.t) list

val start_lanes : t -> int list
val start_cycles : t -> int list

(** Cycles between successive start characters — REQ-004's alternating 10 and
    11 for the §8 schedule. *)
val start_spacings : t -> int list

(** Octets from each terminate character {b inclusive} to the next start
    character exclusive (§0.3's convention). *)
val gaps : t -> int list

(** The model's own conformance to the contract above, as a list of
    descriptions (empty when the schedule is conformant): start lanes outside
    {0, 4}; a gap below §0.3's 9-octet DIC floor or below [ifg] with no credit
    to spend; a running average gap below [ifg]; overlapping or out-of-order
    frames; and, when [fcs_valid] is set, a frame whose REQ-304 residue is
    wrong. A stimulus generator that is not checked against the requirement it
    encodes is an assertion about the design that nobody has verified. *)
val check : t -> string list

val is_clean : t -> bool

(** Deterministic summary for an expect block. Long runs print their first
    twelve entries per row and an ellipsis, so a 10 000-frame schedule stays
    reviewable. *)
val report : t -> string
