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
    and which of §9's conditions it raises. Stage B registers the octets and
    that verdict once. Stage C registers them a second time and is where the
    output word is produced. Two register levels of payload storage — REQ-019's
    permitted depth and no more — with the second level existing for exactly
    one reason: the four FCS octets of a frame may lie in the input word
    *after* the one carrying the octets of output word m, so [tkeep] for word m
    cannot be decided until the next input word has been decoded (§6.1,
    "Removing the FCS without varying the latency"). The FCS is removed by
    [tkeep] and never by holding octets back, which is what makes REQ-103 and
    REQ-005 compatible.

    ΔC = 3 at both start lanes (§7): the input word carrying the start
    character is cycle 0, and the first output word leaves on cycle 3. Two of
    those cycles are the register levels above; the third is the assembly
    register that turns a lane-4 start's split octets into a word (§6.1's
    "same frame at a lane-4 start").

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
   runt. Fewer than 5 additionally produces no output word at all (§0.7) —
   that second threshold needs no constant here, because it falls out of the
   FCS removal: a frame with four or fewer received octets has nothing left
   after the four FCS octets are unmarked, and the output decision below
   emits no word for it. *)
let runt_threshold = 64

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

   Why the *lowest* lane: every one of §9's characters ends or begins a frame
   at its own position, and a word may carry two of them (a [/T/] in lane 2 and
   an [/E/] in lane 5, say). The one that acts is the earlier on the wire,
   because the frame is already closed when the later arrives — §9's closure
   list, applied within one word rather than across words. *)
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
  (* The lane searches. Each is the lowest lane carrying that character, which
     is the one that acts (see {!lowest_set}). *)
  let start_lane_oh = lowest_set lanes.is_start in
  let have_terminate = any lanes.is_terminate in
  let start_index = index_of_onehot start_lane_oh in
  (* REQ-101: only lanes 0 and 4 begin a frame. A start character in any other
     lane is not legal XGMII and §6.3 item 3 leaves the response unconstrained;
     recognising only these two is the reading that costs nothing and asserts
     nothing. *)
  let start_in_lane0 = bit lanes.is_start 0 in
  let start_in_lane4 = bit lanes.is_start 4 &: ~:start_in_lane0 in
  let start_here = (start_in_lane0 |: start_in_lane4) &: i.cfg_rx_enable in
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
  (* ---- which lanes of this word are frame octets (§6.1) ----
     [cov_first] is the first lane of this word that carries a frame octet.
     In [Idle] and [Discard] nothing is covered, which is written as lane 8.
     In [Preamble] — the cycle after the start word — the remaining preamble
     octets occupy lanes 0 … 3 at a lane-4 start and none at a lane-0 start,
     so [cov_first] is the frame's own start lane. From [Frame] onward it is 0.
     This is the whole of REQ-102: eight octets from the start character
     inclusive are discarded, and their values are never examined. *)
  let in_idle = sm.is State.Idle in
  let in_preamble = sm.is State.Preamble in
  let in_frame = sm.is State.Frame in
  let in_discard = sm.is State.Discard in
  (* The start lane of the frame currently being received, captured when that
     frame is accepted. Distinct from [off4] below, which is the *alignment*
     offset and deliberately lags it (see the alignment section). *)
  let frame_start4 = wire 1 in
  let cov_first =
    (* [Preamble] → the frame's start lane (0 or 4); [Frame] → 0; anywhere
       else → 8, which is "no lane of this word is a frame octet". *)
    mux2
      in_preamble
      (mux2 frame_start4 (of_int ~width:4 4) (of_int ~width:4 0))
      (mux2 in_frame (of_int ~width:4 0) (of_int ~width:4 8))
  in
  (* ---- where this word ends the frame (§9's closure list) ----
     A frame is open from the cycle its start character is accepted. Closure
     characters are searched from [search_from] upward: 0 in every state that
     is already inside a frame, and one lane past the start character in the
     start word itself, so that a control character in a preamble position is
     routed by §9 (REQ-102) while the start character does not close its own
     frame. The lowest such lane wins — the frame is already closed when a
     later character in the same word arrives (§9's closure list, applied
     inside one word). *)
  let search_from =
    mux2 in_idle (uresize start_index 4 +:. 1) (zero 4)
  in
  let search_mask = mask_ge search_from in
  let closing_terminate_v = lanes.is_terminate &: search_mask in
  let closing_error_v = lanes.is_error &: search_mask in
  let closing_start_v = lanes.is_start &: search_mask in
  let closing_v = closing_terminate_v |: closing_error_v |: closing_start_v in
  let close_lane_oh = lowest_set closing_v in
  let char_end = mux2 (any closing_v) (index_of_onehot close_lane_oh) (of_int ~width:4 8) in
  (* A control lane that is none of the three — an idle character or an ordered
     set — is not a frame octet and is not a condition. Inside an open frame it
     ends this word's coverage and carries the frame forward: REQ-016's idle
     cycle, which §6.1 says holds the frame and delays every later octet by
     eight octet times, and REQ-113's ordered set, which is ignored. Outside a
     frame it is already ignored, because nothing is covered there. *)
  let other_control_v = i.xgmii_rx.c &: ~:(lanes.is_start |: lanes.is_terminate |: lanes.is_error) in
  let other_masked = other_control_v &: search_mask in
  let other_end =
    mux2 (any other_masked) (index_of_onehot (lowest_set other_masked)) (of_int ~width:4 8)
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
  let cov_end = min2 (min2 char_end cap_end) other_end in
  (* A condition is raised only when its character is the first thing that ends
     this word's coverage: an idle character before it means the frame was
     already held, and the truncation point before it means REQ-108 closed the
     frame first. *)
  let char_first = (char_end <: other_end) &: (char_end <=: cap_end) in
  let close_oversize = (cap_end <: char_end) &: (cap_end <: other_end) &: (cap_end <:. 8) in
  let close_terminate = char_first &: any (closing_terminate_v &: close_lane_oh) in
  let close_error = char_first &: any (closing_error_v &: close_lane_oh) in
  let close_start = char_first &: any (closing_start_v &: close_lane_oh) in
  (* A frame is open in [Idle] only on the cycle its start character is
     accepted; in [Discard] the frame is already closed, so nothing there
     closes anything and no strobe can pulse (REQ-108, C-12). *)
  let frame_open = in_preamble |: in_frame |: (in_idle &: start_here) in
  let close_char = (close_terminate |: close_error |: close_start) &: frame_open in
  let close_now = (close_char |: (close_oversize &: frame_open)) &: ~:(i.clear) in
  (* [opens_now] — the frame open during *this* word started in this word, so
     its octet count and its CRC start here. [restart_now] — a REQ-110 start
     character closes the frame in flight and opens the next one, whose count
     and CRC start on the *following* word. Keeping the two apart is what
     makes a frame that opens and closes inside one word (a `/S/` followed by
     a `/T/` in a higher lane) report against its own zero-octet count rather
     than against the previous frame's total. *)
  let opens_now = (in_idle |: in_discard) &: start_here &: i.cfg_rx_enable in
  let restart_now = close_start &: frame_open &: i.cfg_rx_enable in
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
  let count_base = mux2 opens_now (zero count_bits) count in
  let count_next = count_base +: uresize cov_count count_bits in
  (* ---- the frame this word begins, if any (REQ-101, REQ-110) ----
     Two ways a frame begins: a start character accepted in [Idle] or
     [Discard], and a start character that closes the frame in flight
     (REQ-110), whose own lane is the new frame's start lane. The second case
     covers §10's "`/S/` in lane 4 of a word whose lane 0 was `/S/`": the
     lane-0 character opens a frame, the lane-4 character closes it with
     zero delivered octets and opens the next.
     [cfg_rx_enable] gates only the *beginning* of a frame (REQ-810, §4.3): a
     frame already in flight completes under the old value (REQ-803), and the
     REQ-110 abort of that frame is still reported, because the abort belongs
     to a frame that was accepted. *)
  let restart_lane = index_of_onehot close_lane_oh in
  let begins = (opens_now |: restart_now) &: ~:(i.clear) in
  let new_start_lane = mux2 (close_start &: frame_open) restart_lane start_index in
  let new_start4 = new_start_lane ==:. 4 in
  frame_start4 <== reg spec ~enable:begins new_start4;
  (* ---- the running CRC (§6.1's FCS check, ADR-0006, ADR-0007) ----
     Seeded to 0x00000000 on the cycle a start character is accepted, which is
     the cycle before the frame's first octet is covered. Updated on every
     cycle covering at least one frame octet, with [octet_count] = that many —
     1 to 8, never 0. On every other cycle the register is held by its enable
     and M02's result is ignored, so no update-by-zero is ever driven. *)
  let crc_reg = wire 32 in
  let crc_in_eff = mux2 opens_now (zero 32) crc_reg in
  let crc_data = mux2 (cov_first ==:. 4) (srl i.xgmii_rx.d 32) i.xgmii_rx.d in
  let crc =
    Crc32_eth.hierarchical
      scope
      { Crc32_eth.I.crc_in = crc_in_eff; data = crc_data; octet_count = cov_count }
  in
  let crc_out = crc.Crc32_eth.O.crc_out in
  let crc_update = cov_count <>:. 0 in
  crc_reg
  <== reg spec (mux2 restart_now (zero 32) (mux2 crc_update crc_out crc_in_eff));
  (* The value the residue is compared against is the one *after* this word's
     update, because §6.1 item 3 runs the coverage through the octet
     immediately preceding the terminate character — which is in this word. *)
  let crc_final = mux2 crc_update crc_out crc_in_eff in
  let bad_fcs = crc_final <>: of_int ~width:32 fcs_residue in
  count <== reg spec (mux2 restart_now (zero count_bits) count_next);
  (* ---- the closure record (§9) ----
     Everything §9 needs to say about a frame is decided on the cycle the
     frame closes, but it is *reported* on the cycle that frame's `tlast` word
     is emitted — one, two or zero cycles later (§6.1's drain derivation).
     The record therefore travels beside the payload as a three-age structure:
     age 0 is this cycle's closure, ages 1 and 2 are registered. Consumption
     always takes the oldest, and a record is always consumed by age 2, which
     is §9's pinned cycle for a frame that emits no word.

     Two closures can never be less than two cycles apart — a closure sends
     the machine to [Idle] or [Discard] for at least one cycle and a new frame
     spends its start word there — so at most two records are live and the
     three ages hold them without a queue. *)
  let close_runt = close_terminate &: frame_open &: (count_next <:. runt_threshold) in
  let record_fields ~valid ~terminate ~error ~start ~oversize ~fcs ~runt =
    concat_lsb [ valid; terminate; error; start; oversize; fcs; runt ]
  in
  let r0 =
    record_fields
      ~valid:close_now
      ~terminate:close_terminate
      ~error:close_error
      ~start:close_start
      ~oversize:close_oversize
      ~fcs:(close_terminate &: bad_fcs)
      ~runt:close_runt
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
  (* A frame continues into the next word iff one begins here and is not
     closed again by a terminate or error character in a higher lane of the
     same word. Exactly one closure per word is recognised — the lowest — and
     the link-partner contract of REQ-018 injects one condition at a time, so
     a word carrying two closures beyond the `/S/`-then-`/S/` case §10 names
     is outside both the specification's cases and this design's reporting
     structure (one record per cycle). This is stated rather than left to be
     discovered; it is returned as an open question, not resolved silently. *)
  let to_preamble =
    (opens_now &: ~:(close_terminate |: close_error)) |: restart_now
  in
  let to_preamble = to_preamble &: ~:(i.clear) in
  let to_discard = close_oversize &: frame_open in
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
                      [ if_ close_char [ sm.set_next State.Idle ] [ sm.set_next State.Frame ] ]
                  ]
              ] )
          ; ( State.Frame
            , [ if_
                  to_preamble
                  [ sm.set_next State.Preamble ]
                  [ if_
                      to_discard
                      [ sm.set_next State.Discard ]
                      [ when_ close_char [ sm.set_next State.Idle ] ]
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
  let have_word = pc <>:. 0 in
  let emit_last_a = have_word &: (nc ==:. 0) &: (pc >: strip) in
  let emit_last_b = have_word &: (nc <>:. 0) &: (nc <=: strip) in
  let emit_full = have_word &: (nc >: strip) in
  let emit_tlast = emit_last_a |: emit_last_b in
  let keep_count =
    mux2 emit_last_a (pc -: strip) (mux2 emit_last_b (pc -: strip +: nc) pc)
  in
  let abort = sel_bad_fcs |: sel_error |: sel_start |: sel_oversize |: sel_runt in
  let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) in
  consume <== (sel_valid &: (emit_tlast |: sel_is_r2));
  let strobe s = consume &: s &: ~:(i.clear) in
  { O.rx =
      { Axi64.Source.tvalid
      ; tdata = al_data_d
      ; tkeep = keep_of_count keep_count
      ; tstrb = zero 8 (* REQ-014 *)
      ; tlast = emit_tlast &: ~:(i.clear)
      ; tuser = emit_tlast &: abort
      }
  ; error_bad_fcs = strobe sel_bad_fcs
  ; error_bad_frame = strobe sel_error
  ; error_runt = strobe sel_runt
  ; error_oversize = strobe sel_oversize
  ; error_start_without_terminate = strobe sel_start
  }
;;

let hierarchical ?instance scope (i : Signal.t I.t) : Signal.t O.t =
  let module H = Hierarchy.In_scope (I) (O) in
  H.hierarchical ?instance ~scope ~name:"xgmii_rx_64" create i
;;
