(** M06 [Eth_axis_rx] — frame stream in, Ethernet header record plus payload
    stream out (SPEC-M06, FROZEN at 508eea2, plus its §13 rows through C-17).

    This is the first of REQ-021's three realignment sites (M06 strips 14, M14
    strips 20, M17 strips 8), and the realignment is the whole of the module:
    the header is 14 octets, 14 is not a multiple of 8, so the payload's first
    octet lies at position 6 of input word 1 and has to leave at position 0 of
    payload word 0.

    {2 The shape, in one paragraph}

    One register holds the previous input word; one register level holds the
    output. Payload word m is the concatenation

    {v
        tdata = { current[47:0], previous[63:48] }
        tkeep = {  current[5:0],  previous[7:6]  }
    v}

    — positions 0 and 1 from the previous input word's positions 6 and 7,
    positions 2 to 7 from the current input word's positions 0 to 5 — which is
    SPEC-M06 §6.1's assembly rule written once and used at every payload word,
    including the last. {b The same two-position shift is applied to [tkeep] as
    to [tdata]}, which is why this module contains no octet counter and no
    length arithmetic: an octet's presence travels with the octet. There is no
    barrel shifter and no shift amount either — the strip length is a constant
    of the specification (§5), so the realignment is fixed wiring.

    Payload word m is assembled from input words m + 1 and m + 2, so it is
    loaded on the cycle input word m + 2 arrives and leaves on the next —
    ΔC = 3 (§7), which is M06's §1.1 ceiling exactly, with **no reserve**. Two
    words of payload storage (the holding register and the output register),
    which is REQ-019's permitted depth and no more.

    {2 The one asymmetry: the drain word}

    Payload word m needs input word m + 2, and for an input frame of N octets
    with N ≡ 0 or 7 (mod 8) the last payload word's "word m + 2" never arrives:
    its only octets are positions 6 and 7 of the frame's [tlast] word. That
    word is therefore assembled on the cycle {e after} the input [tlast], from
    the holding register alone, and leaves one cycle after that. §6.1 fixes
    this as arithmetic rather than as an option — payload word m leaves at
    Ci + 3 + m at every frame length, so a design that emitted the final one
    early "because it happened to have all the octets" would have
    length-dependent latency and fail REQ-005.

    The condition is one bit and needs no length counter: a drain word exists
    iff the input [tlast] word carries an octet at position 6, and its [tkeep]
    is that word's [tkeep] bits 7 and 6 moved down — the same shift again.
    Everything else about a frame's end is decided on the [tlast] word itself.

    {2 Output events and their deciding input words (§0.5)}

    M06's front offset h = 14 is not a multiple of 8, so M06 {b straddles}:
    every payload word is assembled from two input words and, by §0.5's
    "Straddle" test, its per-octet constant does {e not} survive REQ-016's idle
    injection. What survives is the per-output-event delay from that event's
    deciding input word D, and this implementation's are constant by
    construction:

    - payload word m, where the frame's [tlast] word carries no octet at
      position 6: D = input word m + 2, the word carrying the
      [tkeep]/[tlast]/[tuser] evidence that fixes it — delay {b 1} cycle;
    - the drain word: D = the input [tlast] word — delay {b 2} cycles;
    - [hdr_valid]: D = input word 1, which carries both the last header octet
      and the evidence that the frame is not short — delay {b 1} cycle;
    - [error_short_frame]: D = the input [tlast] word — delay {b 1} cycle.

    Each is a delay from a {e registered} decision taken on D itself, so none
    of them moves when idle cycles are injected anywhere.

    On a gapless stimulus this is exactly §6.1's cycle table and §7's pinned
    L = 10 octet times. {b SPEC-M06 §7's sentence "idle gaps on the input delay
    everything by exactly 8 octet times per cycle" and §10's REQ-016 hook
    ("asserting the per-octet constant") are the retired reading}, named as
    owing repair in requirements.md §13's 2026-08-04 row alongside SPEC-M10 and
    SPEC-M14. This module is built to §0.5 as amended, which governs; the
    repair is architect_docs_lead's and no cycle of §6.1 or §7 moves under it.

    {2 What this module deliberately does not do}

    It filters no address — [dst_mac] is captured and compared against nothing
    (REQ-407). It never looks at the ethertype's value (REQ-404 is M08's). It
    forwards Ethernet padding untouched (REQ-408); stripping it is M14's job,
    because M14 is the layer that knows the datagram's real length. It reads no
    configuration at all (§4.3), so REQ-803 has no instance here. It originates
    no abort: [tuser] bit 0 arrives on the input [tlast] word and is copied to
    the payload [tlast] word, never set and never cleared (REQ-403, REQ-007).
    It contains no defensive decode of an input that violates REQ-011 or
    REQ-015 — a partial non-final word, a [tkeep] of 0, a [tlast] with no
    preceding word — because its producer is M03, which cannot emit one, and
    §6.3 item 3 leaves the response unconstrained rather than commissioning a
    test for a stimulus the programme has decided not to produce. And it
    instantiates nothing (§1), which is why [create] takes its scope and does
    not use it. *)

