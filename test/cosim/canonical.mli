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
    - [octets]: the octets this word actually delivers, in ascending [tdata]
      position order. Length is exactly the popcount of [tkeep] — [write]
      and [read] both enforce this. *)
type word =
  { tkeep : int
  ; tlast : bool
  ; tuser0 : bool
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
    later frame. [words] is empty iff [decision = Discard]. *)
type frame =
  { index : int
  ; words : word list
  ; decision : decision
  }

type transaction = frame list

(** {2 Grammar (WO-0046 §2.3, pinned verbatim)}

    Text, one record per line, ASCII, LF endings, no trailing whitespace:
    {v
      F <frame-index>
      W <tkeep-hex-2> <tlast 0|1> <tuser0 0|1> <octet-hex-2>*
      D <frame-index> <accept|discard>
    v}
    Per frame, in the literal order the grammar block above states: one [F]
    line, then its [W] lines (zero or more) in emission order, then its [D]
    line. Frame indices are 0-based admission order and repeated verbatim on
    the [F] and [D] lines of the same frame ([read] rejects a mismatch).
    Hex fields are exactly 2 digits, lowercase, no [0x] prefix. Nothing else
    may appear in the file: no version string, tool name, path, timestamp or
    host identifier (those are the sidecar's business, WO-0046 §2.3, and the
    sidecar is never compared). *)

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
    already open, a [D] index that does not match its own frame's [F] index,
    a [W] line whose octet count disagrees with its [tkeep], or a file that
    ends with a frame still open (a [D] line owed and never written). *)
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

type report =
  { frames_compared : int
  ; frames_matching : int
  ; divergences : divergence list
  }

(** REQ-901's own comparison. *)
val compare_transactions : ours:transaction -> theirs:transaction -> report

(** REQ-901's Verification-column report, verbatim in shape: "frames
    compared, frames matching, and every divergence with the class it falls
    in or the defect it is." *)
val report_to_string : report -> string

(** [true] iff [report] carries no divergences. What [compare.ml]'s exit code
    is computed from. *)
val is_clean : report -> bool
