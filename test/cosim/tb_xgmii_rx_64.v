/*

WO-0046 §2.1/§5 — the wrapper testbench around the vendored reference
`axis_xgmii_rx_64` (test/third_party/verilog-ethernet/axis_xgmii_rx_64.v,
pinned at 77320a9471d19c7dd383914bc049e02d9f4f1ffb, PROVENANCE.md). It
instantiates the reference with REQ-901's parameters mapped onto this
module's own parameter names (WO-0046 §6 question 1 — see the Return log
for the full mapping and which of REQ-901's five settings have no
counterpart here), drives xgmii_rxd/xgmii_rxc from stimulus.txt, and
captures m_axis_t* into theirs.canon in canonical.mli's pinned grammar
(WO-0046 §2.3) plus a best-effort theirs.canon.meta sidecar.

BUILD CONTRACT (data_wrangler's tools/cosim/run_cosim.sh invokes this):
this file must be compiled together with BOTH
  test/third_party/verilog-ethernet/axis_xgmii_rx_64.v
  test/third_party/verilog-ethernet/lfsr.v
(the second is the first's sole instance, PROVENANCE.md's closure
re-derivation) — e.g.
  iverilog -o sim.vvp \
    test/cosim/tb_xgmii_rx_64.v \
    test/third_party/verilog-ethernet/axis_xgmii_rx_64.v \
    test/third_party/verilog-ethernet/lfsr.v
Neither vendored file may be edited to make this work (ADR-0015 D2's
no-edit rule) and none was: this file names them only in the comment above
and instantiates the reference through its published port list.

WORKING DIRECTORY CONTRACT: every path this file opens ("stimulus.txt",
"theirs.canon", "theirs.canon.meta") is relative to the process's current
working directory at `vvp` invocation time. ADR-0015/WO-0046 §7 requires
every simulator artifact to live outside the repository checkout in a
`mktemp -d` working directory; arranging that `cd` and placing
stimulus.txt there is tools/cosim/run_cosim.sh's job (WO-0046 §5), not
this file's.

HAS NEVER BEEN RUN. iverilog is not installed in this environment
(explicitly, per this work order's rules) and no other Verilog simulator
was used to exercise it either. This file is a from-spec, from-the-
reference's-own-published-port-list construction, self-reviewed line by
line against axis_xgmii_rx_64.v's module header — never executed, and
nothing below is offered as a result of having been executed. dv_lead's
review is expected to be its first simulation.

WO-0078 §2.3 / FINDING WO-0078-1 (Stage 1): every guard that used to
`$display` then bare `$finish` now ALSO writes a reserved "E ..." sentinel
line into theirs.canon and explicitly `$fclose`s it before finishing —
`$finish` alone is a normal termination (exit status 0 under Icarus,
RV-0049-VERDICT §4's measured note) that tools/cosim/run_cosim.sh's rc/
file-existence check (FI-8) cannot be assumed to catch, and one of the two
guards named in the finding left a WELL-FORMED, merely truncated
theirs.canon that test/cosim/canonical.ml's [Canonical.read] would have
accepted outright. See each guard's own comment for which shape it used to
produce and why the sentinel closes it; test/cosim/canonical.ml's own `"E"`
grammar note documents the reader's side of this contract.

WO-0078 §14, FINDING RV-0078-S2-1 (the C2 repair round): frame_open used
to test ONE piece of state for BOTH the REQ-110 refusal (a second start
character) and the orphan-output refusal (an output word with nothing
admitted) — its own span ran from the input start character to the
OUTPUT m_axis_tlast, which at SPEC-M03 section 6.1's DeltaC = 3 outlives
the input frame's own terminate character by exactly the pipeline
latency, so a lawful minimum-inter-frame-gap second frame landed its
start character on precisely the cycle the first frame's UNION span was
still open and was refused as REQ-110's abort case, which it is not (see
ours_run.ml's own header comment and this packet's §14, RV-C1C2 §4 for
the full measurement). The repair below is two spans, each tested by
exactly one guard — admission_open, closed at THIS frame's OWN input
terminate character (never at its output tlast), and a small FIFO of
frames admitted-but-not-yet-delivered, tested by the orphan-output
guard's emptiness check alone — implemented identically to ours_run.ml's
own accumulate, from REQ-110's own condition and SPEC-M03 section 6.1's
DeltaC, never from ours_run.ml's or the reference's own CODE. See each
guard's own comment below for the mirrored reasoning.

WO-0078 §14, FINDING RV-0078-S2-6 (the C2 repair round, second layer): the
guards above decide which schedules a producer ADMITS; they say nothing
about the FILE the producer then writes. This file used to $fwrite each F/W/D
record at the instant of its own event -- admission, each output word,
delivery close -- so two frames whose admission and delivery spans overlap
(lawful since the S2-1 repair above, and guaranteed at SPEC-M03 section
6.1's DeltaC = 3 under the minimum inter-frame gap) produced an
INTERLEAVED file: frame N+1's own F line landed between frame N's own W
lines and its D line, which canonical.mli's pinned grammar (one F line,
then that frame's W lines, then its D line, contiguous) does not admit --
Canonical.read (a single-frame-open state machine) correctly refused it.
The repair chosen here, against RV-C2RERUN section 6's seven preserved
properties (this packet's §14 Return log states the reasoning against each):
buffer each admitted-but-not-yet-closed frame's own F-line fields and
captured W-line fields in the delivery FIFO's own per-slot storage below,
and write that frame's ENTIRE block -- F line, every buffered W line in
emission order, D line -- CONTIGUOUSLY, at the moment the frame CLOSES
(close_delivery_accept/close_delivery_discard), never streamed across real
time. Closure always happens in admission order by construction of this
FIFO (an output word always attaches to delivery_head, and m_axis_tlast
always pops it), so this needs no separate ordering decision. The grammar
itself (canonical.mli) is UNCHANGED -- this is a producer-side buffering
fix, never a grammar amendment, precisely because a W-record frame-index
field would change every single-frame file's own bytes too (property 2:
case 0 and C1 stay byte-identical) and because teaching the READER to
attribute an interleaved W line to "the oldest open frame" would install a
behavioural assumption about the design under test inside the comparator
(property 1, this finding's own words). The per-frame word buffer is
bounded (MAX_WORDS_PER_FRAME below) and its own exhaustion is a NEW
refusal with its own E sentinel, in the same spirit as DELIVERY_DEPTH's
own guard above (property 5) -- never an unbounded accumulation in a
Verilog testbench.

*/

