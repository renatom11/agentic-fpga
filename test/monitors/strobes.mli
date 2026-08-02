(** The twenty-one strobe names of requirements.md §12 (the strobe appendix),
    in §12's order.

    §12 is normative and is the field list of the top-level status record
    (REQ-804) and the enumeration REQ-008 quantifies over. SPEC-M01 §4.2
    deliberately declines to restate the names — "a second copy of twenty-one
    normative names is a second place for them to drift" — which is the right
    call and has the consequence that {e every} copy must be checked against
    §12 by script rather than by eye. This list is a copy, so it is checked:
    `tools/check_records_vs_appendix.sh` compares it, and SPEC-M01's [Status]
    record, against §12 as ordered character-for-character sequences.

    Read from requirements.md at b4b4cf4. No RTL was consulted. *)

(** The twenty-one names, in §12 order. *)
val all : string list

val count : int

(** [mem name] is true when [name] is one of §12's strobes. The conservation
    monitor uses it to reject a discard attributed to a strobe requirements.md
    does not define, which would otherwise be an invisible way to balance the
    §0.6 equation. *)
val mem : string -> bool
