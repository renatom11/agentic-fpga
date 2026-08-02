(* Unit tests for the Axi64 stream driver (WO-0033 X-6).

   The property worth testing without a design present is that the driver and
   the sampler that already lives beside it are inverse on every word SPEC-M01
   §6.1 can encode — and, because a round trip cannot catch a convention that
   is wrong in the same way in both directions, that [tdata] position k really
   lands at bits [8k+7 : 8k] when read by absolute bit range.

   ADR-0005 rule 2: [%expect] blocks are EMPTY and are promoted from CI's own
   diff output; every verdict is asserted in OCaml, so a promotion that
   captured wrong output would still leave a red test. *)

open Hardcaml
module S = Dv_monitors.Stream_word

let failures = ref 0

let check ~what cond =
  if cond
  then Printf.printf "%s: ok\n" what
  else (
    Printf.printf "%s: FAILED\n" what;
    incr failures)
;;

let verdict () =
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    failures := 0;
    failwith "axi64 driver verdict mismatch")
;;

let refs () =
  let z n = Bits.concat_lsb (List.init n (fun _ -> Bits.gnd)) in
  ( ref (z 1)
  , ref (z 64)
  , ref (z 8)
  , ref (z 8)
  , ref (z 1)
  , ref (z 1) )
;;

(* SPEC-M01 §6.1's whole encoding, word by word: a full word, every partial
   [tkeep] a REQ-011 contiguous run admits, the abort marking of REQ-013, and
   the two idle forms §6.3 item 5 leaves unconstrained. *)
let words =
  let full = S.of_octets [ 0x00; 0x11; 0x22; 0x33; 0x44; 0x55; 0x66; 0xFF ] in
  let partials =
    List.init 7 (fun i -> S.of_octets ~tlast:true (List.init (i + 1) (fun k -> 0xA0 + k)))
  in
  [ "full word", full
  ; "full tlast, aborted", S.of_octets ~tlast:true ~tuser:1 [ 1; 2; 3; 4; 5; 6; 7; 8 ]
  ; "idle", S.idle ()
  ; "garbage idle (§6.3 item 5)", S.garbage_idle ()
  ]
  @ List.mapi (fun i w -> Printf.sprintf "tlast, %d octet(s)" (i + 1), w) partials
;;

let%expect_test "X-6: drive and sample are inverse on every SPEC-M01 §6.1 word" =
  let tvalid, tdata, tkeep, tstrb, tlast, tuser = refs () in
  List.iter
    (fun (name, word) ->
      Axi64_driver.to_refs ~tvalid ~tdata ~tkeep ~tstrb ~tlast ~tuser word;
      let back = Axi64_probe.of_refs ~tvalid ~tdata ~tkeep ~tstrb ~tlast ~tuser () in
      (* [Stream_word] has no [equal]; the comparison is over the fields a
         monitor is allowed to read (§6.3 item 5), which is the same set the
         sampler is allowed to produce. On a [tvalid] = 0 word only [tvalid]
         itself is constrained, and the driver is asked to carry the rest
         verbatim so a bench can drive garbage deliberately. *)
      let same =
        back.S.tvalid = word.S.tvalid
        && back.S.tkeep = word.S.tkeep
        && back.S.tstrb = word.S.tstrb
        && back.S.tlast = word.S.tlast
        && back.S.tuser = word.S.tuser
        && back.S.tdata = word.S.tdata
      in
      check ~what:(Printf.sprintf "round trip: %s" name) same;
      check
        ~what:(Printf.sprintf "widths: %s" name)
        (Bits.width !tdata = 64 && Bits.width !tkeep = 8 && Bits.width !tuser = 1))
    words;
  verdict ();
  [%expect {|
    round trip: full word: ok
    widths: full word: ok
    round trip: full tlast, aborted: ok
    widths: full tlast, aborted: ok
    round trip: idle: ok
    widths: idle: ok
    round trip: garbage idle (§6.3 item 5): ok
    widths: garbage idle (§6.3 item 5): ok
    round trip: tlast, 1 octet(s): ok
    widths: tlast, 1 octet(s): ok
    round trip: tlast, 2 octet(s): ok
    widths: tlast, 2 octet(s): ok
    round trip: tlast, 3 octet(s): ok
    widths: tlast, 3 octet(s): ok
    round trip: tlast, 4 octet(s): ok
    widths: tlast, 4 octet(s): ok
    round trip: tlast, 5 octet(s): ok
    widths: tlast, 5 octet(s): ok
    round trip: tlast, 6 octet(s): ok
    widths: tlast, 6 octet(s): ok
    round trip: tlast, 7 octet(s): ok
    widths: tlast, 7 octet(s): ok
    VERDICT ok
    |}]
