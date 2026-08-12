(** M04 [Xgmii_tx_64] — frame stream in, XGMII lanes out (SPEC-M04, FROZEN at
    f78766e, plus its §13 rows through C-16 and C-31).

    {2 The shape}

    One XGMII word is emitted on every cycle, always. The word emitted on cycle
    n is composed on cycle n − 1 from a two-entry holding structure and a
    position counter, and a source word accepted on cycle a is composed on
    a + 1 and reaches the wire on a + 2 — §6.1's "exactly two words are in
    flight", and the reason M04's depth is two rather than one is the preamble
    word, which is an output slot consuming no source word.

    {2 The composition, which is the whole module}

    Every octet of a transmitted frame has a position [p] counted from the
    first destination-address octet, and the frame is one ordered sequence:

    - [p < payload_end] — a source octet;
    - [payload_end <= p < pad_end] — a zero pad octet (REQ-203), where
      [pad_end = max (payload_end, 60)];
    - [pad_end <= p < pad_end + 4] — an FCS octet, least significant first
      (REQ-202), which is the wire order that makes REQ-304's residue constant
      and is therefore the same decision M03 checks against;
    - [p = pad_end + 4] — the terminate character (REQ-205);
    - beyond — idle.

    Each cycle composes eight consecutive positions, so the lane selectors are
    comparisons of the lane index against those four boundaries taken relative
    to the current position. Every straddle falls out of that: a word carrying
    payload, pad, FCS and the terminate character at once needs no special
    case, and neither does an FCS split across two words.

    {2 What this module never does}

    It never builds a header, never knows a declared length, and never drops or
    alters a frame because [tuser] bit 0 is set (REQ-013). It has no elastic
    buffer: a word required and not presented is an underflow on that cycle
    (REQ-206, REQ-016), not a gap. *)

open! Base
open Hardcaml

(* ADR-0010: the house consumer convention. This module's ports use [Axi64]
   and [Xgmii] and no other record module. *)
open! Axi64

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; tx : 'a Axi64.Source.t [@rtlprefix "tx_"]
    ; cfg_ifg : 'a [@bits 8]
    ; cfg_tx_enable : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { tx_dest : 'a Axi64.Dest.t [@rtlprefix "tx_"]
    ; xgmii_tx : 'a Xgmii.t [@rtlprefix "xgmii_tx"]
    ; error_underflow : 'a
    }
  [@@deriving hardcaml]
end

(* XGMII control characters (requirements.md §2). §6.3 item 2 makes the value
   of a lane carrying a control character unconstrained *except* for the
   character itself, which is what [xgmii_txc] marks; these four are
   normative. *)
let idle_char = 0x07
let start_char = 0xfb
let terminate_char = 0xfd
let error_char = 0xfe

(* REQ-201: the preamble is six 0x55 octets and one 0xD5 SFD octet after the
   start character, and Phase 1 places the start character in lane 0 only —
   which is why the preamble is exactly one word and why M04 never realigns a
   source word (REQ-021). *)
let preamble_filler = 0x55
let sfd_char = 0xd5

(* REQ-203's pad target, in destination-address-through-payload octets. With
   the four FCS octets this is the 64-octet minimum frame of §0.3. *)
let pad_target = 60

(* Position arithmetic width. A position runs from 0 to a maximum frame's
   1514 payload octets plus pad, FCS and terminate, and is compared as a
   *signed* value against lane indices — a boundary already passed is a
   negative relative offset, which is how an FCS split across two words is
   expressed without a second counter. 13 bits signed covers ±4095. *)
let position_bits = 13

