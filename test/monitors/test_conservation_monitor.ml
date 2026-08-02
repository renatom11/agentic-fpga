(* Unit tests for the requirements.md §0.6 frame-conservation monitor.

   ADR-0005 rule 2: every [%expect] block is left EMPTY on purpose, promoted
   from CI's own diff output. The judgement lives in OCaml: each case states
   the residual and cleanliness it expects, prints VERDICT ok or VERDICT WRONG,
   and raises on a wrong verdict. *)

let verdict monitor ~expect_residual ~expect_clean =
  print_string (Conservation_monitor.report monitor);
  print_newline ();
  let residual = Conservation_monitor.residual monitor in
  let clean = Conservation_monitor.is_clean monitor in
  if residual = expect_residual && Bool.equal clean expect_clean
  then print_endline "VERDICT ok"
  else (
    Printf.printf
      "VERDICT WRONG — expected residual %d clean %b, got residual %d clean %b\n"
      expect_residual
      expect_clean
      residual
      clean;
    failwith "conservation monitor verdict mismatch")
;;

let%expect_test "a run in which every frame is forwarded conserves" =
  let m = Conservation_monitor.create ~name:"balanced" in
  for _ = 1 to 10 do
    Conservation_monitor.frame_in m
  done;
  for _ = 1 to 9 do
    Conservation_monitor.frame_out m ~aborted:false
  done;
  (* REQ-007: a frame found invalid after forwarding began is forwarded with
     tuser[0] = 1 on its last word. §0.6 counts it as emitted. *)
  Conservation_monitor.frame_out m ~aborted:true;
  verdict m ~expect_residual:0 ~expect_clean:true;
  [%expect {| |}]
;;

let%expect_test "REQ-008: a frame that vanishes with no strobe is a silent discard" =
  let m = Conservation_monitor.create ~name:"silent" in
  for _ = 1 to 10 do
    Conservation_monitor.frame_in m
  done;
  for _ = 1 to 9 do
    Conservation_monitor.frame_out m ~aborted:false
  done;
  verdict m ~expect_residual:1 ~expect_clean:false;
  [%expect {| |}]
;;

let%expect_test "a discard accounted for by its strobe conserves" =
  let m = Conservation_monitor.create ~name:"accounted" in
  for _ = 1 to 10 do
    Conservation_monitor.frame_in m
  done;
  for _ = 1 to 9 do
    Conservation_monitor.frame_out m ~aborted:false
  done;
  Conservation_monitor.strobe_pulse m ~name:"error_bad_fcs";
  Conservation_monitor.discarded m ~strobes:[ "error_bad_fcs" ];
  verdict m ~expect_residual:0 ~expect_clean:true;
  [%expect {| |}]
;;

let%expect_test "C-2: two co-occurring strobes are two pulses but one discarded frame" =
  (* requirements.md §0.6 "Strobe multiplicity": if two or more locally
     detected conditions apply to one frame, each applicable condition's strobe
     pulses once for that frame. §0.6's conservation equation as written adds
     *strobe pulses*, so this frame would be counted twice and the run would
     report a surplus of one — a false failure on a conformant design. The
     monitor balances on discarded frames and keeps the pulse histogram
     separately; this test is what makes that difference visible, and it is the
     evidence behind carry-forward C-2. *)
  let m = Conservation_monitor.create ~name:"co-occurring" in
  for _ = 1 to 4 do
    Conservation_monitor.frame_in m
  done;
  for _ = 1 to 3 do
    Conservation_monitor.frame_out m ~aborted:false
  done;
  Conservation_monitor.strobe_pulse m ~name:"error_ip_bad_header";
  Conservation_monitor.strobe_pulse m ~name:"error_ip_bad_checksum";
  Conservation_monitor.discarded
    m
    ~strobes:[ "error_ip_bad_header"; "error_ip_bad_checksum" ];
  Printf.printf
    "pulses would give residual %d; frames give %d\n"
    (Conservation_monitor.frames_in m
     - (Conservation_monitor.frames_out m + Conservation_monitor.zero_payload m + 2))
    (Conservation_monitor.residual m);
  verdict m ~expect_residual:0 ~expect_clean:true;
  [%expect {| |}]
;;

let%expect_test "§0.7: a zero-payload frame is accounted for by its header valid pulse" =
  (* A 14-octet Ethernet frame, an IPv4 datagram of total length 20, a UDP
     datagram of length 8: each leaves zero payload octets, which REQ-011
     cannot encode, so the stage emits no payload frame and the header
     record's valid pulse is the frame's only report. Carry-forward C-3 is
     about doing this arithmetic at the top level. *)
  let m = Conservation_monitor.create ~name:"zero-payload" in
  for _ = 1 to 3 do
    Conservation_monitor.frame_in m
  done;
  Conservation_monitor.frame_out m ~aborted:false;
  Conservation_monitor.frame_out m ~aborted:false;
  Conservation_monitor.zero_payload_header m;
  verdict m ~expect_residual:0 ~expect_clean:true;
  [%expect {| |}]
;;

let%expect_test "a discard with no strobe, and a strobe requirements.md §12 does not define" =
  let m = Conservation_monitor.create ~name:"malformed" in
  Conservation_monitor.frame_in m;
  Conservation_monitor.frame_in m;
  Conservation_monitor.discarded m ~strobes:[];
  Conservation_monitor.discarded m ~strobes:[ "error_frame_was_bad" ];
  Conservation_monitor.strobe_pulse m ~name:"error_frame_was_bad";
  (* The equation balances — and the run is still not clean, because a discard
     the specification cannot name is not an accounted discard. *)
  verdict m ~expect_residual:0 ~expect_clean:false;
  [%expect {| |}]
;;

let%expect_test "REQ-009 and REQ-810: frames never accepted are outside the equation" =
  (* REQ-810 says in terms: when receive enable is 0 no frame is accepted, "so
     this creates no silent-discard hole under REQ-008". Counting those 100
     frames as presented would make every enable and reset test report a false
     silent discard, which is carry-forward C-2's second half. *)
  let m = Conservation_monitor.create ~name:"exempt" in
  for _ = 1 to 100 do
    Conservation_monitor.frame_in_exempt m ~reason:"cfg_rx_enable = 0 (REQ-810)"
  done;
  Conservation_monitor.frame_in_exempt m ~reason:"clear asserted (REQ-009)";
  Conservation_monitor.frame_in m;
  Conservation_monitor.frame_out m ~aborted:false;
  Printf.printf
    "exempt=%d, and they are not in frames_in (%d)\n"
    (Conservation_monitor.frames_exempt m)
    (Conservation_monitor.frames_in m);
  verdict m ~expect_residual:0 ~expect_clean:true;
  [%expect {| |}]
;;

let%expect_test "the strobe list matches requirements.md §12's count" =
  (* The names themselves are compared against §12 character for character by
     tools/check_records_vs_appendix.sh; this only guards the count so an
     accidental deletion inside the library fails a test as well as a script. *)
  Printf.printf "Strobes.count = %d\n" Strobes.count;
  Printf.printf "error_bad_fcs known: %b\n" (Strobes.mem "error_bad_fcs");
  Printf.printf "error_bad_fcs_ known: %b\n" (Strobes.mem "error_bad_fcs_");
  if Strobes.count <> 21 then failwith "requirements.md §12 defines twenty-one strobes";
  [%expect {| |}]
;;