open! Base
open Hardcaml

(* ADR-0010: the house consumer convention. This module's ports use [Axi64]
   and [Eth_header] and no other record module, so this is the only record
   open here (ADR-0010 consequence 2). The inner [Axi64] shadows the outer
   compilation unit, so [Axi64.Source.t] below reads as SPEC-M06 §4.1 writes
   it. *)
open! Axi64

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; rx : 'a Axi64.Source.t [@rtlprefix "rx_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { hdr : 'a Eth_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; error_short_frame : 'a
    }
  [@@deriving hardcaml]
end

(* REQ-401, REQ-408: the Ethernet II header is 14 octets — six destination
   address, six source address, two ethertype — and §5 makes that a constant of
   the specification rather than a parameter, because a test that overrode it
   would be configuring a frame format this programme does not have.

   14 enters this module as one number in one unit: the position, within input
   word 1, of the frame's first payload octet. Every other consequence of the
   header length below is a selector taken against this one constant, so a
   different strip length would change this line and no other logic — which is
   what makes the same structure reusable at M14 and M17.

   Two readings of the same constant, both used below:

   - as a {e data} position, it splits every input word into the [8 * offset]
     low bits that belong to the current payload word and the rest that belong
     to the next one;
   - as a {e tkeep} position, [tkeep] bit [offset - 1] is frame octet 13 at
     input word 1 — so "this word completes the header" and "this word has six
     or more octets" are the same single-bit test, and no octet count is ever
     formed. *)
let payload_offset = 6

(* ---- states (§6.2) ----
   The state names the role of the {e next} input word to arrive, which is what
   makes REQ-410 fall out: the machine returns to [Idle] on the input [tlast]
   cycle and may open a new frame on the very next cycle while the previous
   frame's last payload word is still in the output register.

   Against §6.2's table, whose rows name the word a state consumes: word 0 is
   consumed on a cycle whose registered state is still [Idle], word 1 on a
   cycle in [Header], and words 2 onward on cycles in [Payload]. Every
   transition and every pinned cycle of §6.2 and §7 is the same under either
   reading; §6.3 item 1 leaves the encoding and the register placement
   unconstrained, and this note exists so the two tables can be read against
   each other without deriving the offset. *)
module State = struct
  type t =
    | Idle
    | Header
    | Payload
  [@@deriving compare, enumerate, sexp_of]
end

