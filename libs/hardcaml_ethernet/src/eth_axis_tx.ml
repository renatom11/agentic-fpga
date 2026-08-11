(** M07 [Eth_axis_tx] — Ethernet header record plus payload stream in, one
    frame stream out (SPEC-M07, FROZEN at 508eea2, plus its §13 row for C-17(b)).

    M07 is M06 run backwards, and the two modules are deliberately readable
    against each other: M06 removes fourteen octets from the front of a
    word-aligned stream, M07 puts fourteen back. 14 is not a multiple of 8 in
    either direction, so the realignment is the whole of the module here too.

    {2 The shape, in one paragraph}

    Two slots hold accepted payload words — [new_*] the most recently accepted,
    [old_*] the one before — and one register level holds the output. Every
    output word after the first is the concatenation

    {v
        tdata = { new[15:0], old[63:16] }
        tkeep = { new[1:0],  old[7:2]   }
    v}

    — positions 0 to 5 from the older word's positions 2 to 7, positions 6 and 7
    from the newer word's positions 0 and 1 — which is SPEC-M07 §6.1's "output
    word n carries payload octets 8n − 14 … 8n − 7, which lie in payload words
    n − 2 and n − 1" written once and used at every output word, the last
    included. {b The same two-position shift is applied to [tkeep] as to
    [tdata]}, so an octet's presence travels with the octet and this module
    contains no octet counter, no [popcount] and no length arithmetic: it never
    forms W, J or W − J at all. There is no barrel shifter and no shift amount
    either — 14 is a constant of the specification (§5), so the realignment is
    fixed wiring.

    {2 The header rides in the datapath registers, not beside them}

    The header is 8 octets plus 6, so it fills output word 0 and six positions
    of output word 1. Output word 0 is a mux at the output register's input,
    taken live from the record on the acceptance cycle (ADR-0008 holds the four
    fields stable until then), and the remaining six octets are written into the
    [old] slot as a {e pseudo payload word} whose positions 2 to 7 are header
    octets 8 to 13 and whose [tkeep] share is all ones. Output word 1 then falls
    out of the assembly expression above with no case of its own: the header's
    tail is just what the older slot happens to hold on that one cycle.

    So the header is held in {b zero} registers of its own (§6.3 item 1 leaves
    that free) — it is captured on the acceptance cycle directly into the two
    places it will be emitted from, which is why it cannot drift from the frame
    it belongs to.

    {2 The drain, which is also not a case}

    M07 emits W − J more words than it consumes, so after the payload's [tlast]
    word is accepted one or two output words remain. The [new] slot is then fed
    a synthetic tail — [tkeep] = 0, [tlast] = 1, [tuser] carried forward — and
    the same expression produces the remaining words: the one whose [tkeep] is
    { L[1:0], 0xFF[7:2] } and, where L reaches position 2, the one whose [tkeep]
    is { 0, L[7:2] }. The frame's last output word is therefore the first one
    for which the newer slot is the payload's last word {e and} has no octet at
    or above position 2 —

    {v
        tlast = new_last & (new_keep[7:2] = 0)
    v}

    — one bit, no counter, and the {b two or three} cycles of [payload_tready] =
    0 that §6.1 and §7 pin as W − J + 1 (carry-forward C-17(b)) are a consequence
    of that wiring rather than a number this module computes. Worked at §6.1's
    46-octet frame: J = 6, W = 8, the last payload word is accepted at C + 5 and
    the three cycles C + 6, C + 7, C + 8 accept nothing, the last of them
    presenting frame octets 56–59 with [tkeep] = 0x0F.

    {2 Stalling: one enable, both directions}

    [tx_tready] gates the whole module. §6.1 says [payload_tready] is 1 only
    when [tx_tready] is 1 and §6.2 says a cycle with [tx_tready] = 0 holds every
    state and every register, so there is one enable and not two, and an
    accepted payload word is always transmitted (REQ-207) because it is only
    ever accepted on a cycle whose output word is leaving. A payload source that
    withholds a word mid-frame (REQ-016) produces a bubble — [tx_tvalid] = 0 for
    that cycle — and holds every register; nothing is dropped and nothing is
    duplicated.

    {b The one place §6.2's closing sentence cannot be read literally} is the
    drain: it says a cycle on which "the source presents no payload word" holds
    every state and every register, while §6.1's own cycle table shows output
    words 5, 6 and 7 leaving at C+6, C+7 and C+8 with the payload input column
    empty. The drain needs no payload word, and a design that waited for one
    would leave a frame it had begun without a [tlast] — which §9's frame
    conservation and §6.2's own [Drain] row forbid. This module follows the
    table: the sentence is read as scoped to the states that require a word.

    {2 What this module deliberately does not do}

    It detects nothing and raises no strobe (§9): a missing word is M04's
    [error_underflow], a declared-length mismatch is M18's, an unresolvable
    destination is M13's. It never acts on [tuser] bit 0 — the payload [tlast]
    word's bit is copied to the frame's [tlast] word and nothing else happens
    (REQ-013, REQ-007) — and it originates no abort of its own. It reads no
    configuration (§4.3), so REQ-803 has no instance here. It knows no frame
    length and cannot: it terminates on the payload's [tlast], exactly as M04
    does. It pads nothing and computes no FCS (M04's, REQ-203 and REQ-202), and
    it cannot interleave two sources because it has one input port (REQ-406).
    And it instantiates nothing (§1), which is why [create] takes its scope and
    does not use it.

    {2 The constant, and the finding this module was written against}

    §7 pins {b 1 cycle}: output word 0 leaves on the cycle after M07 accepts the
    frame's first payload word. This implementation is exactly that, and every
    cycle of §6.1's table above is reproduced.

    {b What §7 calls that figure is a live spec defect and is raised, not
    absorbed} (charter §7; the C-RL-7 precedent). §7's bullet is titled
    "Latency" and converts the figure to "exactly 8 octet times" on the ground
    that both measurement events "sit at octet position 0 of their words". Under
    requirements.md §0.5 as amended on 2026-08-11 (the inserting-module clause,
    in force from its countersignature row at 816e187) that ground is precisely
    what makes the figure {e not} a latency: output word 0 carries no octet that
    entered at any input, so the delay pinned to it is an {b event delay}, and
    "a specification pinning both SHALL name which is which". M07's per-octet
    latency, by §0.5's own definition, is {b 22} octet times — payload octet k
    enters at octet time 8C + k and leaves at 8C + k + 22, at every k and every
    frame length — while §0.5's identity L = 8·ΔC − h returns 16 for it, because
    that identity assumes an insertion which leaves the frame word-aligned and
    M07 inserts 14. Three figures, one of them printed.

    Nothing in the design turns on the repair: it is a naming and derivation
    question and no cycle any section of SPEC-M07 pins moves under it, which is
    why this module is built to §6.1's table and the question is routed. *)

open! Base
open Hardcaml

(* ADR-0010: the house consumer convention. This module's ports use [Axi64] and
   [Eth_header] and no other record module, so this is the only record open
   here (ADR-0010 consequence 2). The inner [Axi64] shadows the outer
   compilation unit, so [Axi64.Source.t] below reads as SPEC-M07 §4.1 writes
   it. *)
open! Axi64

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; tx_dest : 'a Axi64.Dest.t [@rtlprefix "tx_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { payload_dest : 'a Axi64.Dest.t [@rtlprefix "payload_"]
    ; tx : 'a Axi64.Source.t [@rtlprefix "tx_"]
    }
  [@@deriving hardcaml]
end

(* REQ-405: the Ethernet II header is 14 octets — six destination address, six
   source address, two ethertype — and §5 makes that a constant of the
   specification rather than a parameter.

   14 enters this module as one number in one unit: 14 = 8 + 6, so the header
   occupies output word 0 whole and six of output word 1's eight positions, and
   [carry_octets] = 8 − 6 = 2 is what is left for payload octets there. Two
   readings of that one constant, both used below:

   - as a {e data} position, it splits every output word into the low
     [8 * carry_octets] bits taken from the older payload word's top and the
     rest taken from the newer payload word's bottom;
   - as a {e tkeep} position, [tkeep] bit [carry_octets - 1] and above of the
     newer slot is "this word still has octets that the current output word
     cannot carry", so the end of the frame is a single-bit test and no octet
     count is ever formed.

   A different header length would change this line and no other logic, which is
   what makes the same structure reusable at M15 (20 octets) and M18 (8). *)
let carry_octets = 2

(* ---- states (§6.2) ----
   Two states, against §6.2's four rows, and the mapping is exact rather than
   approximate: §6.2 names a state by the output word it {e emits}, while a
   registered datapath names it by the word it {e loads}, so §6.2's `Header` is
   the first cycle of [Sending] (it loads output word 1 while output word 0 is
   on the port) and §6.2's `Drain` is the last one or two, distinguished by the
   [tkeep] bits of the newer slot rather than by an encoding. Every transition
   and every pinned cycle of §6.1, §6.2 and §7 is the same under either
   reading; §6.3 item 1 leaves the FSM encoding and the register placement
   unconstrained, and this note exists so the two tables can be read against
   each other without deriving the offset. *)
module State = struct
  type t =
    | Idle
    | Sending
  [@@deriving compare, enumerate, sexp_of]
end

let create (_scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
  let open Signal in
  let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in
  let sm = Always.State_machine.create (module State) spec in
  let in_idle = sm.is State.Idle in
  let in_sending = sm.is State.Sending in
  (* §7's reset clause: while [clear] = 1 and on the first cycle after it
     returns to 0, [tx_tvalid] = 0 and [payload_tready] = 0. The registers
     below clear synchronously, so on that first cycle [tx_tvalid] already
     reads 0; the window is muxed at the port anyway rather than argued away,
     because the argument depends on the clear reaching every one of them and
     the mux does not. A frame offered on that first cycle is not lost — the
     source holds the offer (ADR-0008) and M07 accepts it on the next. *)
  let clear_d = reg spec vdd in
  let reset_window = i.clear |: ~:clear_d in
  (* One enable for the whole module (§6.1, §6.2): a cycle on which the
     consumer cannot accept is a cycle on which nothing moves anywhere. This is
     also what makes REQ-207 structural — a payload word is only ever accepted
     on a cycle whose output word is leaving, so an accepted word is always
     transmitted. *)
  let en = i.tx_dest.tready &: ~:reset_window in
  (* Three registers feed the control and are therefore declared first. *)
  let out_valid = wire 1 in
  let out_last = wire 1 in
  let new_last = wire 1 in
  (* [finishing]: the word on the port {e is} the frame's last, so there is
     nothing further to load and nothing further to accept. §6.1's table pins
     [payload_tready] = 0 on this cycle (C+8 of the 46-octet frame) and the
     return to `Idle` on its acceptance, which is one cycle later than the load
     that produced it — hence a state test and not [assembled_last]. *)
  let finishing = in_sending &: out_valid &: out_last in
  (* §6.2's `Idle` row: [payload_tready] = 1 when [hdr_valid] = 1 and
     [tx_tready] = 1, and 0 otherwise — deliberately not a function of
     [payload_tvalid], so ready may lead valid. In `Sending` a word is wanted
     until the payload's [tlast] word is in the newer slot, which is §6.2's
     `Body` row and its `Drain` row's [payload_tready] = 0 in one term. *)
  let want_word =
    (in_idle &: i.hdr.valid) |: (in_sending &: ~:finishing &: ~:new_last)
  in
  let payload_tready = en &: want_word in
  let accept = payload_tready &: i.payload.tvalid in
  (* [advance] is "load an output word this cycle". In `Idle` that is the offer
     itself (ADR-0008: header and first payload word together). In `Sending` it
     is every enabled cycle except the finishing one, and except a cycle on
     which a word is wanted and the source presents none — REQ-016's gap, which
     produces a bubble and holds every register. A drain cycle wants no word
     and advances on the enable alone. *)
  let advance =
    (in_idle &: accept)
    |: (in_sending &: ~:finishing &: en &: (~:want_word |: i.payload.tvalid))
  in
  (* ---- the header, as octets on the wire (REQ-012, REQ-409) ----
     Frame octet 0 is the most significant octet of [dst_mac], so the fourteen
     wire octets are the concatenated fields split most significant first — the
     numeric encode REQ-012 asks for, done by the concatenation order and not by
     a reversal network. [concat_lsb] then places octet k at position k, which
     is REQ-021 at this module's output: frame octet 0 lands in
     [tx_tdata]\[7:0\]. Ethertype 0x0800 emits 0x08 at frame octet 12 and 0x00
     at 13, which is the case §6.1 says is most often got wrong. *)
  let hdr_octets =
    split_msb ~part_width:8 (i.hdr.dst_mac @: i.hdr.src_mac @: i.hdr.ethertype)
  in
  let head_octets, tail_octets = List.split_n hdr_octets 8 in
  let header_word = concat_lsb head_octets in
  (* The pseudo payload word seeded into the older slot: header octets 8 to 13
     sit at positions 2 to 7, which is where the assembly expression reads
     them, and its low [carry_octets] positions are never read. *)
  let header_seed = concat_lsb tail_octets @: zero (8 * carry_octets) in
  (* ---- the two payload slots ----
     [new_*] is the most recently accepted payload word and [old_*] the one
     before; together with the output register that is three words of storage,
     which is what a 14-octet insertion needs and no more. [new_data] and
     [new_user] advance on acceptance alone: through the drain they keep the
     payload's last word, whose octets the older slot is by then serving and
     whose abort bit the frame's last word still owes. [new_keep] and
     [new_last] advance on every load, because the drain's synthetic tail is
     exactly "no octets, and this is the end". *)
  let new_data = reg spec ~enable:accept i.payload.tdata in
  let new_user = reg spec ~enable:accept i.payload.tuser in
  let new_keep = reg spec ~enable:advance (mux2 accept i.payload.tkeep (zero 8)) in
  new_last <== reg spec ~enable:advance (mux2 accept i.payload.tlast vdd);
  let old_data = reg spec ~enable:advance (mux2 in_idle header_seed new_data) in
  let old_keep = reg spec ~enable:advance (mux2 in_idle (ones 8) new_keep) in
  (* The assembly, identical for every output word except the first — the
     header's own word — and identical at the drain, where the newer slot
     contributes no octets. Its share of [tkeep] is zero there by construction,
     so its share of [tdata] is left alone: §6.3 item 4 leaves [tx_tdata]
     unconstrained wherever [tx_tkeep] is 0, and masking sixteen bits to
     satisfy nobody would be logic with no reader. *)
  let assembled_data =
    concat_msb
      [ select new_data ((8 * carry_octets) - 1) 0
      ; select old_data 63 (8 * carry_octets)
      ]
  in
  let assembled_keep =
    concat_msb
      [ select new_keep (carry_octets - 1) 0; select old_keep 7 carry_octets ]
  in
  (* The frame ends on the first output word whose newer slot is the payload's
     last word and has nothing left above position [carry_octets - 1]. At a
     payload of P octets that is the word loaded on the cycle after the payload
     [tlast] is accepted when P mod 8 is 1 or 2, and one cycle later otherwise —
     W − J + 1 stalled cycles either way, which is §6.1's two or three and
     never one (C-17(b)). REQ-007, REQ-013: the abort bit rides the same
     decision, so it appears on the frame's [tlast] word and on no other. *)
  let assembled_last = new_last &: (select new_keep 7 carry_octets ==:. 0) in
  let assembled_user = assembled_last &: new_user in
  (* ---- the output register (§7's one-cycle constant) ----
     [tx_tvalid] and the word's contents are held stable until acceptance,
     which is what SPEC-M04 §7 relies on. [tx_tlast] and [tx_tuser] are held
     with the word rather than driven to 0 between words: they belong to the
     word they were loaded with, and §6.3 item 4 leaves every output field
     unconstrained on a cycle with [tx_tvalid] = 0. *)
  out_valid <== reg spec (mux2 en advance out_valid);
  out_last <== reg spec ~enable:advance (mux2 in_idle gnd assembled_last);
  let out_data = reg spec ~enable:advance (mux2 in_idle header_word assembled_data) in
  let out_keep = reg spec ~enable:advance (mux2 in_idle (ones 8) assembled_keep) in
  let out_user = reg spec ~enable:advance (mux2 in_idle gnd assembled_user) in
  (* The machine opens on the offer and closes on the acceptance of the frame's
     last output word, not on its load — §6.2's `Drain` row, and the reason
     [payload_tready] is 0 on the cycle that word is presented. *)
  Always.(
    compile
      [ sm.switch
          [ State.Idle, [ when_ accept [ sm.set_next State.Sending ] ]
          ; State.Sending, [ when_ (finishing &: en) [ sm.set_next State.Idle ] ]
          ]
      ]);
  { O.payload_dest = { Axi64.Dest.tready = payload_tready }
  ; tx =
      { Axi64.Source.tvalid = out_valid &: ~:reset_window
      ; tdata = out_data
      ; tkeep = out_keep
      ; tstrb = zero 8 (* REQ-014 *)
      ; tlast = out_last
      ; tuser = out_user
      }
  }
;;

let hierarchical ?instance scope (i : Signal.t I.t) : Signal.t O.t =
  let module H = Hierarchy.In_scope (I) (O) in
  H.hierarchical ?instance ~scope ~name:"eth_axis_tx" create i
;;
