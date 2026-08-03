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
  // A second start character while a frame is open is out of Phase 1's
  // authorised stimulus (WO-0046 §9, REQ-110's abort case) and is not
  // handled here -- this testbench $finishes loudly rather than guess, the
  // same choice ours_run.ml makes.
  // ------------------------------------------------------------------

  integer stim_fd, out_fd, meta_fd;
  integer scan_ret;
  reg [63:0] rxd_line;
  reg [7:0]  rxc_line;
  integer stimulus_lines;

  reg        frame_open;
  integer    frame_index;
  integer    next_index;

  task write_word;
    // One "W" line for the CURRENT m_axis_t* outputs (WO-0046 §2.3): tkeep,
    // tlast, tuser0, then the tkeep-selected octets of m_axis_tdata in
    // ascending position order (bit 0 of tkeep is octet 0 = tdata[7:0]).
    integer k;
    begin
      $fwrite(out_fd, "W %02x %0d %0d", m_axis_tkeep, m_axis_tlast, m_axis_tuser & 1'b1);
      for (k = 0; k < 8; k = k + 1) begin
        if (m_axis_tkeep[k])
          $fwrite(out_fd, " %02x", (m_axis_tdata >> (8*k)) & 8'hff);
      end
      $fwrite(out_fd, "\n");
    end
  endtask

  task open_frame;
    begin
      frame_open  = 1'b1;
      frame_index = next_index;
      next_index  = next_index + 1;
      $fwrite(out_fd, "F %0d\n", frame_index);
    end
  endtask

  // Two tasks rather than one parameterised by a string: a fixed-width
  // packed-string argument would need "accept" (6 chars) padded or
  // truncated to match "discard" (7 chars), and any padding character
  // risks landing in the written line as trailing whitespace, which
  // WO-0046 §2.3's grammar forbids. Two literal $fwrite format strings
  // sidestep the question entirely.
  task close_frame_accept;
    begin
      $fwrite(out_fd, "D %0d accept\n", frame_index);
      frame_open = 1'b0;
    end
  endtask

  task close_frame_discard;
    begin
      $fwrite(out_fd, "D %0d discard\n", frame_index);
      frame_open = 1'b0;
    end
  endtask

  reg not_done;

  initial begin
    frame_open  = 1'b0;
    frame_index = 0;
    next_index  = 0;
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
        // driving the same word.
        if ((rxc_line[0] && rxd_line[7:0] == 8'hFB)
            || (rxc_line[4] && rxd_line[39:32] == 8'hFB)) begin
          if (frame_open) begin
            $display(
              "tb_xgmii_rx_64: FAIL a second start character arrived while frame %0d was open -- REQ-110 abort handling is out of Phase 1's authorised stimulus (WO-0046 section 9)",
              frame_index);
            $finish;
          end
          open_frame;
        end

        xgmii_rxd = rxd_line;
        xgmii_rxc = rxc_line;
        @(posedge clk);
        #1; // let the reference's combinational outputs settle post-edge

        if (m_axis_tvalid) begin
          if (!frame_open) begin
            $display("tb_xgmii_rx_64: FAIL the reference produced an output word with no admitted frame open");
            $finish;
          end
          write_word;
          if (m_axis_tlast) close_frame_accept;
        end
      end
    end

    // End of stimulus (which already includes Phase 1's drain margin,
    // stimulus_gen.ml): a frame still open here was admitted but never
    // produced a tlast word -- REQ-901's discard case.
    if (frame_open) close_frame_discard;

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