// Language: Verilog 2001, matching the vendored reference's own dialect.
`default_nettype none
`timescale 1ns / 1ps

module tb_xgmii_rx_64;

  // ------------------------------------------------------------------
  // Clock. REQ-901's comparison is transactional, not cycle-by-cycle
  // (requirements.md REQ-901; WO-0046 §1), so the simulation clock rate is
  // not a compared quantity -- 156.25 MHz (6.4 ns) is used anyway, matching
  // the programme's real clock, purely so a waveform dump (if one is ever
  // taken) reads at the true rate.
  // ------------------------------------------------------------------

  reg clk = 1'b0;
  always #3.2 clk = ~clk;

  reg rst = 1'b1;
  reg cfg_rx_enable = 1'b1;

  // Idle fill (eight /I/ = 0x07 lanes) until the first stimulus line loads;
  // harmless either way since `rst` is held for the first cycle.
  reg [63:0] xgmii_rxd = 64'h0707070707070707;
  reg [7:0]  xgmii_rxc = 8'hff;

  wire [63:0] m_axis_tdata;
  wire [7:0]  m_axis_tkeep;
  wire        m_axis_tvalid;
  wire        m_axis_tlast;
  wire        m_axis_tuser; // USER_WIDTH = 1 with PTP_TS_ENABLE = 0 (question 2)

  // ------------------------------------------------------------------
  // REQ-901's parameter mapping (WO-0046 §6 question 1; full answer in the
  // Return log).  Only DATA_WIDTH and PTP_TS_ENABLE are overridden:
  //   - PTP_TS_ENABLE(0)  is the one REQ-901 setting with a real counterpart
  //     here ("PTP disabled").
  //   - DATA_WIDTH(64)    restates the architecture's 64-bit datapath
  //     explicitly; it is already the module's own default.
  // KEEP_WIDTH, CTRL_WIDTH, PTP_TS_FMT_TOD, PTP_TS_WIDTH and USER_WIDTH are
  // left at the reference's own defaults, which correctly evaluate to 8, 8,
  // 1, 96 and (0 ? 96 : 0) + 1 = 1 respectively given the two overrides
  // above -- restating those formulas' RESULTS here as further overrides
  // would risk a transcription mismatch this testbench cannot self-check
  // without iverilog.
  //
  // REQ-901's other four settings -- deficit idle count disabled, padding
  // enabled, minimum frame length 64, transmit checksum generation disabled
  // -- have NO counterpart parameter on `axis_xgmii_rx_64` at all: DIC and
  // padding and minimum-length enforcement are transmit-side behaviour
  // (the reference's own axis_xgmii_tx_64.v / eth_mac_10g.v, not vendored
  // here because M03's counterpart is the RX module only, architecture.md
  // §4), and transmit checksum generation belongs to a different layer
  // entirely (IPv4/UDP transmit, REQ-609/REQ-706). This module reads no
  // parameter for any of the four, and none is invented below.
  // ------------------------------------------------------------------

  axis_xgmii_rx_64 #(
    .DATA_WIDTH    (64),
    .PTP_TS_ENABLE (0)
  ) dut (
    .clk             (clk),
    .rst             (rst),
    .xgmii_rxd       (xgmii_rxd),
    .xgmii_rxc       (xgmii_rxc),
    .m_axis_tdata    (m_axis_tdata),
    .m_axis_tkeep    (m_axis_tkeep),
    .m_axis_tvalid   (m_axis_tvalid),
    .m_axis_tlast    (m_axis_tlast),
    .m_axis_tuser    (m_axis_tuser),
    .ptp_ts          (96'd0),
    .cfg_rx_enable   (cfg_rx_enable),
    .start_packet    (),
    .error_bad_frame (),
    .error_bad_fcs   ()
  );

  // ------------------------------------------------------------------
  // Stimulus + capture. Mirrors ours_run.ml's `accumulate` algorithm
  // exactly (WO-0046 §6 question 4): a frame is admitted on a recognised
  // start character (lane 0 or lane 4, REQ-101's own control-character
  // encoding -- 0xFB is /S/, requirements.md §2 -- read from the spec, not
  // from this reference's RTL); it is reported `accept` iff an
  // `m_axis_tlast` word is observed for it before the stimulus (which
  // already carries its own drain margin, stimulus_gen.ml) is exhausted,
  // and `discard` otherwise (WO-0046 §2.3's "no output word at all" case).
  // A second start character while a frame's ADMISSION span is open is out
  // of Phase 1's authorised stimulus (WO-0046 §9, REQ-110's abort case) and
  // is not handled here -- this testbench $finishes loudly rather than
  // guess, the same choice ours_run.ml makes.
  //
  // WO-0078 §14, FINDING RV-0078-S2-1: two spans, tracked separately,
  // exactly as ours_run.ml's own `accumulate` now does (see that file's
  // header comment for the full derivation).
  //
  //   admission_open -- true from the cycle a start character is
  //   recognised on the INPUT word to the cycle that SAME frame's own
  //   terminate character is recognised on the INPUT word (or forever, if
  //   the stimulus ends first). The REQ-110 guard below tests ONLY this.
  //
  //   A FIFO (delivery_index / delivery_head / delivery_tail /
  //   delivery_count), admission order, of frames admitted but not yet
  //   closed by their OUTPUT m_axis_tlast -- an output word always
  //   attaches to delivery_head (the oldest not-yet-closed frame), and
  //   m_axis_tlast pops it. The orphan-output guard (FI-7) tests ONLY this
  //   FIFO's emptiness (delivery_count == 0), never admission_open, which
  //   may already be closed for the very frame still occupying the FIFO's
  //   head (its own admission span closed at its own /T/, cycles before
  //   its last output word is delivered, at SPEC-M03 §6.1's DeltaC = 3).
  //
  //   DELIVERY_DEPTH bounds how many frames may be admitted-but-
  //   undelivered at once -- a Verilog-2001 fixed-size array needs a
  //   bound where ours_run.ml's OCaml list does not. 8 is generous
  //   headroom over anything this lane's stimulus (case 0 through C4, one
  //   or two frames) presents; exceeding it is a NEW harness-defect
  //   refusal this file introduces (flagged here, in the same spirit as
  //   the WO-0078 §2.3 sentinel guards above, rather than silently added),
  //   inert for every fixture and every case this repair round ships.
  // ------------------------------------------------------------------

  // ------------------------------------------------------------------
  // WO-0078 §14, FINDING RV-0078-S2-6: each delivery-FIFO slot ALSO buffers
  // its own frame's F-line fields (admit_cycle) and captured W-line fields
  // (tkeep/tlast/tuser0/cycle/tdata, up to MAX_WORDS_PER_FRAME of them) --
  // see the top-of-file comment for the full derivation and the seven
  // preserved properties this buffering is measured against. Nothing here
  // is $fwrite'n to theirs.canon until the frame CLOSES (accept or
  // discard); the old write_word's immediate-$fwrite role is now split
  // into capture_word (stores) and write_word_line (formats and $fwrites
  // one buffered word, called only from a frame's own close_delivery_*
  // flush).
  //
  //   MAX_WORDS_PER_FRAME bounds how many output words one admitted frame
  //   may buffer before its own D line closes it -- the same kind of bound
  //   DELIVERY_DEPTH above is, for the same Verilog-2001 fixed-size-array
  //   reason. 16 is generous headroom over the 8 words every case this
  //   lane drives today produces (case 0 through C2: one 64-octet frame is
  //   exactly 8 64-bit words, stimulus_gen.ml's own stress_frame); its own
  //   exhaustion is a NEW refusal, with its own E sentinel, in the same
  //   spirit as DELIVERY_DEPTH's guard and inert for every fixture and
  //   case this repair round ships.
  // ------------------------------------------------------------------

  integer stim_fd, out_fd, meta_fd;
  integer scan_ret;
  reg [63:0] rxd_line;
  reg [7:0]  rxc_line;
  integer stimulus_lines;

  localparam DELIVERY_DEPTH = 8;
  localparam MAX_WORDS_PER_FRAME = 16;

  reg        admission_open;
  integer    admission_index;   // the currently-admitting frame's own index -- report-only

  reg [31:0] delivery_index [0:DELIVERY_DEPTH-1];
  integer    delivery_head;
  integer    delivery_tail;
  integer    delivery_count;
  integer    next_index;

  // WO-0078 §14, FINDING RV-0078-S2-6: per-slot buffered F-line field and
  // word count (indexed exactly as delivery_index above, slot = FIFO
  // position modulo DELIVERY_DEPTH); per-word buffered W-line fields,
  // flattened to one dimension (slot*MAX_WORDS_PER_FRAME + word-index)
  // rather than declared as a true 2-D array, so indexing stays explicit
  // and reviewable against the $fwrite call sites it replaces.
  reg [31:0] delivery_admit_cycle [0:DELIVERY_DEPTH-1];
  integer    delivery_word_count  [0:DELIVERY_DEPTH-1];

  reg [7:0]  delivery_word_tkeep  [0:DELIVERY_DEPTH*MAX_WORDS_PER_FRAME-1];
  reg        delivery_word_tlast  [0:DELIVERY_DEPTH*MAX_WORDS_PER_FRAME-1];
  reg        delivery_word_tuser0 [0:DELIVERY_DEPTH*MAX_WORDS_PER_FRAME-1];
  reg [31:0] delivery_word_cycle  [0:DELIVERY_DEPTH*MAX_WORDS_PER_FRAME-1];
  reg [63:0] delivery_word_tdata  [0:DELIVERY_DEPTH*MAX_WORDS_PER_FRAME-1];

  function has_terminate;
    // WO-0078 §14, FINDING RV-0078-S2-1: the admission span's own closing
    // condition -- a terminate character anywhere in the CURRENT stimulus
    // line, scanned across all eight lanes exactly as the admission check
    // below scans lane 0 and lane 4 for the start character (same shape,
    // different target character: 8'hFD, not 8'hFB), never derived from
    // the reference's own output.
    input [63:0] d;
    input [7:0]  c;
    integer k;
    begin
      has_terminate = 1'b0;
      for (k = 0; k < 8; k = k + 1)
        if (c[k] && d[8*k +: 8] == 8'hFD)
          has_terminate = 1'b1;
    end
  endfunction

  task capture_word;
    // WO-0078 §14, FINDING RV-0078-S2-6: stores the CURRENT m_axis_t*
    // outputs into the delivery FIFO's HEAD slot's own word buffer, rather
    // than $fwrite'ing a "W" line immediately (which is what produced the
    // interleaved file the finding names). Every field this used to format
    // directly is stored UNCHANGED -- tkeep, tlast, tuser0 & 1'b1, cycle
    // (stimulus_lines - 1, the SAME 0-based index -- WO-0075 section 3.0's
    // shared time base -- this always used), and the full m_axis_tdata
    // word, so write_word_line below can reproduce the identical formatted
    // line, byte for byte, at flush time. See the top-of-file comment for
    // the full derivation and the properties this buffering preserves.
    integer slot, w;
    begin
      slot = delivery_head % DELIVERY_DEPTH;
      w    = delivery_word_count[slot];
      if (w >= MAX_WORDS_PER_FRAME) begin
        $display(
          "tb_xgmii_rx_64: FAIL word buffer exhausted for frame %0d (MAX_WORDS_PER_FRAME=%0d) -- more output words captured for this frame than this bench's headroom allows",
          delivery_index[slot],
          MAX_WORDS_PER_FRAME);
        $fwrite(out_fd, "E word-buffer-exhausted\n");
        $fclose(out_fd);
        $fclose(stim_fd);
        $fclose(meta_fd);
        $finish;
      end
      delivery_word_tkeep[slot*MAX_WORDS_PER_FRAME + w]  = m_axis_tkeep;
      delivery_word_tlast[slot*MAX_WORDS_PER_FRAME + w]  = m_axis_tlast;
      delivery_word_tuser0[slot*MAX_WORDS_PER_FRAME + w] = m_axis_tuser & 1'b1;
      delivery_word_cycle[slot*MAX_WORDS_PER_FRAME + w]  = stimulus_lines - 1;
      delivery_word_tdata[slot*MAX_WORDS_PER_FRAME + w]  = m_axis_tdata;
      delivery_word_count[slot] = w + 1;
    end
  endtask

  task write_word_line;
    // One "W" line for a BUFFERED output word (WO-0046 §2.3; cycle field
    // added WO-0075 §2), read from capture_word's own stored fields at
    // slot [slot], word [w] rather than from the live m_axis_t* wires --
    // tkeep, tlast, tuser0, cycle, then the tkeep-selected octets of the
    // stored tdata in ascending position order (bit 0 of tkeep is octet 0
    // = tdata[7:0]), IDENTICAL in format to what this file used to
    // $fwrite directly (WO-0078 §14, FINDING RV-0078-S2-6). Called only
    // from a frame's own close_delivery_accept/close_delivery_discard, in
    // ascending word order, so the file's own per-word emission order is
    // unchanged by this repair -- only WHEN each line reaches disk moved,
    // never the order the words appear in relative to each other.
    //
    // WO-0049 §3's own lesson about `%x` field widths being set by the
    // ARGUMENT's bit width still applies, reproduced verbatim on the
    // STORED reg rather than the live wire: the Verilog-2001 indexed
    // part-select below is exactly 8 bits wide BY CONSTRUCTION (its width
    // is the literal after `+:`, not derived from any operand), which is
    // what pins the printed octet field at two hex digits regardless of
    // which reg it slices.
    input integer slot;
    input integer w;
    integer k, idx;
    begin
      idx = slot * MAX_WORDS_PER_FRAME + w;
      $fwrite(
        out_fd,
        "W %02x %0d %0d %0d",
        delivery_word_tkeep[idx],
        delivery_word_tlast[idx],
        delivery_word_tuser0[idx],
        delivery_word_cycle[idx]);
      for (k = 0; k < 8; k = k + 1) begin
        if (delivery_word_tkeep[idx][k])
          $fwrite(out_fd, " %02x", delivery_word_tdata[idx][8*k +: 8]);
      end
      $fwrite(out_fd, "\n");
    end
  endtask

  task open_frame;
    // WO-0075 section 2: the "F" line's fields -- frame index and
    // admit_cycle (`stimulus_lines - 1`, the 0-based index, section 3.0's
    // shared time base, of the CURRENT stimulus line carrying the start
    // character that triggered this call; `stimulus_lines` was already
    // incremented for this line by the top of the reading loop, before the
    // admission check below calls this task, so the `- 1` converts that
    // 1-based running count back to the 0-based line index `ours_run.ml`'s
    // `List.mapi` produces for the identical line) -- are captured HERE,
    // exactly as before.
    //
    // WO-0078 §14, FINDING RV-0078-S2-6: the "F" LINE ITSELF is no longer
    // $fwrite'n here -- only its fields are stored, into this frame's own
    // delivery-FIFO slot, for close_delivery_accept/close_delivery_discard
    // to write CONTIGUOUSLY with the rest of the frame's block when it
    // closes (see the top-of-file and Stimulus-+-capture comments for the
    // full derivation).
    //
    // WO-0078 §14, FINDING RV-0078-S2-1: opens the ADMISSION span
    // (admission_open) and pushes onto the delivery FIFO (delivery_tail) --
    // the two are set together here because admission and delivery both
    // begin at the same event (the start character), even though they
    // close independently below.
    begin
      if (delivery_count >= DELIVERY_DEPTH) begin
        $display(
          "tb_xgmii_rx_64: FAIL delivery FIFO exhausted (DELIVERY_DEPTH=%0d) -- more frames admitted-but-undelivered than this bench's headroom allows",
          DELIVERY_DEPTH);
        $fwrite(out_fd, "E delivery-fifo-exhausted\n");
        $fclose(out_fd);
        $fclose(stim_fd);
        $fclose(meta_fd);
        $finish;
      end
      admission_open  = 1'b1;
      admission_index = next_index;
      delivery_index[delivery_tail % DELIVERY_DEPTH]       = next_index;
      delivery_admit_cycle[delivery_tail % DELIVERY_DEPTH] = stimulus_lines - 1;
      delivery_word_count[delivery_tail % DELIVERY_DEPTH]  = 0;
      delivery_tail   = delivery_tail + 1;
      delivery_count  = delivery_count + 1;
      next_index = next_index + 1;
    end
  endtask

  // Two tasks rather than one parameterised by a string: a fixed-width
  // packed-string argument would need "accept" (6 chars) padded or
  // truncated to match "discard" (7 chars), and any padding character
  // risks landing in the written line as trailing whitespace, which
  // WO-0046 §2.3's grammar forbids. Two literal $fwrite format strings
  // sidestep the question entirely.
  //
  // WO-0078 §14, FINDING RV-0078-S2-1: both now close the DELIVERY FIFO's
  // head, never admission_open -- the frame being closed here may have had
  // its own admission span closed cycles ago (its own /T/, at SPEC-M03
  // §6.1's DeltaC = 3 before its last output word), which is exactly the
  // scenario the repair makes lawful.
  //
  // WO-0078 §14, FINDING RV-0078-S2-6: both now write the closing frame's
  // ENTIRE block -- F line (from delivery_index/delivery_admit_cycle), then
  // every word write_word_line's caller buffered for this slot, in order,
  // then the D line -- CONTIGUOUSLY, here, rather than the F line having
  // already been $fwrite'n at admission (real time) and the W lines as each
  // arrived (also real time). Frame closure always happens in admission
  // order by construction of this FIFO (an output word always attaches to
  // delivery_head, and only delivery_head ever closes), so this needs no
  // separate ordering decision: whichever frame is at the head is the next
  // (and only) one whose block may legally be written.
  task close_delivery_accept;
    integer slot, w;
    begin
      slot = delivery_head % DELIVERY_DEPTH;
      $fwrite(out_fd, "F %0d %0d\n", delivery_index[slot], delivery_admit_cycle[slot]);
      for (w = 0; w < delivery_word_count[slot]; w = w + 1)
        write_word_line(slot, w);
      $fwrite(out_fd, "D %0d accept\n", delivery_index[slot]);
      delivery_head  = delivery_head + 1;
      delivery_count = delivery_count - 1;
    end
  endtask

  task close_delivery_discard;
    integer slot, w;
    begin
      slot = delivery_head % DELIVERY_DEPTH;
      $fwrite(out_fd, "F %0d %0d\n", delivery_index[slot], delivery_admit_cycle[slot]);
      for (w = 0; w < delivery_word_count[slot]; w = w + 1)
        write_word_line(slot, w);
      $fwrite(out_fd, "D %0d discard\n", delivery_index[slot]);
      delivery_head  = delivery_head + 1;
      delivery_count = delivery_count - 1;
    end
  endtask

  reg not_done;

  initial begin
    admission_open  = 1'b0;
    admission_index = 0;
    delivery_head   = 0;
    delivery_tail   = 0;
    delivery_count  = 0;
    next_index      = 0;
    stimulus_lines = 0;

    stim_fd = $fopen("stimulus.txt", "r");
    if (stim_fd == 0) begin
      $display("tb_xgmii_rx_64: FAIL cannot open stimulus.txt for reading");
      $finish;
    end
    out_fd = $fopen("theirs.canon", "w");
    if (out_fd == 0) begin
      $display("tb_xgmii_rx_64: FAIL cannot open theirs.canon for writing");
      $finish;
    end
    meta_fd = $fopen("theirs.canon.meta", "w");
    if (meta_fd == 0) begin
      $display("tb_xgmii_rx_64: FAIL cannot open theirs.canon.meta for writing");
      // WO-0078 §2.3 / FINDING WO-0078-1: at this point out_fd is already
      // open and theirs.canon exists but is EMPTY -- Canonical.read (an
      // empty file, zero frames) parses that as a VALID, if vacuous,
      // transaction, which a divergence against ours.canon would then
      // misreport as a genuine content finding rather than a harness
      // malfunction (a third instance of the exact shape the finding names
      // for FI-6/FI-7 below, found while repairing those and fixed the same
      // way for consistency -- flagged in the Return log as an extension
      // beyond the packet's own §2.2 census, not silently added or silently
      // left). See the sentinel comment at the two guards below for the
      // full reasoning.
      $fwrite(out_fd, "E cannot-open-metadata-sidecar\n");
      $fclose(out_fd);
      $fclose(stim_fd);
      $finish;
    end

    // REQ-009-style settling: hold reset for one full cycle before the
    // first stimulus line is driven (cycle alignment is not compared,
    // WO-0046 §1, so the exact depth here is not load-bearing).
    @(posedge clk);
    rst = 1'b0;

    not_done = 1'b1;
    while (not_done) begin
      scan_ret = $fscanf(stim_fd, "%h %h", rxd_line, rxc_line);
      if (scan_ret != 2) begin
        not_done = 1'b0;
      end else begin
        stimulus_lines = stimulus_lines + 1;

        // Admission check on the word ABOUT TO BE driven this cycle,
        // exactly as ours_run.ml checks Xgmii_word.start_lane before
        // driving the same word. WO-0078 §14, FINDING RV-0078-S2-1: tests
        // ONLY admission_open -- the ADMISSION span, never the delivery
        // FIFO's state.
        if ((rxc_line[0] && rxd_line[7:0] == 8'hFB)
            || (rxc_line[4] && rxd_line[39:32] == 8'hFB)) begin
          if (admission_open) begin
            $display(
              "tb_xgmii_rx_64: FAIL a second start character arrived while frame %0d's admission span was open -- REQ-110 abort handling is out of Phase 1's authorised stimulus (WO-0046 section 9)",
              admission_index);
            // WO-0078 §2.3 / FINDING WO-0078-1: a bare $finish here is a
            // NORMAL simulation termination (exit status 0 under Icarus,
            // measured by dv_lead at RV-0049-VERDICT §4's own toolchain
            // note) -- tools/cosim/run_cosim.sh's run_pipeline (FI-8) checks
            // only `$rc -ne 0` and file existence, neither of which this
            // refusal trips on its own. This guard's OWN shape happens to
            // leave admission_index's frame open in theirs.canon (no D line
            // was ever written for it), which Canonical.read already
            // rejects at end-of-file ("frame N still open") -- but that is
            // the ACCIDENT of this particular guard's placement, not
            // something this file arranges on purpose, and the finding's
            // own text is explicit that a refusal reaching a distinct code
            // must hold BY CONSTRUCTION, not by inference from one guard's
            // happenstance shape (the other guard, immediately below, has
            // no such luck). This sentinel line is written into
            // theirs.canon itself, which Canonical.read
            // (test/cosim/canonical.ml) now recognises and rejects
            // explicitly regardless of what state it finds the parser in.
            // $fclose is explicit, ahead of $finish, rather than relying on
            // $finish's own flush behaviour -- for the identical "by
            // construction, not by inference" reason.
            $fwrite(out_fd, "E second-start-while-open frame=%0d\n", admission_index);
            $fclose(out_fd);
            $fclose(stim_fd);
            $fclose(meta_fd);
            $finish;
          end
          open_frame;
        end

        // The admission span's own closing condition -- THIS SAME
        // stimulus line's terminate character (WO-0078 §14, FINDING
        // RV-0078-S2-1). Checked after the start-character arm above,
        // mirroring ours_run.ml's own fold order; under requirements.md
        // §0.3's minimum IFG (12 octets, more than one 8-lane word) a
        // terminate character and a later start character can never land
        // in the same word for conformant stimulus, so this ordering is
        // never actually exercised both ways at once.
        if (admission_open && has_terminate(rxd_line, rxc_line))
          admission_open = 1'b0;

        xgmii_rxd = rxd_line;
        xgmii_rxc = rxc_line;
        @(posedge clk);
        #1; // let the reference's combinational outputs settle post-edge

        if (m_axis_tvalid) begin
          // WO-0078 §14, FINDING RV-0078-S2-1: tests ONLY the delivery
          // FIFO's emptiness -- never admission_open, which by design may
          // already be closed for the very frame this word belongs to.
          if (delivery_count == 0) begin
            $display("tb_xgmii_rx_64: FAIL the reference produced an output word with no admitted frame open");
            // WO-0078 §2.3 / FINDING WO-0078-1: THIS is the guard whose
            // pre-existing failure mode was the worse of the two named in
            // the finding (FI-7). delivery_count is 0 BY DEFINITION at this
            // point, so every PRIOR frame was already closed with its own D
            // line -- theirs.canon, at this exact moment, is a WELL-FORMED
            // (merely truncated) canonical file. Without this sentinel,
            // Canonical.read would ACCEPT it as a short-but-valid
            // transaction, and compare would silently report the resulting
            // Missing_frame/Word_count_mismatch as a genuine content
            // divergence (exit 1) -- exactly the harness-malfunction-read-
            // as-an-anchor-finding hazard WO-0049 §8 was written about, now
            // recurring on the reference side rather than ours. The
            // sentinel line makes the file fail to parse ON PURPOSE, by
            // construction, closing that gap; see the other guard above for
            // the identical mechanism and the explicit $fclose ordering.
            // The sentinel TEXT is unchanged by this repair round --
            // test/cosim/compare.ml's own self-test
            // (`reference_refusal_canon_text`) reproduces it by value and
            // must keep matching.
            $fwrite(out_fd, "E word-with-no-open-frame\n");
            $fclose(out_fd);
            $fclose(stim_fd);
            $fclose(meta_fd);
            $finish;
          end
          capture_word;
          if (m_axis_tlast) close_delivery_accept;
        end
      end
    end

    // End of stimulus (which already includes Phase 1's drain margin,
    // stimulus_gen.ml): any frame(s) still in the delivery FIFO were
    // admitted but never produced a tlast word -- REQ-901's discard case,
    // closed oldest first (FIFO order), which is admission order
    // (WO-0078 §14, FINDING RV-0078-S2-1).
    while (delivery_count > 0) close_delivery_discard;

    // Best-effort sidecar (WO-0046 §2.3: "never compared"). This process
    // can determine the reference pin (fixed, from PROVENANCE.md) and the
    // stimulus file it actually consumed; it CANNOT determine its own
    // simulator's name/version or the runner image identifier from inside
    // Verilog with no external call and no environment beyond PATH
    // (WO-0046's own constraint on the harness) -- those two fields are
    // left explicitly marked for tools/cosim/run_cosim.sh to fill in or
    // overwrite, since only the invoking shell knows them. See the Return
    // log's open question on this split.
    $fwrite(meta_fd, "reference-pin: 77320a9471d19c7dd383914bc049e02d9f4f1ffb\n");
    $fwrite(meta_fd, "stimulus-file: stimulus.txt\n");
    $fwrite(meta_fd, "stimulus-lines: %0d\n", stimulus_lines);
    $fwrite(meta_fd, "simulator: unknown (fill in: tools/cosim/run_cosim.sh knows which binary/version it invoked)\n");
    $fwrite(meta_fd, "runner-image: unknown (fill in: tools/cosim/run_cosim.sh knows its own environment)\n");

    $fclose(stim_fd);
    $fclose(out_fd);
    $fclose(meta_fd);
    $finish;
  end

endmodule

`resetall