;;

let%expect_test "X-6: SPEC-M01 §6.1 puts octet position k at tdata[8k+7 : 8k]" =
  let tvalid, tdata, tkeep, tstrb, tlast, tuser = refs () in
  let word = S.of_octets ~tlast:true [ 0x01; 0x02; 0x03; 0x04; 0x05; 0x06; 0x07; 0xFF ] in
  Axi64_driver.to_refs ~tvalid ~tdata ~tkeep ~tstrb ~tlast ~tuser word;
  check ~what:"position 0 is bits [7:0]" (Bits.to_int (Bits.select !tdata 7 0) = 0x01);
  check ~what:"position 3 is bits [31:24]" (Bits.to_int (Bits.select !tdata 31 24) = 0x04);
  check
    ~what:"position 7 = 0xFF is bits [63:56]"
    (Bits.to_int (Bits.select !tdata 63 56) = 0xFF);
  check ~what:"tkeep is a full word" (Bits.to_int !tkeep = 0xFF);
  check ~what:"tvalid and tlast are 1" (Bits.to_int !tvalid = 1 && Bits.to_int !tlast = 1);
  check ~what:"REQ-014: tstrb driven 0" (Bits.to_int !tstrb = 0);
  verdict ();
  [%expect {|
    position 0 is bits [7:0]: ok
    position 3 is bits [31:24]: ok
    position 7 = 0xFF is bits [63:56]: ok
    tkeep is a full word: ok
    tvalid and tlast are 1: ok
    REQ-014: tstrb driven 0: ok
    VERDICT ok
    |}]
;;

let%expect_test "X-6: the header record is a one-cycle pulse, never a level" =
  (* REQ-606 and SPEC-M14 §6.1: one pulse, one cycle before payload word 0.
     Driving [None] on the surrounding cycles is what makes the pulse's width a
     property of the schedule (ADR-0008 is the transmit-side level discipline
     and is not this port's). *)
  let valid = ref Bits.gnd in
  let z n = Bits.concat_lsb (List.init n (fun _ -> Bits.gnd)) in
  let dst_mac = ref (z 48) and src_mac = ref (z 48) and ethertype = ref (z 16) in
  let drive h = Axi64_driver.to_eth_header_refs ~valid ~dst_mac ~src_mac ~ethertype h in
  let header =
    { Axi64_driver.dst_mac = 0x020000000001
    ; src_mac = 0x020000000002
    ; ethertype = 0x0800
    }
  in
  drive None;
  check ~what:"before the pulse: valid = 0" (Bits.to_int !valid = 0);
  drive (Some header);
  check ~what:"on the pulse: valid = 1" (Bits.to_int !valid = 1);
  check
    ~what:"REQ-012: dst_mac 02:00:00:00:00:01 reads 0x020000000001"
    (Bits.to_int !dst_mac = 0x020000000001);
  check ~what:"ethertype 0x0800" (Bits.to_int !ethertype = 0x0800);
  drive None;
  check ~what:"after the pulse: valid = 0" (Bits.to_int !valid = 0);
  verdict ();
  [%expect {|
    before the pulse: valid = 0: ok
    on the pulse: valid = 1: ok
    REQ-012: dst_mac 02:00:00:00:00:01 reads 0x020000000001: ok
    ethertype 0x0800: ok
    after the pulse: valid = 0: ok
    VERDICT ok
    |}]
;;
