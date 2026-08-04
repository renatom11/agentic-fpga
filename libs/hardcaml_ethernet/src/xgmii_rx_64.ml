(** M03 [Xgmii_rx_64] — XGMII receive decode: lane pair in, frame stream out
    (SPEC-M03, FROZEN at f78766e, plus its §13 rows through C-18).

    The whole module is one fixed-delay pipeline. Nothing here is elastic, no
    word is ever withheld to the end of a frame and there is no [tready] to
    exist: REQ-112 makes the XGMII input unconditional and REQ-003 makes the
    output a [Source] with no [Dest]. Those two facts are what the charter's
    line-rate invariant reduces to at this module, and they are structural
    rather than behavioural — see the [I]/[O] records below.

    {2 The shape, in one paragraph}

    Stage A (combinational, on the raw input word) decodes the lane pair and
    decides, for this cycle, how many frame octets it covers, where they sit
    and which of §9's conditions it raises — plural, because one word carries
    up to three frames' octet times and REQ-102 evaluates every start and
    closure character at its own (§6.1, "More than one event in one input
    word"). Stage B registers the octets and that verdict once. Stage C
    registers them a second time and is where the
    output word is produced. Two register levels of payload storage — REQ-019's
    permitted depth and no more — with the second level existing for exactly
    one reason: the four FCS octets of a frame may lie in the input word
    *after* the one carrying the octets of output word m, so [tkeep] for word m
    cannot be decided until the next input word has been decoded (§6.1,
    "Removing the FCS without varying the latency"). The FCS is removed by
    [tkeep] and never by holding octets back, which is what makes REQ-103 and
    REQ-005 compatible.

    The same lookahead has a consequence the first revision of this module got
    wrong (BUG-0001): when the FCS straddles two aligned words, the word behind
    the one carrying `tlast` is left holding nothing but FCS octets, and the
    pipeline must be told to drop it. One control bit does that — not a third
    payload level, so REQ-019's depth is unchanged — and the block that raises
    it in {!create} carries the argument.

    ΔC = 3 at both start lanes (§7): the input word carrying the start
    character is cycle 0, and the first output word leaves on cycle 3. Two of
    those cycles are the register levels above; the third is the assembly
    register that turns a lane-4 start's split octets into a word (§6.1's
    "same frame at a lane-4 start").

    {2 Where in the cycle the outputs live}

    [rx_tvalid], [rx_tkeep], [rx_tlast], [rx_tuser] and the five strobes are
    combinational in the {e current} XGMII word — they are not registers, and
    at ΔC = 3 they cannot be. Output word m leaves on cycle m + 3 (§7), and
    §6.1's lookahead says its [tkeep] depends on the input word decoded on that
    same cycle: at a lane-4 start whose terminate character falls in lane 0,
    the character that ends the frame and the last delivered word's own cycle
    are the same cycle. Registering the decision would move every octet one
    cycle later and break §7's pinned L = 16 / 12.

    The consequence for anything that watches this module: M03's output during
    cycle t is f(registers at t, XGMII word at t) — the value a cycle simulator
    exposes {e before} the clock edge of cycle t, labelled cycle t. Read after
    the edge it is f(registers at t + 1, XGMII word at t), which is no cycle of
    this design at all whenever the frame ends on the cycle its last word
    leaves.

    {2 What this module deliberately does not do}

    It reads no header field and does not know where the Ethernet header ends
    (§2). It filters no address (REQ-407). It measures no receive gap. It never
    inserts an idle cycle of its own: an output cycle without [tvalid] inside a
    frame is one the input gave it (REQ-016, C-14.4). *)

open! Base
open Hardcaml

(* ADR-0010: [open! Axi64] is the house consumer convention and the only one —
   the inner [Axi64] shadows the outer compilation unit, so [Axi64.Source.t]
   and [Xgmii.t] below read as SPEC-M03 §4.1 writes them. This module's ports
   use [Axi64] and [Xgmii] and no other record module, so this is the only
   record open here (ADR-0010 consequence 2). *)
open! Axi64

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; xgmii_rx : 'a Xgmii.t [@rtlprefix "xgmii_rx"]
    ; cfg_rx_enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { rx : 'a Axi64.Source.t [@rtlprefix "rx_"]
    ; error_bad_fcs : 'a
    ; error_bad_frame : 'a
    ; error_runt : 'a
    ; error_oversize : 'a
    ; error_start_without_terminate : 'a
    }
  [@@deriving hardcaml]
end

(* ---- XGMII control characters (requirements.md §2, SPEC-M03 §4.2) ----
   Only these five have meaning in this programme. [idle] and [ordered_set]
   are named but never compared against: REQ-113 says every control character
   that is not [start], [terminate] or [error] is ignored, and the way to
   implement "ignored" without a hole is to test for the three that matter and
   let everything else fall through. They are constants of the specification,
   not of this implementation. *)
let start_char = 0xfb
let terminate_char = 0xfd
let error_char = 0xfe

(* ---- pinned frame-length constants (REQ-107, REQ-108) ----
   §5: M03 has no parameter, and these two are pinned by REQ-108 and REQ-107
   rather than overridable — a test that shortened them would be testing a
   different requirement. *)

