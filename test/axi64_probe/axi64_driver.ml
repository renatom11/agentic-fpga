(** Driving adapter: a plain [Stream_word.t] becomes the six [Bits.t ref]s of a
    live [Axi64.Source] in a [Cyclesim] simulation, and an [Eth_header] record
    becomes its four. WO-0033 item **X-6** — "`test/axi64_probe/` samples a live
    [Source]; nothing drives one" (`AP-ip_eth_rx_64.md` §7).

    {2 Why this is in the probe's library and not the monitors'}

    Same reason [Axi64_probe] is: it names Hardcaml types. [dv_monitors] and
    [dv_golden] stay Hardcaml-free so their own tests fail when a monitor or an
    oracle is wrong rather than when an elaboration is; every seam to a live
    simulation lives here, in one directory, where a transcription error is
    confined.

    {2 The record fields are SPEC-M01's, and nothing else was read}

    [Ifc_check.Axi64_ifc] is the lift of SPEC-M01 §4.1 under `docs/specs/` —
    byte-identical to the specification and countersigned at 22145b5.
    [Axi64.Source] is [{ tvalid; tdata; tkeep; tstrb; tlast; tuser }] and
    [Eth_header] is [{ valid; dst_mac; src_mac; ethertype }]. Those records are
    this file's whole source: `libs/**` is not depended on and was not opened
    (PROTOCOL §10), and the M14 bench this driver exists for must be derivable
    from SPEC-M14 and SPEC-M01 alone.

    {2 One function, no policy — and what that buys}

    The driver writes exactly the word it is handed and decides nothing. In
    particular it does {b not} choose what to drive on a cycle with
    [tvalid] = 0: SPEC-M01 §6.3 item 5 leaves [tdata], [tkeep], [tstrb],
    [tlast] and [tuser] unconstrained there, so a bench that wants a
    conformance stimulus drives [Stream_word.idle ()] and a bench that wants to
    {e prove the design does not look} drives [Stream_word.garbage_idle ()] —
    the same word [dv_monitors]' own tests use to prove the monitors do not
    look. Baking either choice in would have made the second stimulus
    unreachable, and it is the one that finds the defect.

    Likewise the driver never asserts [tready] and never reads one: REQ-003
    puts no [Dest] on a receive-path port, and there is nothing here to
    handshake with. A bench drives one word per cycle, unconditionally, which
    is REQ-112 restated on the stimulus side.

    {2 The header pulse}

    REQ-606 and SPEC-M14 §6.1 make the record a {b one-cycle pulse}, one cycle
    before payload word 0 — not a level (that is the transmit-side discipline,
    ADR-0008). [drive_eth_header] takes an option so a bench writes [None] on
    every other cycle and the pulse's width is a property of the schedule
    rather than of a flag someone forgot to clear. The field values on a cycle
    where [valid] = 0 are unconstrained in the same way [tdata] is, so [None]
    drives zeros and a bench asserting on them would be asserting on its own
    stimulus. *)

open Hardcaml

(* Only [Bits.vdd], [Bits.gnd] and [Bits.concat_lsb] are used to construct, and
   nothing here reads a [Bits.t]. No integer constructor and no width argument
   appears, so there is no 63-bit intermediate for a 64-bit [tdata] to wrap
   through — the same reasoning `test/xgmii_probe/` records for the lane
   word. *)
let bit b = if b then Bits.vdd else Bits.gnd

let bits_of_int ~width value =
  Bits.concat_lsb (List.init width (fun i -> bit ((value lsr i) land 1 = 1)))
;;

(** Octet position [k] of [tdata] is bits [8k+7 : 8k] (SPEC-M01 §6.1), so the
    first octet received from the wire is at [k] = 0. [Stream_word.tdata] is
    already an eight-entry array in that order; positions beyond its length are
    driven as zero, which is a position [tkeep] cannot mark. *)
let tdata_bits (word : Dv_monitors.Stream_word.t) =
  Bits.concat_lsb
    (List.init 8 (fun k ->
       let octet = if k < Array.length word.Dv_monitors.Stream_word.tdata
                   then word.Dv_monitors.Stream_word.tdata.(k)
                   else 0
       in
       bits_of_int ~width:8 octet))
;;

(** Drive one stream word onto the six [Bits.t ref]s a bench already holds.
    Names no stream type, so it survives any change of [Axi64]'s home — the
    split [Axi64_probe.of_refs] makes on the sampling side. *)
let to_refs ~tvalid ~tdata ~tkeep ~tstrb ~tlast ~tuser (word : Dv_monitors.Stream_word.t)
  =
  tvalid := bit word.Dv_monitors.Stream_word.tvalid;
  tdata := tdata_bits word;
  tkeep := bits_of_int ~width:8 word.Dv_monitors.Stream_word.tkeep;
  tstrb := bits_of_int ~width:8 word.Dv_monitors.Stream_word.tstrb;
  tlast := bit word.Dv_monitors.Stream_word.tlast;
  tuser := bits_of_int ~width:1 word.Dv_monitors.Stream_word.tuser
;;

(** The sanctioned import made concrete: drive a whole [Axi64.Source] record. *)
let to_source (source : Bits.t ref Ifc_check.Axi64_ifc.Axi64.Source.t) word =
  let open Ifc_check.Axi64_ifc.Axi64.Source in
  to_refs
    ~tvalid:source.tvalid
    ~tdata:source.tdata
    ~tkeep:source.tkeep
    ~tstrb:source.tstrb
    ~tlast:source.tlast
    ~tuser:source.tuser
    word
;;

(** The Ethernet header record M06 emits and M08 routes (SPEC-M01 §4.1), as a
    plain value. Numeric, network byte order already decoded (REQ-012): a
    destination MAC 02:00:00:00:00:01 is [0x020000000001]. *)
type eth_header =
  { dst_mac : int
  ; src_mac : int
  ; ethertype : int
  }

(** [None] drives a cycle with [valid] = 0; [Some h] drives the one-cycle pulse
    (REQ-606, SPEC-M14 §6.1's "exactly one cycle before payload word 0"). *)
let to_eth_header_refs ~valid ~dst_mac ~src_mac ~ethertype header =
  match header with
  | None ->
    valid := Bits.gnd;
    dst_mac := bits_of_int ~width:48 0;
    src_mac := bits_of_int ~width:48 0;
    ethertype := bits_of_int ~width:16 0
  | Some h ->
    valid := Bits.vdd;
    dst_mac := bits_of_int ~width:48 h.dst_mac;
    src_mac := bits_of_int ~width:48 h.src_mac;
    ethertype := bits_of_int ~width:16 h.ethertype
;;

let to_eth_header (record : Bits.t ref Ifc_check.Axi64_ifc.Eth_header.t) header =
  let open Ifc_check.Axi64_ifc.Eth_header in
  to_eth_header_refs
    ~valid:record.valid
    ~dst_mac:record.dst_mac
    ~src_mac:record.src_mac
    ~ethertype:record.ethertype
    header
;;
