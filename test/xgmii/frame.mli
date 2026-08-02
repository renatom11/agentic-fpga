(** Frame octet strings for the link-partner model: the SPEC-M03 §8 stress
    stimulus, and the FCS the REQ-305 oracle computes for any frame.

    Derived from SPEC-M03 §8 (the stimulus table), requirements.md §0.3 (the
    DA-through-FCS length convention), REQ-202 (FCS wire order), REQ-203
    (padding), REQ-103 (what M03 delivers) and REQ-304 (the residue), all
    FROZEN at f78766e. The CRC itself is never computed here: every FCS comes
    from [Dv_golden.Crc32_ref], the bit-serial REQ-305 reference anchored on
    REQ-303's 0xCBF43926 in its own test suite. REQ-202's verification column
    requires exactly that — the wire octets are compared against an oracle
    independent of the design, never against a loopback through the design's
    own engine.

    {2 Length convention, restated because it is the one that gets confused}

    requirements.md §0.3: every frame length in this programme is measured
    {b DA through FCS inclusive}. A "64-octet frame" therefore carries 60
    octets before its 4 FCS octets, and M03 delivers those 60 (REQ-103). The
    preamble, the terminate character and the gap are never part of the length;
    they belong to the schedule, which is [Arrival]'s business. *)

(** [fcs octets] — the four FCS octets of a frame whose DA-through-payload
    octets are [octets], in REQ-202's wire order (least significant octet
    first), from the REQ-305 reference. *)
val fcs : int list -> int list

(** [with_fcs octets] appends [fcs octets]; the result is a frame DA through
    FCS in requirements.md §0.3's sense. *)
val with_fcs : int list -> int list

(** [pad_to_60 octets] — REQ-203's zero padding, applied to a
    destination-address-through-payload octet string below 60 octets. The
    transmit side (M04) does this; it is here so a decoder test can state what
    it expects to see on the wire. *)
val pad_to_60 : int list -> int list

(** [delivered frame] — the octets M03 emits for [frame] under REQ-103: every
    octet from the first destination-address octet through the last octet
    before the four FCS octets. Raises on a frame shorter than five octets,
    which has no delivered octets at all (REQ-107, §0.7) and is a schedule-level
    case rather than a builder-level one. *)
val delivered : int list -> int list

(** REQ-304: true iff the CRC over the whole frame including its own FCS equals
    the residue 0x2144DF1C. This is the check M03 performs (SPEC-M03 §6.1), run
    here on the model's own output so that a frame the model believes to be
    valid is provably valid before it is ever presented to a design. *)
val residue_ok : int list -> bool

(** SPEC-M03 §8's stimulus frame: 64 octets DA through FCS.

    {v
    0-5    destination MAC 02:00:00:00:00:01
    6-11   source MAC      02:00:00:00:00:02
    12-13  ethertype       0x0800
    14-17  32-bit frame sequence number, most significant octet at offset 14
    18-59  42 octets of filler
    60-63  the correct CRC-32 FCS, least significant octet first
    v}

    [filler] maps an offset in 18 … 59 to its octet and defaults to the offset
    itself. §8 requires "any fixed pattern, stated by the bench and constant
    across the run"; the default is stated here, is the same for every frame of
    a run, and is position-dependent so that a lane rotation or a word swap
    changes the delivered octets rather than being invisible in a run of
    identical filler. *)
val stress_frame : ?filler:(int -> int) -> sequence:int -> unit -> int list

(** The four-octet sequence number of a [stress_frame], read back from a
    delivered octet string at offsets 14 … 17 (REQ-020's order check). Raises
    if the string is shorter than 18 octets. *)
val sequence_of : int list -> int