(* REQ-107: a frame with fewer than 64 octets between start and terminate is a
   runt. Fewer than 5 is a second threshold (§9's sixth row, §0.7), and it is
   a named constant here rather than an emergent property — which is the whole
   of what WO-0036 repairs.

   Until this repair the argument for having no constant was that the
   threshold "falls out of the FCS removal": a frame with four or fewer
   received octets has nothing left once the four FCS octets are unmarked, so
   the output decision below emits no word for it. That is true of the
   **output word** and false of the **strobe**, and the strobe is observable.
   §9's ninth co-occurrence ruling (1fe71ca) decides it: `error_bad_fcs` SHALL
   NOT pulse for this class, `error_runt` pulses alone, and a bench asserts
   that as an exact strobe set rather than a lower bound. REQ-104 is the
   ground one document up — the strobe reports a disagreement between a
   *received FCS* and a CRC over the octets preceding it, and a frame with
   nothing to remove an FCS from supplies **neither** operand — so the
   comparison here is not redundant, it has no operands to make. §6.2's
   `Frame` row carries the same scope on the `/T/` exit that sequences the
   check, which is the site an implementation codes and is where the gate
   below sits. *)
let runt_threshold = 64
let fcs_min_octets = 5

(* REQ-108: more than 1518 octets received is oversize; exactly 1514 are then
   delivered, which this design obtains by capping coverage at 1518 and
   letting the four-octet tail removal run — see the truncation comment in
   {!create}. *)
let oversize_threshold = 1518

(* The received-octet counter must hold [oversize_threshold] + 8 without
   wrapping — the count is advanced by up to eight octets per cycle and is
   compared after the advance — so 11 bits (2047) is the smallest width that
   cannot alias. Aliasing here would turn an oversize frame into a runt. *)
let count_bits = 11

(* REQ-304's residue: the CRC-32 over a frame concatenated with its own correct
   FCS, in M02's finished-value convention (ADR-0006). This is the whole FCS
   check (§6.1) — one equality against one constant, with no octet-order
   reassembly of the received FCS to get wrong. *)
let fcs_residue = 0x2144_df1c

(* ---- FSM states (§6.2) ----
   Four states, named as §6.2's table names them. Binary encoding is the
   [Always.State_machine] default and §6.3 item 2 leaves the encoding
   unconstrained, so nothing is chosen here that a test may rely on. *)
module State = struct
  type t =
    | Idle
    | Preamble
    | Frame
    | Discard
  [@@deriving compare, enumerate, sexp_of]
end

(* ---- stage A: what one input word is ----
   A pure decode of the lane pair (§6.1, "Decoding the lane pair"). Lane k is a
   control character iff [c] bit k is set, and its value is [d\[8k+7:8k\]]. A
   lane not marked control is a data octet whatever its value — which is
   REQ-102's "values not validated" and REQ-113's "ignored" in one sentence.

   Everything below is a per-lane vector, bit k for lane k, so that the lane
   searches downstream are ordinary bit arithmetic rather than eight-way
   conditionals. *)
type lanes =
  { is_start : Signal.t (** 8 bits: lane k carries [/S/] *)
  ; is_terminate : Signal.t (** 8 bits: lane k carries [/T/] *)
  ; is_error : Signal.t (** 8 bits: lane k carries [/E/] *)
  }

let decode_lanes (xgmii : Signal.t Xgmii.t) =
  let open Signal in
  let lane k = select xgmii.d ((8 * k) + 7) (8 * k) in
  let control k = bit xgmii.c k in
  let matches k value = control k &: (lane k ==:. value) in
  let vector ~f = concat_lsb (List.init 8 ~f) in
  { is_start = vector ~f:(fun k -> matches k start_char)
  ; is_terminate = vector ~f:(fun k -> matches k terminate_char)
  ; is_error = vector ~f:(fun k -> matches k error_char)
  }
;;

(* [lowest_set v] — a one-hot vector marking the least significant set bit of
   [v], and [any v] its reduction. The idiom is [v &: ~:(v - 1)] restricted to
   [v <> 0]; written as a fold instead so that it is readable as "lane k is the
   first one" and so no borrow chain is implied where none is wanted.

   Why the *lowest* lane: a frame is closed by the earliest closure character
   above the octet time at which that frame opened, because it is already
   closed when a later character arrives (§9's closure list). That is a
   statement about **one frame**, not about one word. A word carries up to
   three frames' octet times — the one open on entry, one opened by a [/S/] in
   lane 0, one opened by a [/S/] in lane 4 — and each gets its own search over
   its own lane range, which is how "every start and closure character is
   evaluated at its own octet time" (REQ-102, SPEC-M03 §6.1) is realised. See
   the epoch block in {!create}. *)
let lowest_set v =
  let open Signal in
  let bits = bits_lsb v in
  let _, marks =
    List.fold_map bits ~init:gnd ~f:(fun seen b -> seen |: b, b &: ~:seen)
  in
  concat_lsb marks
;;

let any v = Signal.(v <>:. 0)

(* [index_of_onehot v] — the lane index of a one-hot 8-bit vector, widened to 4
   bits so that the index and the value 8 ("all eight lanes are below it") are
   both representable in one signal. [Signal.onehot_to_binary] is the library
   primitive for this (charter §3: library primitives over hand-rolled
   equivalents); it returns 3 bits for an 8-bit input, and it is exact for a
   one-hot input, which every use below has already made one-hot through
   {!lowest_set}. *)
let index_of_onehot v = Signal.uresize (Signal.onehot_to_binary v) 4

let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
  let open Signal in
  let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in
  let sm = Always.State_machine.create (module State) spec in
  let lanes = decode_lanes i.xgmii_rx in
  let have_terminate = any lanes.is_terminate in
  (* A control lane that is none of §9's three characters — an idle character
     or an ordered set. What it means depends on *where* it falls, and REQ-102's
     third sentence is what decides: in a **preamble position** it is "any other
     control character" and ends the frame under REQ-105 (§6.2's [Preamble] row;
     the M03-N3 ruling at 541ea43); anywhere else inside an open frame it ends
     this word's coverage and carries the frame forward without closing it
     (REQ-016, C-14.4); outside a frame it is ignored (REQ-113). *)
  let other_ctl =
    i.xgmii_rx.c &: ~:(lanes.is_start |: lanes.is_terminate |: lanes.is_error)
  in
  (* [mask_ge k] — lanes k and above; [mask_lt k] — lanes below k. Both take a
     4-bit index in 0 … 8, so "no lanes" and "all lanes" are expressible
     without a special case. *)
  let lane_masks_ge =
    [ 0xff; 0xfe; 0xfc; 0xf8; 0xf0; 0xe0; 0xc0; 0x80; 0x00 ]
    |> List.map ~f:(of_int ~width:8)
  in
  let lane_masks_lt =
    [ 0x00; 0x01; 0x03; 0x07; 0x0f; 0x1f; 0x3f; 0x7f; 0xff ]
    |> List.map ~f:(of_int ~width:8)
  in
  let mask_ge k = mux k (lane_masks_ge @ List.init 7 ~f:(fun _ -> zero 8)) in
  let mask_lt k = mux k (lane_masks_lt @ List.init 7 ~f:(fun _ -> ones 8)) in
  let keep_of_count c = mux c (lane_masks_lt @ List.init 7 ~f:(fun _ -> ones 8)) in
  let in_preamble = sm.is State.Preamble in
  let in_frame = sm.is State.Frame in
  (* The start lane of the frame currently being received, captured when that
     frame is accepted. Distinct from [off4] below, which is the *alignment*
     offset and deliberately lags it (see the alignment section). *)
  let frame_start4 = wire 1 in
  (* ---- the three octet-time epochs of one input word (REQ-102, §6.1) ----
     A word is decoded as up to three frames' octet times, in lane order:

     - **epoch A**, the frame open on entry to this word (states [Preamble] and
       [Frame]);
     - **epoch B**, a frame opened by a [/S/] in lane 0;
     - **epoch C**, a frame opened by a [/S/] in lane 4.

     REQ-101 begins a frame in lane 0 and in lane 4 only, so there are exactly
     these three and never a fourth. Each is closed by the lowest closure
     character *above its own opening octet time* — three independent lane
     searches, which is what "every start and every closure character is
     evaluated at its own octet time, against the frame open at that octet
     time" (§6.1, §9's clause (a)) reduces to on a 64-bit datapath. A [/S/] in
     lane 2 closes epoch A and opens nothing, because §6.3 item 3 leaves a
     start character outside lanes 0 and 4 unconstrained and this module's
     alignment window has two offsets, not eight.

     One fact collapses the coverage problem to what it already was. The eight
     octets from a start character inclusive are preamble (REQ-102) and a word
     has eight lanes, so **a frame opened in this word covers no frame octet in
     it**: only epoch A contributes octets, and its coverage is the same
     contiguous run this module has always emitted. That is also why epochs B
     and C always deliver zero octets and always report two cycles later (§9).

     [cov_first] is the first lane of this word carrying an epoch-A octet. In
     [Idle] and [Discard] nothing is covered, which is written as lane 8. In
     [Preamble] — the cycle after the start word — the remaining preamble
     octets occupy lanes 0 … 3 at a lane-4 start and none at a lane-0 start, so
     [cov_first] is the frame's own start lane. From [Frame] onward it is 0. *)
  let a_open = in_preamble |: in_frame in
  let cov_first =
    mux2
      in_preamble
      (mux2 frame_start4 (of_int ~width:4 4) (of_int ~width:4 0))
      (mux2 in_frame (of_int ~width:4 0) (of_int ~width:4 8))
  in
  (* Epoch A's own preamble positions inside this word: lanes 0 … 3, and only
     at a lane-4 start, where the eight preamble octets run from lane 4 of the
     start word through lane 3 of this one (§6.1). At a lane-0 start the whole
     preamble lay inside the start word, which is epoch B's or epoch C's
     business and never epoch A's. *)
  let a_pre_mask = repeat (in_preamble &: frame_start4) 8 &: of_int ~width:8 0x0f in
  (* Epoch A is open from lane 0 of this word, so its search covers all eight
     lanes. An other-control character closes it only in a preamble position
     (REQ-102 → REQ-105); elsewhere it is the REQ-016 hold, below. *)
  let a_closing_v =
    lanes.is_terminate |: lanes.is_error |: lanes.is_start |: (other_ctl &: a_pre_mask)
  in
  let a_close_oh = lowest_set a_closing_v in
  let a_char_end =
    mux2 (any a_closing_v) (index_of_onehot a_close_oh) (of_int ~width:4 8)
  in
  (* The REQ-016 hold: an other-control lane outside epoch A's preamble
     positions ends this word's coverage and carries the frame forward (§6.1's
     C-14.4 paragraph, REQ-113's ordered set). It is not a closure, so a
     closure character above it still acts at its own octet time — the whole
     point of the ruling. The stimulus that separates the two readings (an
     other-control lane *and* a closure character in one word inside an open
     frame) is not one §10 commissions: REQ-016's wrapper injects whole idle
     cycles, so the hold lane is lane 0 and no octet is at stake. Where it is
     driven anyway, coverage still stops at the hold lane. *)
  let a_hold_v = other_ctl &: ~:a_pre_mask in
  let a_hold_end =
    mux2 (any a_hold_v) (index_of_onehot (lowest_set a_hold_v)) (of_int ~width:4 8)
  in
  (* ---- REQ-108's truncation point ----
     [count] is the frame's received-octet total before this word. Coverage is
     capped so the total never passes 1518: a frame that ends at exactly 1518
     is the maximum legal frame and is not oversize, and a frame that would go
     past it is closed at the cap. Delivering 1514 of those 1518 is then the
     same arithmetic the FCS strip performs — REQ-108's "exactly 1514
     delivered" and REQ-103's "no FCS removal attempted" agree on the octet
     count, and no FCS is identified or checked (§9: never with
     `error_bad_fcs`). *)
  let count = wire count_bits in
  let cap_room = of_int ~width:count_bits oversize_threshold -: count in
  let cap_end =
    (* [cov_first + room], saturated at 8. Both saturations matter: a room of
       more than seven octets cannot bind inside one word, and [cov_first] is
       8 in the states that cover nothing, where an unsaturated sum would
       wrap into a spurious coverage. *)
    let room = mux2 (cap_room >=:. 8) (of_int ~width:4 8) (uresize cap_room 4) in
    let sum = uresize cov_first 5 +: uresize room 5 in
    mux2 (sum >=:. 8) (of_int ~width:4 8) (uresize sum 4)
  in
  let min2 a b = mux2 (a <: b) a b in
  let cov_end = min2 (min2 a_char_end cap_end) a_hold_end in
  (* Which of the two closes epoch A, the truncation point or the character.
     REQ-108's truncation wins only when coverage actually reaches the cap —
     a hold lane below it means the count never passed 1518 this cycle, so
     nothing was truncated. Where the truncation does win, everything above it
     belongs to a frame already closed and already reported, and pulses nothing
     (REQ-108, C-12). A character *at* the cap lane still acts, because the
     count has not passed 1518 at that octet time. *)
  let a_close_oversize =
    a_open &: (cap_end <: a_char_end) &: (cap_end <: a_hold_end) &: (cap_end <:. 8)
  in
  let a_char_acts = a_open &: ~:a_close_oversize in
  let a_closes_with v = a_char_acts &: any (v &: a_close_oh) in
  let a_close_terminate = a_closes_with lanes.is_terminate in
  (* REQ-102's third sentence, both halves: an `/E/` closes epoch A under
     REQ-105, and so does *any other* control character standing in one of
     epoch A's preamble positions — `/I/` and `/Q/` included (§6.2's [Preamble]
     row as revised at 541ea43). Outside a preamble position the same character
     is the hold above and closes nothing. *)
  let a_close_error =
    a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))
  in
  (* MUTATION GH-c1 -- WO-0058, NEVER MERGE. Seeded defect: a start character
     arriving in the [Discard] state -- after REQ-108's truncation point, while
     the remainder of the oversize frame is being discarded -- raises epoch A's
     REQ-110 closure as though a frame were still open, so a frame already
     closed and already reported by [error_oversize] draws a second report: one
     [error_start_without_terminate] on §9's two-cycles-after pin. §9's sixth
     co-occurrence ruling makes such a character REQ-108's resynchronisation
     rather than a second abort, pulsing nothing; C-12 is the carry-forward.
     SEEDED FOR [/S/] IN [Discard] ONLY: [a_closing_v], [cov_first] and the
     REQ-108 cap are untouched, so the truncation, its 1514-octet extent, its
     `tuser` bit 0 and its own [error_oversize] are unchanged; [to_preamble] is
     unchanged, so the receiver still resynchronises onto this very start
     character and receives what follows normally; and [Discard]'s own switch
     arm does not read [a_close_char], so the state sequence does not move. *)
  let discard_start = sm.is State.Discard &: any lanes.is_start in
  let a_close_start = a_closes_with lanes.is_start |: discard_start in
  let a_close_char = a_close_terminate |: a_close_error |: a_close_start in
  let a_close_now = (a_close_char |: a_close_oversize) &: ~:(i.clear) in
  (* Covered octets: lanes [cov_first, cov_end). Empty when cov_end <= cov_first,
     which is how a terminate character in lane 0 covers nothing (§6.1's second
     non-instance, C-18) and how [Idle] and [Discard] cover nothing. *)
  let cov_nonempty = cov_end >: cov_first in
  let cov = mask_lt cov_end &: mask_ge cov_first &: repeat cov_nonempty 8 in
  let cov_count = mux2 cov_nonempty (cov_end -: cov_first) (zero 4) in
  (* One-hot marker on the frame's *first* covered octet. Rotated through the
     same window as the octets, it becomes "this aligned word begins a new
     frame", which is what stops the FCS-removal lookahead below from reading
     the next frame's octets as a continuation of this one. Without it a
     REQ-110 restart whose new start character shares a word with the aborted
     frame's last octets would emit that frame's final word without `tlast`. *)
  let first_v =
    sel_bottom (binary_to_onehot cov_first) 8
    &: repeat (in_preamble &: cov_nonempty) 8
  in
  (* Epoch A's octet total. Only epoch A covers octets, so there is one counter
     and no base selection: the register is reloaded with 0 below on every word
     that hands a *new* frame forward, which is the cycle before that frame's
     first octet at both start lanes. *)
  let count_next = count +: uresize cov_count count_bits in
  (* ---- epochs B and C: the frames this word begins (REQ-101, REQ-110) ----
     A [/S/] in lane 0 opens epoch B and a [/S/] in lane 4 opens epoch C, each
     closing whatever was open at its own octet time — epoch A, or epoch B in
     the case §10's REQ-110 hook commissions ("`/S/` in lane 4 of a word whose
     lane 0 was `/S/`": the lane-0 character opens a frame, the lane-4
     character closes it with zero delivered octets and opens the next, one
     `error_start_without_terminate`).

     Every lane above an epoch's own start character is one of that frame's
     eight preamble positions, so REQ-102's third sentence routes *every*
     control character there and there is no hold case to distinguish: [/T/] to
     REQ-107, [/S/] to REQ-110, anything else — `/I/` and `/Q/` included — to
     REQ-105.

     [cfg_rx_enable] gates only the *beginning* of a frame (REQ-810, §4.3,
     ADR-0014): a frame already in flight completes under the old value
     (REQ-803) and its REQ-110 abort is still reported, because the abort
     belongs to a frame that was accepted — which is why [a_closing_v] above
     tests [lanes.is_start] ungated while the two epochs below are gated. *)
  let inword_closing above =
    (lanes.is_terminate |: lanes.is_error |: lanes.is_start |: other_ctl) &: above
  in
  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear) in
  let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear) in
  let b_closing = inword_closing (of_int ~width:8 0xfe) in
  let c_closing = inword_closing (of_int ~width:8 0xe0) in
  (* The epoch that carries past this word, if any. At most one can: a [/S/] in
     lane 4 is itself in [b_closing], so epoch C's existence closes epoch B,
     and both close epoch A. *)
  let survivor_b = b_exists &: ~:(any b_closing) in
  let survivor_c = c_exists &: ~:(any c_closing) in
  let begins = survivor_b |: survivor_c in
  let new_start4 = survivor_c in
  frame_start4 <== reg spec ~enable:begins new_start4;
  (* ---- the running CRC (§6.1's FCS check, ADR-0006, ADR-0007) ----
     Seeded to 0x00000000 on the cycle a start character is accepted, which is
     the cycle before the frame's first octet is covered. Updated on every
     cycle covering at least one frame octet, with [octet_count] = that many —
     1 to 8, never 0. On every other cycle the register is held by its enable
     and M02's result is ignored, so no update-by-zero is ever driven. *)
  let crc_reg = wire 32 in
  let crc_data = mux2 (cov_first ==:. 4) (srl i.xgmii_rx.d 32) i.xgmii_rx.d in
  let crc =
    Crc32_eth.hierarchical
      scope
      { Crc32_eth.I.crc_in = crc_reg; data = crc_data; octet_count = cov_count }
  in
  let crc_out = crc.Crc32_eth.O.crc_out in
  let crc_update = cov_count <>:. 0 in
  (* The value the residue is compared against is the one *after* this word's
     update, because §6.1 item 3 runs the coverage through the octet
     immediately preceding the terminate character — which is in this word. *)
  let crc_final = mux2 crc_update crc_out crc_reg in
  (* Whether this frame has an FCS at all (§9 row 6 and §9's ninth ruling,
     §6.2's `Frame` row, REQ-104). [count_next] is the frame's received-octet
     total through the closing character's own octet time, so it is exactly
     §9's "octets between start and terminate" on the cycle the closure is
     decided — including the cases where this word covers none of them (a
     terminate character in lane 0, where [count_next] is the count carried in
     from the previous word).

     The gate sits **on the residue comparison** rather than on the strobe
     that reports it, so that for this class no value derived from the
     comparison exists anywhere downstream: the check is not sequenced, which
     is §6.2's word for it. Gating only the strobe would have left the same
     bit computed and merely unread, one edit away from re-exposing the
     property the ruling names — the class is *content-dependent* under the
     refused reading, since the single four-octet frame `00 00 00 00` yields
     exactly REQ-304's residue while every other frame in the class yields
     something else, so a design that compares here reports "this frame's FCS
     is wrong" as a function of octets §9 says nothing is removed from. *)
  let has_fcs = count_next >=:. fcs_min_octets in
  let bad_fcs = has_fcs &: (crc_final <>: of_int ~width:32 fcs_residue) in
  (* One reload condition for both state registers, and it is [begins]: the
     word that hands a new frame forward is the word before that frame's first
     octet at both start lanes, whether the frame was admitted from [Idle] /
     [Discard] or opened by a REQ-110 abort. Epoch A's own closure never
     coincides with epoch A's opening, which is why the old base-selection mux
     on the count is gone rather than merely renamed. *)
  crc_reg <== reg spec (mux2 begins (zero 32) crc_final);
  count <== reg spec (mux2 begins (zero count_bits) count_next);
  (* ---- the closure record (§9) ----
     Everything §9 needs to say about a frame is decided on the cycle the
     frame closes, but it is *reported* on the cycle that frame's `tlast` word
     is emitted — one, two or zero cycles later (§6.1's drain derivation).
     The record therefore travels beside the payload as a three-age structure:
     age 0 is this cycle's closure, ages 1 and 2 are registered. Consumption
     always takes the oldest, and a record is always consumed by age 2, which
     is §9's pinned cycle for a frame that emits no word.

     This channel carries **epoch A only** — the frame whose octets this word
     may cover, and so the only one whose report cycle depends on when a
     `tlast` word leaves. Epochs B and C have their own path below. Epoch A
     closes at most once per word, and the three ages still hold every live
     record without a queue, for a reason worth writing down because the
     previous one ("two closures are never less than two cycles apart") is no
     longer true: consecutive-cycle closures are now reachable, since a frame
     opened at lane 0 or 4 of word W is epoch A of word W + 1 and may close
     there. But a record born at W + 1 in that situation belongs to a frame
     whose start word is W, so §6.1's m + 3 puts its first — and only — output
     word at W + 3, while the record born at W is consumed at W + 2 at the
     latest. Consumptions therefore never contend, and each record is at age 2
     exactly when its turn comes. *)
  let a_close_runt = a_close_terminate &: (count_next <:. runt_threshold) in
  let record_fields ~valid ~terminate ~error ~start ~oversize ~fcs ~runt =
    concat_lsb [ valid; terminate; error; start; oversize; fcs; runt ]
  in
  let r0 =
    record_fields
      ~valid:a_close_now
      ~terminate:a_close_terminate
      ~error:a_close_error
      ~start:a_close_start
      ~oversize:a_close_oversize
      ~fcs:(a_close_terminate &: bad_fcs)
      ~runt:a_close_runt
  in
  (* [consume] is defined by the output decision below; the two are mutually
     recursive through one cycle of register, so the wire is declared here. *)
  let consume = wire 1 in
  let r1 = wire 7 in
  let r2 = wire 7 in
  let valid_of r = bit r 0 in
  let sel_is_r2 = valid_of r2 in
  let sel_is_r1 = valid_of r1 &: ~:sel_is_r2 in
  let sel_is_r0 = ~:sel_is_r2 &: ~:sel_is_r1 in
  let sel = mux2 sel_is_r2 r2 (mux2 sel_is_r1 r1 r0) in
  r1 <== reg spec (r0 &: ~:(repeat (consume &: sel_is_r0) 7));
  r2 <== reg spec (r1 &: ~:(repeat (consume &: sel_is_r1) 7));
  let sel_valid = valid_of sel in
  let sel_terminate = bit sel 1 in
  let sel_error = bit sel 2 in
  let sel_start = bit sel 3 in
  let sel_oversize = bit sel 4 in
  let sel_bad_fcs = bit sel 5 in
  let sel_runt = bit sel 6 in
  (* ---- the second report path: an epoch opened *and* closed in one word ----
     Such a frame delivers no octet — its eight preamble octets fill the rest of
     the word — so §9 pins its report to exactly two cycles after this one, with
     no `tlast` word to carry `tuser`[0] (§0.7). Two fixed register stages are
     therefore the whole of its reporting path: no ageing, no consumption
     decision, because the cycle is not a function of anything downstream. This
     is the cheapest structure that satisfies §6.1's consequence 1, where the
     aborted frame's report and the new frame's report are pinned to *different*
     cycles and both must be produced.

     Three bits, not five, and the two absences rest on different grounds.
     `error_oversize` cannot be raised here because REQ-108 has no instance in
     an epoch that delivers no octet — the count never advances. `error_bad_fcs`
     cannot be raised here because **every** frame on this path is a zero-octet
     frame, its eight preamble octets filling the rest of the word, so every one
     of them is in the class §9's ninth ruling (1fe71ca) puts outside the FCS
     check. The bit is *removed from the vector* rather than driven low: this
     path has no octet count to test, so a gate would be a constant, and a
     constant is better written as an absent wire than as a wire that is always
     zero.

     This is the second half of the WO-0036 repair and it was the returned
     question of WO-0032. What the module did until now was pulse
     `error_bad_fcs` alongside `error_runt` here, on the argument that a
     zero-octet frame's running CRC is still the 0x00000000 seed and the seed is
     never REQ-304's residue. The inference was valid and its premise was wrong:
     REQ-104 makes this strobe a *comparison* between a received FCS and a CRC
     over the octets it follows, and such a frame has neither operand, so no
     comparison is made and there is no result to report.

     Epoch B's and epoch C's reports fall on the same cycle, so their strobe
     vectors are ORed. Where the two names differ, both pulse — which is what
     §0.6 permits and §6.1's consequences describe. Where they are the same the
     observable is one high cycle, which is precisely the stimulus §6.3 item 8
     declares unconstrained and forbids DV to produce. *)
  let inword_strobes ~exists ~closing =
    let oh = lowest_set closing in
    let closed = exists &: any closing in
    let terminate = closed &: any (lanes.is_terminate &: oh) in
    let error = closed &: any ((lanes.is_error |: other_ctl) &: oh) in
    let start = closed &: any (lanes.is_start &: oh) in
    (* bit 0 `error_bad_frame`, 1 `error_runt`, 2
       `error_start_without_terminate`. A terminate character raises the runt
       bit alone: the frame is under REQ-107's 64-octet threshold and under
       [fcs_min_octets], and it is the second of those that keeps
       `error_bad_fcs` out of this vector entirely (above). *)
    concat_lsb [ error; terminate; start ]
  in
  let q2 =
    reg
      spec
      (reg
         spec
         (inword_strobes ~exists:b_exists ~closing:b_closing
          |: inword_strobes ~exists:c_exists ~closing:c_closing))
  in
  (* ---- the state machine (§6.2) ----
     One [Always] switch, and every transition is a function of the closure
     signals decided above, so the table below reads against §6.2 row for row.
     [Preamble] is the cycle *after* the start word: the start word itself is
     decoded in the state the machine was already in, which is where the start
     character is accepted. What §6.2 calls "discarding the eight octets from
     the start character inclusive" is therefore split across the two — the
     start word's own lanes, and (at a lane-4 start only) lanes 0…3 of the
     next word, which [cov_first] excludes. §6.3 item 2 leaves the encoding
     and the internal division unconstrained; the observables are
     [cov_first]'s and the CRC enable's, and both are stated above. *)
  (* A frame continues into the next word iff an epoch opened here survives to
     lane 7 — [begins], computed above from the two in-word epochs and already
     carrying the `clear` and `cfg_rx_enable` gates. It takes priority over both
     other exits: over [to_discard] because a start character is REQ-108's
     resynchronisation rather than a second abort (§9's co-occurrence list), and
     over [a_close_char] because the frame that closure ended is not the frame
     that leaves this word. *)
  let to_preamble = begins in
  let to_discard = a_close_oversize in
  Always.(
    compile
      [ sm.switch
          [ State.Idle, [ when_ to_preamble [ sm.set_next State.Preamble ] ]
          ; ( State.Preamble
            , [ if_
                  to_preamble
                  [ sm.set_next State.Preamble ]
                  [ if_
                      to_discard
                      [ sm.set_next State.Discard ]
                      [ if_ a_close_char [ sm.set_next State.Idle ] [ sm.set_next State.Frame ] ]
                  ]
              ] )
          ; ( State.Frame
            , [ if_
                  to_preamble
                  [ sm.set_next State.Preamble ]
                  [ if_
                      to_discard
                      [ sm.set_next State.Discard ]
                      [ when_ a_close_char [ sm.set_next State.Idle ] ]
                  ]
              ] )
          ; ( State.Discard
            , [ if_
                  to_preamble
                  [ sm.set_next State.Preamble ]
                  [ (* REQ-108's resynchronisation. A terminate character ends
                       the discard; an error character is absorbed and is not
                       an exit, which §6.3 item 6 leaves unobservable either
                       way (C-12). *)
                    when_ have_terminate [ sm.set_next State.Idle ]
                  ]
              ] )
          ]
      ]);
  (* ---- the alignment window (REQ-021, §6.1's lane-4 paragraph) ----
     One rotation, shared by the octets and by their coverage vector, over the
     two-word window {this word, the previous word}. At offset 0 the aligned
     word is simply the previous input word; at offset 4 it is the previous
     word's upper four octets followed by this word's lower four. Aligned word
     m is always the frame's output word m − 2, at *both* start lanes, which
     is where §7's ΔC = 3 comes from: aligned word 0 of a frame is produced two
     cycles after its start word and is registered once more before it leaves.

     [off4] deliberately lags the frame's start lane by one cycle when the new
     offset is 4. A REQ-110 restart can put the aborted frame's last octets in
     the same word as the new frame's start character; the aborted frame's
     octets must still be rotated by the *old* offset, and this is the delay
     that gives them that. A new offset of 0 needs no delay, because in that
     case the aborted frame has no octets left in the window. *)
  let start4_pending = reg spec (begins &: new_start4) in
  let off4 =
    reg_fb spec ~width:1 ~f:(fun d ->
      mux2 (begins &: ~:new_start4) gnd (mux2 start4_pending vdd d))
  in
  let data_d = reg spec i.xgmii_rx.d in
  let cov_d = reg spec cov in
  let first_d = reg spec first_v in
  let rotate_hi window = select window 11 4 in
  let window_keep = concat_msb [ cov; cov_d ] in
  let window_first = concat_msb [ first_v; first_d ] in
  let al_data = mux2 off4 (select (concat_msb [ i.xgmii_rx.d; data_d ]) 95 32) data_d in
  let al_keep = mux2 off4 (rotate_hi window_keep) cov_d in
  let al_new = any (mux2 off4 (rotate_hi window_first) first_d) in
  let al_data_d = reg spec al_data in
  let al_keep_d = reg spec al_keep in
  (* ---- the output decision (§6.1's FCS removal, REQ-011, REQ-015) ----
     The word being emitted is the previous aligned word; the current aligned
     word is the one word of lookahead REQ-019 permits and §6.1 requires. Two
     counts decide everything: [pc], the octets of the word being emitted, and
     [nc], the octets of the word behind it.

     A word with fewer than eight octets is always the frame's last, because a
     frame's octets are contiguous from aligned position 0. So [nc] = 0 says
     the emitted word is the last, and 0 < [nc] < 8 says the *next* one is —
     which is exactly the case where the four FCS octets straddle the two, and
     the emitted word loses (strip − nc) of its own. No octet is ever held
     back: the FCS leaves by not being marked in [tkeep]. *)
  let pc = popcount al_keep_d in
  (* The lookahead counts only octets of the *same* frame: an aligned word that
     begins a new frame tells the word before it nothing except that it was the
     last of its own. *)
  let nc = mux2 al_new (zero 4) (popcount al_keep) in
  let strip = mux2 (sel_valid &: (sel_terminate |: sel_oversize)) (of_int ~width:4 4) (zero 4) in
  (* ---- the all-FCS tail word (REQ-103, REQ-015; BUG-0001) ----
     [emit_last_a] is the case where the FCS lies wholly inside the emitted
     word, and its [pc >: strip] guard is what stops a word made *only* of FCS
     octets from going out: §9's sixth row — the frame of fewer than five
     octets, [pc] = 4 = [strip], no output word at all — is that guard's own
     instance. [emit_last_b] is the straddling case: [nc] <= [strip] says every
     octet of the word *behind* the emitted one is an FCS octet, and
     [keep_count] below accounts for all four of them in the emitted word's own
     [tkeep], which is why that word carries `tlast`.

     That word behind is still in the two-word pipeline and arrives at this
     decision on the very next cycle as [pc] = [nc] <= 4 with [nc] = 0 behind
     it. By then the closure record has been consumed — §9 pins every strobe to
     the `tlast` cycle, so [consume] fires on the [emit_last_b] cycle and
     nothing is left to age — so [strip] is 0, [emit_last_a]'s guard reads
     [pc] > 0 instead of [pc] > 4, and the residual FCS octets leave as a
     second `tlast` word carrying [tuser] = 0 and no strobe. That is BUG-0001,
     and its excess is exactly the fill of that residual word.

     One registered bit carries the fact across the single cycle it has to
     survive. It cannot suppress a word of the *next* frame: a lookahead word
     that begins one forces [nc] = 0 through [al_new], and [emit_last_b] with
     it, so the word this bit suppresses is always the one whose octets were
     just counted into the previous word's [keep_count]. It cannot swallow a
     strobe either — [consume] does not read it, and a record reaching age 2
     still reports on its pinned cycle whether or not a word goes out. Frames
     ended by REQ-105, REQ-110 or `clear` never set it, because [strip] is 0
     for them and [emit_last_b] needs [nc] <= [strip] with [nc] >= 1. *)
  let fcs_tail_pending = wire 1 in
  let fcs_tail_now = reg spec fcs_tail_pending in
  let have_word = (pc <>:. 0) &: ~:fcs_tail_now in
  let emit_last_a = have_word &: (nc ==:. 0) &: (pc >: strip) in
  let emit_last_b = have_word &: (nc <>:. 0) &: (nc <=: strip) in
  fcs_tail_pending <== emit_last_b;
  let emit_full = have_word &: (nc >: strip) in
  let emit_tlast = emit_last_a |: emit_last_b in
  let keep_count =
    mux2 emit_last_a (pc -: strip) (mux2 emit_last_b (pc -: strip +: nc) pc)
  in
  let abort = sel_bad_fcs |: sel_error |: sel_start |: sel_oversize |: sel_runt in
  let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) in
  consume <== (sel_valid &: (emit_tlast |: sel_is_r2));
  (* Three of the five strobes are the union of the two report paths: epoch A's,
     consumed from the aged record on its `tlast` cycle or at age 2, and the
     in-word epochs', fixed two cycles after their word. §0.6 counts high
     cycles, so where the two coincide under one name the observable is a single
     high cycle — the §6.3 item 8 stimulus DV SHALL NOT produce — and where they
     differ each name is high on its own cycle.

     `error_oversize` and `error_bad_fcs` are the other two, and each has epoch
     A's path only: neither condition has an instance in a frame that delivers
     no octet (REQ-108's count never advances there, and §9's ninth ruling
     leaves such a frame with no FCS to check). Their union is therefore a
     one-term union and is written as one. *)
  let strobe s = consume &: s &: ~:(i.clear) in
  let q_strobe k = bit q2 k &: ~:(i.clear) in
  { O.rx =
      { Axi64.Source.tvalid
      ; tdata = al_data_d
      ; tkeep = keep_of_count keep_count
      ; tstrb = zero 8 (* REQ-014 *)
      ; tlast = emit_tlast &: ~:(i.clear)
      ; tuser = emit_tlast &: abort
      }
  ; error_bad_fcs = strobe sel_bad_fcs
  ; error_bad_frame = strobe sel_error |: q_strobe 0
  ; error_runt = strobe sel_runt |: q_strobe 1
  ; error_oversize = strobe sel_oversize
  ; error_start_without_terminate = strobe sel_start |: q_strobe 2
  }
;;

let hierarchical ?instance scope (i : Signal.t I.t) : Signal.t O.t =
  let module H = Hierarchy.In_scope (I) (O) in
  H.hierarchical ?instance ~scope ~name:"xgmii_rx_64" create i
;;
