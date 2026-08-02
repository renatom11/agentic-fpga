(** The link partner's receive side: decoding transmit-side XGMII and judging it
    against SPEC-M04 (REQ-018's third clause — "it decodes transmit-side XGMII
    well enough to validate REQ-201 through REQ-205").

    Derived from SPEC-M04 §6.1 (the preamble word, the frame, padding, the FCS
    and its wire order, terminate and fill, the gap formula, and §6.1's
    cycle-by-cycle table), §6.3 item 4, §7 and §9 (the underflow word), plus
    requirements.md REQ-201 … REQ-207, REQ-209, REQ-304 and §0.3, all FROZEN at
    f78766e. No RTL was read.

    {2 What it judges, and what it only reports}

    Judged, one violation per breach with its REQ named:

    - {b REQ-201} — a start character in any lane but 0; a preamble word that is
      not [/S/], six 0x55 and one 0xD5; a start character inside a frame.
    - {b REQ-202} — the four octets before the terminate character are compared,
      in wire order, against [Frame.fcs] of everything before them, i.e. against
      [Dv_golden.Crc32_ref], the REQ-305 bit-serial oracle. REQ-202's
      verification column requires precisely this and warns off the alternative:
      a loopback through the design's own [Crc32_eth] would pass a systematically
      wrong but self-consistent CRC. REQ-304's residue over the whole frame is
      checked too, as corroboration that costs one call.
    - {b REQ-203} — fewer than 60 octets before the FCS, i.e. a frame below 64
      octets DA through FCS, means the padding did not happen. Which octets are
      pad is not decidable from the wire alone, so a bench that knows the source
      frame compares [frames] against [Frame.pad_to_60] itself.
    - {b REQ-204} — a gap below [ifg] octets counted from the terminate character
      inclusive (§0.3's convention), or a next start character that does not land
      in lane 0. SPEC-M04 §6.3 item 4 exempts the first frame, which has no
      preceding terminate character, and so does this decoder.
    - {b REQ-205} — any lane of the terminate word after the terminate character,
      or any lane of any gap word, that does not carry an idle character.
    - {b REQ-206} — the underflow word of §9 is recognised as [/E/] in lane 0
      followed by [/T/] in lane 1; anything else carrying an error character is a
      violation. An underflowed frame carries no FCS by design, so REQ-202 and
      REQ-203 are not asserted on it — asserting them would be the bench
      demanding the well-formed short frame §9 exists to prevent.

    Reported and not judged: the cycle of every start character
    ([start_cycles], [start_spacings]), because REQ-209's "one frame per 11
    cycles, and no spacing differing from 11" is a property of a {e run} of
    minimum-length frames, not of any one frame — the bench that chose the
    lengths is what may assert it. Same for REQ-207's octet-sequence equality,
    which needs the accepted source words the decoder never sees. *)

type frame =
  { start_cycle : int (** cycle of the word carrying this frame's [/S/] *)
  ; terminate_cycle : int
  ; terminate_lane : int
  ; octets : int list (** as decoded from the wire: DA through FCS *)
  ; underflowed : bool (** ended by §9's [/E/] [/T/] word rather than by [/T/] *)
  }

type violation =
  { cycle : int
  ; req : string
  ; detail : string
  }

type t

(** [create ~name ?ifg ()]. [ifg] is `cfg_ifg`, the minimum gap in octets
    counted from the terminate character inclusive (requirements.md §9.1's
    default 12; values below 12 are prohibited there). *)
val create : name:string -> ?ifg:int -> unit -> t

(** Present one XGMII word. Safe to call on every cycle including idle ones;
    that is the intended use. *)
val observe : t -> cycle:int -> Xgmii_word.t -> unit

val observe_all : t -> (int * Xgmii_word.t) list -> unit
val name : t -> string

(** Completed frames, in transmission order. A frame still in progress at the
    end of a run is not listed and is reported by [report] instead. *)
val frames : t -> frame list

val violations : t -> violation list
val start_cycles : t -> int list

(** Cycles between successive start characters — REQ-209's figure for a run of
    minimum-length frames, reported for the bench to assert. *)
val start_spacings : t -> int list

(** Octets from each terminate character inclusive to the next start character
    exclusive (§0.3), one per completed gap. *)
val gaps : t -> int list

val is_clean : t -> bool
val string_of_violation : violation -> string

(** Deterministic summary plus one line per violation. This is what belongs in
    an expect block. *)
val report : t -> string
