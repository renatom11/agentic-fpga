(** One observed word of an [Axi64] stream, in the encoding SPEC-M01 §6.1 fixes.

    This type is deliberately plain OCaml and carries no Hardcaml dependency:
    every monitor in this library consumes [Stream_word.t] values, so the
    monitors are unit-testable on hand-built traces with no DUT, no simulator
    and no elaboration. The one adapter that turns a live [Axi64.Source] into
    this type lives in the separate [dv_axi64_probe] library
    (`test/axi64_probe/`), which is the only file in DV that names a
    [hardcaml_axi] field.

    Octet positions follow SPEC-M01 §6.1: octet position [k] is
    [tdata\[8k+7 : 8k\]], and the first octet received from the wire is at
    [k = 0]. [tdata] is therefore an array of eight octet values rather than a
    single integer — a 64-bit [tdata] does not fit in OCaml's 63-bit [int], and
    the array makes the position convention the type's business rather than
    each caller's.

    {2 The §6.3-item-5 guard}

    SPEC-M01 §6.3 item 5 leaves unconstrained (a) the value of [tdata] at
    positions where [tkeep] is 0 and (b) the value of every field on a cycle
    with [tvalid] = 0, and states that no monitor may assert on them. Two
    consequences are built into this module rather than left to each caller:

    - [octets] returns only the octets at positions whose [tkeep] bit is set;
      it is the only sanctioned read of [tdata].
    - [to_string] prints nothing but ["idle"] for a word with [tvalid] = 0, and
      prints only kept octets otherwise, so an unconstrained value can never
      reach an expect-test snapshot and freeze into an accidental requirement. *)

type t =
  { tvalid : bool
  ; tdata : int array (** exactly 8 entries; [tdata.(k)] is octet position [k] *)
  ; tkeep : int (** 8 bits, bit [k] set when position [k] carries an octet *)
  ; tstrb : int (** 8 bits; REQ-014 requires 0 from every producer *)
  ; tlast : bool
  ; tuser : int (** 1 bit; REQ-013, meaningful only on the [tlast] word *)
  }

(** A cycle carrying no word. Every other field is zero, but a monitor must not
    look at them (§6.3 item 5) — see [garbage_idle] for the trace that proves
    it does not. *)
val idle : unit -> t

(** A cycle with [tvalid] = 0 whose other fields are deliberately nonsense.
    Used by the monitor's own unit tests to prove the §6.3-item-5 guard holds:
    a conformant monitor reports nothing for this word. *)
val garbage_idle : unit -> t

(** [of_octets octets] is a legal word carrying [octets] at positions
    0 .. [List.length octets - 1], with [tkeep] set to that many contiguous
    ones. Raises if the list is not 1 to 8 octets long, because SPEC-M01 §6.1
    gives no encoding to a zero-octet word (see requirements.md §0.7). *)
val of_octets : ?tstrb:int -> ?tuser:int -> ?tlast:bool -> int list -> t

(** Unchecked constructor for building deliberately illegal traces. [tdata] is
    padded with zeros or truncated to eight octet positions. *)
val raw
  :  tvalid:bool
  -> tdata:int list
  -> tkeep:int
  -> tstrb:int
  -> tlast:bool
  -> tuser:int
  -> t

(** Number of set bits in [tkeep]. *)
val keep_count : t -> int

(** True when [tkeep] is a run of one to eight ones starting at bit 0, i.e.
    [tkeep] = 2^n - 1 for n in 1 .. 8 (REQ-011). False for [tkeep] = 0. *)
val keep_is_contiguous_from_zero : t -> bool

(** Octets at the positions whose [tkeep] bit is set, in ascending position
    order. The only sanctioned read of [tdata] (§6.3 item 5). *)
val octets : t -> int list

(** Deterministic one-line rendering, safe to put in an expect snapshot. *)
val to_string : t -> string