(* ---- phases (§6.2) ----
   §6.2 names seven states; three registers carry them here, and §6.3 item 1
   leaves the encoding and the internal division unconstrained. The mapping,
   stated so the two can be read against each other:

   - [Idle] is §6.2's `Idle`, and it is also §6.2's `Preamble`: the cycle that
     composes the preamble word is the cycle a first source word becomes
     available, because REQ-210 pins one cycle from that acceptance to the
     start character and a separate preamble state would cost a second;
   - [Body] is §6.2's `Frame`, `Pad` and `Fcs` together — they are three
     regions of the one position sequence above, not three behaviours;
   - [Abort] is §6.2's `Abort` (REQ-206);
   - [Gap] is §6.2's `Gap`. *)
module Phase = struct
  type t =
    | Idle
    | Body
    | Abort
    | Gap
  [@@deriving compare, enumerate, sexp_of]
end

(* One composed XGMII word: the eight lane octets and their control bits. *)
let word_of_lanes lanes =
  let open Signal in
  { Xgmii.d = concat_lsb (List.map lanes ~f:fst)
  ; c = concat_lsb (List.map lanes ~f:snd)
  }
;;

let idle_word =
  let open Signal in
  word_of_lanes (List.init 8 ~f:(fun _ -> of_int ~width:8 idle_char, vdd))
;;

let preamble_word =
  let open Signal in
  word_of_lanes
    (List.init 8 ~f:(fun k ->
       if k = 0
       then of_int ~width:8 start_char, vdd
       else if k = 7
       then of_int ~width:8 sfd_char, gnd
       else of_int ~width:8 preamble_filler, gnd))
;;

(* REQ-206's remedy: one word carrying [/E/] in lane 0 and [/T/] in lane 1,
   idle in lanes 2–7, and no FCS. §9 states why the alternative is worse — a
   valid FCS on a truncated frame would put a well-formed short frame on the
   wire, which the link partner would accept as real. *)
let abort_word =
  let open Signal in
  word_of_lanes
    (List.init 8 ~f:(fun k ->
       if k = 0
       then of_int ~width:8 error_char, vdd
       else if k = 1
       then of_int ~width:8 terminate_char, vdd
       else of_int ~width:8 idle_char, vdd))
;;

let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
  let open Signal in
  let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in
  let sm = Always.State_machine.create (module Phase) spec in
  let in_idle = sm.is Phase.Idle in
  let in_body = sm.is Phase.Body in
  let in_gap = sm.is Phase.Gap in
  (* §7's reset clause, which wins over §6.2's `Idle` row (C-14.2): while
     [clear] = 1 and on the first cycle after it returns to 0, [tx_tready] is
     0 whatever [cfg_tx_enable] says. A frame presented on that first cycle is
     not lost — the source holds [tvalid] and the word stable until
     acceptance, and M04 accepts it on the following cycle. *)
  let clear_d = reg spec vdd in
  let reset_window = i.clear |: ~:clear_d in
  (* ---- the two-word holding structure (§6.1, §7 case 4) ----
     Not an elastic buffer: it is the pipeline REQ-207 needs, holding at most
     the two accepted-and-untransmitted words §7 case 4 bounds. A word is
     pushed when it is accepted and popped when the composer consumes it. *)
  let accept = wire 1 in
  let consume = wire 1 in
  let fill = wire 2 in
  let full = fill ==:. 2 in
  let empty = fill ==:. 0 in
  (* Entry A is the older and is what the composer reads; on a pop, B slides
     into A. One [hold] per field, all driven by the same three controls, so
     the fields cannot drift apart on a corner. *)
  let hold width value =
    let a = wire width in
    let b = wire width in
    let a_next =
      mux2
        consume
        (mux2 full b (mux2 accept value a))
        (mux2 (empty &: accept) value a)
    in
    let b_next =
      mux2 consume (mux2 (full &: accept) value b) (mux2 ((fill ==:. 1) &: accept) value b)
    in
    a <== reg spec a_next;
    b <== reg spec b_next;
    a
  in
  let held_data = hold 64 i.tx.tdata in
  let held_keep = hold 8 i.tx.tkeep in
  let held_last = hold 1 i.tx.tlast in
  fill <== reg spec (fill +: uresize accept 2 -: uresize consume 2);
  (* ---- the position sequence (§6.1) ----
     [pos] is the frame position of lane 0 of the word being composed. The four
     boundaries are taken relative to it as *signed* offsets, so a boundary
     already passed is negative and an FCS split across two words needs no
     second counter. *)
  let pos = wire position_bits in
  let payload_end = wire position_bits in
  let have_end = wire 1 in
  let start_now = wire 1 in
  let unknown_end = of_int ~width:position_bits 4000 in
  let held_count = uresize (popcount held_keep) position_bits in
  let end_now = in_body &: consume &: held_last in
  let payload_end_eff =
    mux2 end_now (pos +: held_count) (mux2 have_end payload_end unknown_end)
  in
  let pad_target_s = of_int ~width:position_bits pad_target in
  let pad_end = mux2 (payload_end_eff >=+ pad_target_s) payload_end_eff pad_target_s in
  let d_payload = payload_end_eff -: pos in
  let d_pad = pad_end -: pos in
  let d_term = d_pad +:. 4 in
  let clamp_to_lanes d =
    mux2 (d <=+. 0) (zero 4) (mux2 (d >=+. 8) (of_int ~width:4 8) (uresize d 4))
  in
  let payload_lanes = clamp_to_lanes d_payload in
  let crc_count = clamp_to_lanes d_pad in
  payload_end <== reg spec ~enable:end_now (pos +: held_count);
  have_end <== reg spec (mux2 start_now gnd (have_end |: end_now));
  (* ---- the running CRC (REQ-202, ADR-0006, ADR-0007) ----
     Seeded to 0x00000000 on the preamble cycle; updated on every cycle
     covering at least one frame or pad octet, with [octet_count] set to how
     many — 1 to 8, never 0 — and held by its enable on every other cycle, so
     no update-by-zero is driven. Coverage is the destination address through
     the last payload *or pad* octet, which is what [crc_count] counts. *)
  let crc_reg = wire 32 in
  let lane_mask_64 m =
    concat_lsb (List.map (bits_lsb m) ~f:(fun b -> repeat b 8))
  in
  let lane_masks_lt =
    [ 0x00; 0x01; 0x03; 0x07; 0x0f; 0x1f; 0x3f; 0x7f; 0xff ]
    |> List.map ~f:(of_int ~width:8)
  in
  let mask_lt k = mux k (lane_masks_lt @ List.init 7 ~f:(fun _ -> ones 8)) in
  let crc =
    Crc32_eth.hierarchical
      scope
      { Crc32_eth.I.crc_in = crc_reg
      ; data = held_data &: lane_mask_64 (mask_lt payload_lanes)
      ; octet_count = crc_count
      }
  in
  let crc_out = crc.Crc32_eth.O.crc_out in
  let crc_update = in_body &: (crc_count <>:. 0) in
  crc_reg <== reg spec (mux2 start_now (zero 32) (mux2 crc_update crc_out crc_reg));
  (* The FCS octets may share a word with the last pad octets and may be split
     across two words, so the value is taken from this cycle's update where
     there is one and from the held copy otherwise. *)
  let fcs_held = wire 32 in
  let fcs_value = mux2 crc_update crc_out fcs_held in
  fcs_held <== reg spec fcs_value;
  (* ---- the composed word (REQ-201 … REQ-205) ----
     Eight lanes, each a comparison of its index against the four boundaries.
     REQ-202's wire order is the [fcs_octets] list: least significant octet
     first, which is the ordering that makes REQ-304's residue constant and is
     therefore the same decision M03's check depends on. *)
  let fcs_octets =
    List.init 4 ~f:(fun k -> select fcs_value ((8 * k) + 7) (8 * k))
  in
  let body_word =
    word_of_lanes
      (List.init 8 ~f:(fun j ->
         let j_s = of_int ~width:position_bits j in
         let is_payload = j_s <+ d_payload in
         let is_pad = (j_s >=+ d_payload) &: (j_s <+ d_pad) in
         let is_fcs = (j_s >=+ d_pad) &: (j_s <+ d_term) in
         let is_term = j_s ==: (d_term +:. 1) in
         let fcs_octet = mux (uresize (j_s -: d_pad) 2) fcs_octets in
         let octet =
           mux2
             is_payload
             (select held_data ((8 * j) + 7) (8 * j))
             (mux2
                is_pad
                (zero 8)
                (mux2
                   is_fcs
                   fcs_octet
                   (mux2 is_term (of_int ~width:8 terminate_char) (of_int ~width:8 idle_char))))
         in
         octet, ~:(is_payload |: is_pad |: is_fcs)))
  in
  (* ---- the inter-frame gap (REQ-204) ----
     Counted from the terminate character inclusive and rounded up so the next
     start character lands in lane 0: with the terminate character in lane t,
     the next start character is g = ceil((cfg_ifg + t) / 8) words later. Gaps
     are only ever rounded up — deficit idle count is out of Phase-1 scope, so
     no gap is ever shortened. *)
  let gap_left = wire 6 in
  let gap_words terminate_lane =
    let sum = uresize i.cfg_ifg 10 +: uresize terminate_lane 10 +:. 7 in
    uresize (srl sum 3) 6
  in
  let term_here = in_body &: (d_term >=+. 0) &: (d_term <=+. 7) in
  let term_lane = uresize d_term 4 in
  (* [need_payload] is deliberately a function of *registered* state only.
     Deriving it from [payload_lanes] would close a combinational loop —
     [consume] decides [end_now], which moves [payload_end_eff], which moves
     [d_payload], which would decide [consume] — and the two formulations
     agree cycle for cycle: before the frame's last word no end is recorded, on
     the cycle that word is consumed the registered end is still absent, and
     from the next cycle the recorded end no longer lies ahead of [pos]. *)
  let need_payload = in_body &: (~:have_end |: (payload_end >: pos)) in
  let starved = need_payload &: empty in
  consume <== (need_payload &: ~:empty);
  (* A frame may begin on any cycle that is not inside a frame and not inside
     an unsatisfied gap: §6.2's `Idle`, and the last cycle of `Gap`, which §7
     pins at [tx_tready] = 1 because REQ-209's eleven-cycle cadence is
     unachievable otherwise. *)
  let gap_done = gap_left ==:. 0 in
  let can_start = in_idle |: (in_gap &: gap_done) in
  let word_available = ~:empty |: accept in
  start_now
  <== (can_start &: word_available &: i.cfg_tx_enable &: ~:reset_window &: ~:(i.clear));
  gap_left
  <== reg
        spec
        (mux2
           term_here
           (gap_words term_lane -:. 1)
           (mux2 starved (gap_words (of_int ~width:4 1) -:. 1)
              (mux2 gap_done gap_left (gap_left -:. 1))));
  pos <== reg spec (mux2 start_now (zero position_bits) (mux2 in_body (pos +:. 8) pos));
  (* ---- underflow (REQ-206, §9) ----
     Exactly §9's condition: [tx_tready] = 1 and [tx_tvalid] = 0, after the
     start character has been emitted and before the frame's `tlast` word has
     been accepted. [frame_active] opens the window on the cycle after the
     preamble is composed — the cycle the start character reaches the wire —
     and [last_accepted] closes it, which is what makes C+8 a legal offer with
     no obligation behind it (§7 case 1, C-16). *)
  let frame_active = wire 1 in
  let last_accepted = wire 1 in
  (* [~:starved] is what keeps `error_underflow` one cycle wide (REQ-008): on
     the cycle after the missing word was required, M04 has nothing to offer
     for a frame it is already terminating, so it offers nothing. *)
  let tready =
    ~:reset_window
    &: ~:full
    &: ~:starved
    &: ((can_start &: i.cfg_tx_enable) |: (in_body &: need_payload))
  in
  let underflow = tready &: ~:(i.tx.tvalid) &: frame_active &: ~:last_accepted in
  accept <== (tready &: i.tx.tvalid);
  (* [last_accepted] answers one question — has *this* frame's `tlast` word been
     accepted? — and the answer is not always accumulated from [start_now]
     onwards. Two ways a frame can be wholly accepted at or before the cycle it
     starts, both inside SPEC-M04's domain, and BUG-0004 is what clearing the
     register at [start_now] did to them:

     - the frame's first word *is* its `tlast` word (a one-source-word frame,
       W = 1, P ≤ 8 — §2's not-my-job table records that nothing here knows a
       length, and REQ-203's pad rule is written to reach any P below 60, so the
       specification places no lower bound to lean on). Its acceptance and
       [start_now] are the *same* cycle;
     - the first word was accepted *before* the frame started, on §7 case 2's
       early-acceptance cycle (C+8, carry-forward C-16), and §6.2's `Idle` row
       then starts the frame from the held word with no acceptance of its own.

     So the register is **seeded from what is already held** at [start_now]
     rather than cleared to 0, and this cycle's own acceptance is OR-ed in
     **after** the seed rather than nested under it. Clearing first and setting
     second is the whole repair: the previous form let [start_now] discard the
     acceptance that closes the window on the one frame shape where the two
     coincide. REQ-206's window is *empty* there — it opens at the start
     character (C+1, §6.2's `Preamble`) and closes at the `tlast` acceptance (C),
     so no cycle of a W = 1 frame can satisfy it, whatever [tready] does.

     Nothing here widens the suppression: the seed is a word this module
     accepted, and a frame with a word still to come reaches the accumulate term
     exactly as before — a word required and not presented at C+1 of a W ≥ 2
     frame still pulses. [held_last] is only meaningful while a word is held (the
     hold registers keep their value on a pop), hence the [~:empty] guard. *)
  let start_word_is_last = ~:empty &: held_last in
  last_accepted
  <== reg
        spec
        (mux2 start_now start_word_is_last last_accepted |: (accept &: i.tx.tlast));
  frame_active
  <== reg spec (mux2 start_now vdd (mux2 (term_here |: starved) gnd frame_active));
  Always.(
    compile
      [ sm.switch
          [ Phase.Idle, [ when_ start_now [ sm.set_next Phase.Body ] ]
          ; ( Phase.Body
            , [ if_
                  starved
                  [ sm.set_next Phase.Abort ]
                  [ when_ term_here [ sm.set_next Phase.Gap ] ]
              ] )
          ; Phase.Abort, [ sm.set_next Phase.Gap ]
          ; Phase.Gap, [ when_ start_now [ sm.set_next Phase.Body ] ]
          ]
      ]);
  (* [Abort] composes nothing further: the abort word is composed on the
     starved cycle itself, so the phase exists to hold the machine for the one
     cycle before the gap is served. That keeps §9's "the wire consequence
     follows two cycles later" exact — the strobe pulses on the cycle the word
     was required, the abort word is composed on the next cycle and reaches the
     wire on the one after. *)
  let composed =
    mux2 start_now preamble_word.Xgmii.d
      (mux2 starved abort_word.Xgmii.d (mux2 in_body body_word.Xgmii.d idle_word.Xgmii.d))
  in
  let composed_c =
    mux2 start_now preamble_word.Xgmii.c
      (mux2 starved abort_word.Xgmii.c (mux2 in_body body_word.Xgmii.c idle_word.Xgmii.c))
  in
  (* While [clear] is asserted and on the first cycle after it returns to 0 the
     lanes carry idle (§7's reset clause). The output registers clear to zero,
     which is not an idle character, so the reset window is muxed at the port
     rather than pretended away. *)
  let xgmii_tx =
    { Xgmii.d = mux2 reset_window idle_word.Xgmii.d (reg spec composed)
    ; c = mux2 reset_window idle_word.Xgmii.c (reg spec composed_c)
    }
  in
  { O.tx_dest = { Axi64.Dest.tready = tready }
  ; xgmii_tx
  ; error_underflow = underflow &: ~:(i.clear)
  }
;;

let hierarchical ?instance scope (i : Signal.t I.t) : Signal.t O.t =
  let module H = Hierarchy.In_scope (I) (O) in
  H.hierarchical ?instance ~scope ~name:"xgmii_tx_64" create i
;;