let create (_scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
  let open Signal in
  let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in
  let sm = Always.State_machine.create (module State) spec in
  let in_idle = sm.is State.Idle in
  let in_header = sm.is State.Header in
  let in_payload = sm.is State.Payload in
  (* §7's reset clause: while [clear] = 1 and on the first cycle after it
     returns to 0, the three reported outputs are 0. The registers below clear
     synchronously, so on that first cycle they already read 0; the window is
     muxed at the port anyway rather than argued away, because the argument
     depends on the clear reaching every one of them and the mux does not.
     Nothing on the {e input} side is gated by it — §7 requires that a frame
     whose first word arrives on that first cycle is received correctly. *)
  let clear_d = reg spec vdd in
  let reset_window = i.clear |: ~:clear_d in
  let word = i.rx.tvalid in
  let ends_here = word &: i.rx.tlast in
  (* [tkeep] is contiguous from bit 0 (REQ-011), so a single bit of it answers
     every question this module asks of a word's length.

     - bit [payload_offset - 1] — the word carries frame octet 13 when it is
       word 1: the header is complete, and equivalently the frame has at least
       fourteen octets;
     - bit [payload_offset] — the word carries an octet that belongs to a
       payload word whose other source word will never arrive: the drain
       condition. *)
  let reaches_header_end = bit i.rx.tkeep (payload_offset - 1) in
  let reaches_payload_offset = bit i.rx.tkeep payload_offset in
  (* ---- the one holding register (REQ-019) ----
     The previous input word — data, [tkeep] and [tuser] — advanced only on a
     word, so an idle cycle inside a frame holds it, which is REQ-016's
     "advances nothing". It serves both purposes this module has for history:
     the two realignment octets and the first eight header octets. Payload
     storage is therefore this register plus the output register, REQ-019's
     permitted depth of two and no more. *)
  let previous = reg spec ~enable:word i.rx.tdata in
  let previous_keep = reg spec ~enable:word i.rx.tkeep in
  let previous_tuser = reg spec ~enable:word i.rx.tuser in
  let octet_of source k = select source ((8 * k) + 7) (8 * k) in
  (* ---- the header record (REQ-401, REQ-409, REQ-012) ----
     Frame octet 0 is the most significant octet of [dst_mac], so the fields
     are the octets read out most significant first — the numeric decode
     REQ-012 asks for, done by the concatenation order and not by a reversal
     network. On the cycle input word 1 arrives, [previous] holds word 0:
     octets 0 to 5 are [dst_mac], 6 and 7 are the top of [src_mac], and word 1
     supplies the rest of [src_mac] at positions 0 to 3 and the ethertype at
     positions 4 and 5. *)
  let dst_mac = concat_msb (List.init 6 ~f:(fun k -> octet_of previous k)) in
  let src_mac =
    concat_msb
      (List.init 2 ~f:(fun k -> octet_of previous (payload_offset + k))
       @ List.init 4 ~f:(fun k -> octet_of i.rx.tdata k))
  in
  let ethertype = concat_msb (List.init 2 ~f:(fun k -> octet_of i.rx.tdata (4 + k))) in
  (* ---- the short frame (REQ-402, §9) ----
     Fewer than 14 octets. That can only happen on word 0, which carries at
     most 8, or on word 1 which did not reach frame octet 13; in [Payload] the
     frame already has at least 16, so the condition is not expressible there
     and is not tested for. The strobe is registered from this decision, so it
     pulses one cycle after the input [tlast] word — §9's pinned cycle. *)
  let short_frame =
    ends_here &: (in_idle |: (in_header &: ~:reaches_header_end))
  in
  (* [hdr_valid] pulses one cycle after input word 1 unless that word ended a
     short frame — the same cycle and the same decision as the strobe, which is
     why §9 gives them the same offset. A 14-octet frame is not short: the
     header is complete, the pulse happens, and no payload frame follows
     (requirements.md §0.7, REQ-011). *)
  let header_complete = in_header &: word in
  let header_valid_now = header_complete &: ~:short_frame in
  (* ---- the payload pipeline (REQ-021, REQ-408, REQ-005) ----
     One payload word is assembled per input word from [Payload] onward, plus
     the drain word of the module doc. The two loads can never coincide: a
     drain load lands on the cycle after a [tlast], on which the state is
     [Idle] by construction, so [in_payload] is 0 there — a new frame's word 0
     arriving on that cycle (REQ-410) is word 0 of its own frame and word 2 of
     nothing. *)
  let payload_load = in_payload &: word in
  let drain_now = ends_here &: (in_header |: in_payload) &: reaches_payload_offset in
  let drain_load = reg spec drain_now in
  let load = payload_load |: drain_load in
  (* The assembly, identical for every payload word including the drain one.
     On a drain cycle the current input word contributes nothing, so its share
     of [tkeep] is masked to zero and its share of [tdata] is left alone —
     §6.3 item 2 leaves [tdata] unconstrained wherever [tkeep] is 0, and
     masking 48 bits to satisfy nobody would be logic with no reader. *)
  let realigned_data =
    concat_msb
      [ select i.rx.tdata ((8 * payload_offset) - 1) 0
      ; select previous 63 (8 * payload_offset)
      ]
  in
  let realigned_keep =
    concat_msb
      [ mux2 drain_load (zero payload_offset) (select i.rx.tkeep (payload_offset - 1) 0)
      ; select previous_keep 7 payload_offset
      ]
  in
  (* The payload's last word is the drain word where there is one, and the word
     loaded on the input [tlast] cycle otherwise. REQ-403, REQ-007: the abort
     bit rides with it — live on a [tlast] load, from the holding register on a
     drain load, and never originated here. *)
  let payload_last_now =
    drain_load |: (payload_load &: i.rx.tlast &: ~:reaches_payload_offset)
  in
  let payload_tuser_now = mux2 drain_load previous_tuser i.rx.tuser in
  (* [tdata] and [tkeep] hold between loads — no consumer may read them on a
     cycle with [tvalid] = 0 (§6.3 item 2) — while [tlast] and [tuser] are
     driven to 0 there, so a waveform never shows a frame boundary that is not
     one. *)
  let payload_tvalid = reg spec load in
  let payload_tdata = reg spec ~enable:load realigned_data in
  let payload_tkeep = reg spec ~enable:load realigned_keep in
  let payload_tlast = reg spec (load &: payload_last_now) in
  let payload_tuser = reg spec (load &: payload_tuser_now) in
  let hdr_valid = reg spec header_valid_now in
  let hdr_dst_mac = reg spec ~enable:header_complete dst_mac in
  let hdr_src_mac = reg spec ~enable:header_complete src_mac in
  let hdr_ethertype = reg spec ~enable:header_complete ethertype in
  let short_frame_strobe = reg spec short_frame in
  (* The machine advances on the input side alone (§6.2): it leaves on the
     input [tlast] and the pipeline drains behind it, which is what REQ-410's
     back-to-back case rests on. A frame ending on its first word never reaches
     [Header], so its octets can never be mistaken for a header. *)
  Always.(
    compile
      [ sm.switch
          [ State.Idle, [ when_ (word &: ~:(i.rx.tlast)) [ sm.set_next State.Header ] ]
          ; ( State.Header
            , [ when_
                  word
                  [ if_
                      i.rx.tlast
                      [ sm.set_next State.Idle ]
                      [ sm.set_next State.Payload ]
                  ]
              ] )
          ; State.Payload, [ when_ ends_here [ sm.set_next State.Idle ] ]
          ]
      ]);
  { O.hdr =
      { Eth_header.valid = hdr_valid &: ~:reset_window
      ; dst_mac = hdr_dst_mac
      ; src_mac = hdr_src_mac
      ; ethertype = hdr_ethertype
      }
  ; payload =
      { Axi64.Source.tvalid = payload_tvalid &: ~:reset_window
      ; tdata = payload_tdata
      ; tkeep = payload_tkeep
      ; tstrb = zero 8 (* REQ-014 *)
      ; tlast = payload_tlast
      ; tuser = payload_tuser
      }
  ; error_short_frame = short_frame_strobe &: ~:reset_window
  }
;;

let hierarchical ?instance scope (i : Signal.t I.t) : Signal.t O.t =
  let module H = Hierarchy.In_scope (I) (O) in
  H.hierarchical ?instance ~scope ~name:"eth_axis_rx" create i
;;
