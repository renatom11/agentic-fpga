(** One XGMII word — the eight lanes of `xgmii_*d` plus the eight control bits
    of `xgmii_*c` — as a plain OCaml value.

    Derived from requirements.md §2 (the five control characters and the
    "a lane is control when the corresponding bit is 1" rule), REQ-012 (lane 0
    is the earlier octet on the wire and is bits [7:0]) and SPEC-M01 §4.1's
    [Xgmii] record, all FROZEN at f78766e. No RTL was read.

    Like [Stream_word.t] in the monitor library, this type carries no Hardcaml
    dependency on purpose: the whole link-partner model is exercisable on
    hand-built word sequences with no simulator, no elaboration and no DUT, so
    its own unit tests fail when the {e model} is wrong rather than when a
    design is. The single seam to a live [Xgmii] port is [to_wire] / [of_wire],
    which pin REQ-012's packing convention in one place — the same discipline
    [Crc32_ref.tdata_of_octets] applies on the stream side.

    {2 Why [Int64.t] on the wire side}

    A 64-bit lane word whose lane 7 holds 0x80 or above does not fit in OCaml's
    63-bit [int]. Lanes are kept as an eight-entry array here and converted only
    at the wire seam, so no arithmetic in this library can silently wrap. *)

(** requirements.md §2. *)

val idle_char : int (** [/I/] = 0x07 *)

val start_char : int (** [/S/] = 0xFB *)

val terminate_char : int (** [/T/] = 0xFD *)

val error_char : int (** [/E/] = 0xFE *)

val sequence_char : int (** [/Q/] = 0x9C *)

(** One lane of one word. [Control] carries the character's value, which is
    what makes an unexpected control character (a [/Q/] mid-frame, say)
    representable and therefore testable. *)
type lane =
  | Data of int
  | Control of int

type t =
  { data : int array (** exactly 8 entries; [data.(k)] is lane [k] *)
  ; control : int (** 8 bits; bit [k] set when lane [k] is a control character *)
  }

(** Eight idle characters. *)
val idle : t

(** [of_lanes lanes] from exactly eight lanes, lane 0 first. Raises otherwise. *)
val of_lanes : lane list -> t

(** Eight data octets, lane 0 first. Raises unless exactly eight. *)
val of_data : int list -> t

val lane : t -> int -> lane
val is_control : t -> int -> bool

(** True when every lane is [/I/] — the gap and idle condition REQ-109 and
    REQ-205 are stated against. *)
val is_idle : t -> bool

(** The lane index of a start character, or [None]. Does not judge the lane:
    REQ-201 (transmit, lane 0 only) and REQ-101 (receive, lane 0 or 4) are the
    judgments, and they belong to the decoder and to the scheduler's own
    contract check, not to the encoding. *)
val start_lane : t -> int option

val equal : t -> t -> bool

(** Deterministic rendering, lane 0 first, safe for an expect snapshot:
    control characters as [S], [T], [E], [I], [Q] or [C:xx] for any other
    control value, data octets as two hex digits. *)
val to_string : t -> string

(** REQ-012's packing: lane [k] occupies bits [8k+7 : 8k] of the data word, and
    bit [k] of the control word marks it. This is the one place the convention
    is written, so a probe attaching the model to a live [Xgmii] port has
    nothing to re-derive. *)
val to_wire : t -> Int64.t * int

val of_wire : Int64.t -> int -> t
