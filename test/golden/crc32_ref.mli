(** REQ-305: the independent bit-serial CRC-32 reference.

    Written from requirements.md §4 at b4b4cf4 (REQ-301 … REQ-305) and
    SPEC-M02 §6.1 at 22145b5. {b No RTL was read}, and in particular nothing
    of the parallel formulation M02 will use: REQ-305 names a bit-serial
    reference precisely so that the oracle shares no structure with the design
    (SPEC-M02 §6.1, "The REQ-305 oracle relationship"), and a table-driven
    implementation is a cross-check {e of} this reference, never a substitute
    {e for} it.

    {2 The value convention}

    SPEC-M02 §6.1 puts {b finished} CRC-32 values on [crc_in] and [crc_out],
    not the internal shift-register state, and this module matches it exactly
    so that the comparison against RTL is an identity with no conversion at
    either end. Three consequences, all of them things a bench author gets
    wrong if they are not stated:

    - The identity element is [0x00000000], because that is [CRC32("")]:
      REQ-301's initial value [0xFFFFFFFF] and its final XOR [0xFFFFFFFF] are
      both internal and cancel over an empty input. A caller seeds a frame with
      zero, {e not} with REQ-301's [0xFFFFFFFF]. Taking REQ-301's number as the
      port seed builds a bench that fails a conformant M02 on its first vector,
      and both numbers are individually correct — only their pairing is wrong.
    - [update] takes a running finished value and returns the running finished
      value that includes the octets, so [crc_out = update ~crc_in octets] is
      the RTL comparison verbatim.
    - The raw-register convention of most Verilog FCS blocks converts either
      way by [register = value lxor 0xFFFFFFFF] {e followed by a 32-bit
      reflection}; [register_of_running] and [running_of_register] are that
      conversion, and they are what produce requirements.md §4's provenance
      value [0xC704DD7B] from [residue].

    {2 Anchoring, which is a precondition and not a nicety}

    PROTOCOL §10 and charter §3 forbid a golden model from judging RTL before
    it agrees with an external anchor. The anchor named for this one is
    REQ-303's [0xCBF43926], the published CRC-32/ISO-HDLC check value, and it
    is asserted in [test_crc32_ref.ml] rather than assumed. [update_lsb_first]
    is a second, structurally different bit-serial arrangement (reflected
    register, reversed polynomial) kept so that agreement between two
    independent formulations is checkable in the same suite; it is a
    cross-check of my own arithmetic, not the external anchor. *)

(** REQ-301: 0x04C11DB7. *)
val poly : int

(** REQ-301: 0xFFFFFFFF, the {e register}'s initial value, which is not the
    port seed. See the note above. *)
val init_register : int

(** REQ-301: 0xFFFFFFFF. *)
val final_xor : int

(** REQ-303: 0xCBF43926, the CRC-32 of the nine ASCII octets "123456789". *)
val check_value : int

(** REQ-304: 0x2144DF1C, the residue of a frame concatenated with its own
    correct FCS appended least significant octet first (REQ-202). *)
val residue : int

(** [reflect ~bits x] reverses the low [bits] bits of [x]. *)
val reflect : bits:int -> int -> int

(** Convert a finished value (the port convention) to the raw register. *)
val register_of_running : int -> int

(** Convert a raw register to a finished value. *)
val running_of_register : int -> int

(** One octet through the REQ-301 register, stated verbatim: the octet is
    reflected in at bits 31:24, then eight shifts of the non-reflected
    register against [poly]. *)
val step_register : int -> int -> int

(** [update ~crc_in octets] is [CRC32(S · octets)] given [crc_in = CRC32(S)].
    The oracle every FCS bench imports. *)
val update : crc_in:int -> int list -> int

val update_string : crc_in:int -> string -> int

(** [of_octets octets = update ~crc_in:0 octets]. *)
val of_octets : int list -> int

val of_string : string -> int

(** The same function by an independent bit-serial route — reflected register,
    reversed polynomial 0xEDB88320, octets entering at the low end. Kept as a
    cross-check of [update], not as a replacement for it. *)
val update_lsb_first : crc_in:int -> int list -> int

(** REQ-202 wire order: the four FCS octets least significant first. *)
val fcs_octets : int -> int list

val octets_of_string : string -> int list

(** The 64-bit [tdata] value that carries [octets] at positions 0 upward
    (SPEC-M01 §6.1). Raises unless the list is 1 to 8 octets. Present because
    every directed FCS vector has to be packed into a word, and packing it by
    hand is where REQ-012's octet order gets reversed — SPEC-M02 §6.1's worked
    example pins [0x3837363534333231] for "12345678" for exactly that reason.

    [Int64.t] rather than [int]: a word whose octet position 7 is 0x80 or above
    does not fit in OCaml's 63-bit [int], and silently wrapping to a negative
    number in a CRC bench is the kind of defect that survives review. *)
val tdata_of_octets : int list -> Int64.t
