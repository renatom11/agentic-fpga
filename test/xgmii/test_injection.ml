(* Unit tests for the error-injection catalogue and its §9 outcome model
   (WO-0033 X-1).

   These are the model-versus-catalogue checks WO-0033 deliverable 2 asks for:
   every expected number below is transcribed from `AP-xgmii_rx_64.md`'s
   committed rows or from SPEC-M03 §9 itself, both derived BEFORE this model
   existed and by the other route (§6.1's m + 3 and §9's nine-row table). Two
   independent derivations agreeing is not the charter's external anchor — that
   is the verilog-ethernet differential co-sim, and injection.mli says so — but
   it is what makes the model fit to build benches with.

   ADR-0005 rule 2: [%expect] blocks are EMPTY and promoted from CI's own diff
   output; every verdict is asserted in OCaml. *)

let failures = ref 0

let check ~what cond =
  if cond
  then Printf.printf "%s: ok\n" what
  else (
    Printf.printf "%s: FAILED\n" what;
    incr failures)
;;

let verdict t =
  print_string (Injection.report t);
  print_newline ();
  if !failures = 0
  then print_endline "VERDICT ok"
  else (
    failures := 0;
    failwith "injection model verdict mismatch")
;;

let strobes (o : Injection.outcome) =
  List.map (fun (r : Injection.report) -> r.Injection.strobe, r.Injection.cycle) o.Injection.reports
;;

(* Every case starts frame 0 at octet time 8, i.e. lane 0 of cycle 1, so the
   arithmetic below can be read against SPEC-M03 §6.1's cycle table directly. *)
let one case = Injection.create [ case ]

let%expect_test "X-1: a clean frame reports nothing (the anti-vacuity baseline)" =
  let t = one (Injection.clean (Injection.frame_of_length 64)) in
  check ~what:"construction clean" (Injection.is_clean t);
  let os = Injection.outcomes t in
  check ~what:"one frame opened" (List.length os = 1);
  (match os with
   | [ o ] ->
     check ~what:"start cycle 1, lane 0" (o.Injection.start_cycle = 1 && o.Injection.start_lane = 0);
     check ~what:"64 received, 60 delivered (REQ-103)" (o.Injection.received = 64 && o.Injection.delivered = 60);
     check ~what:"8 words, tkeep 0x0F on tlast" (o.Injection.words = 8 && o.Injection.last_tkeep = 0x0F);
     check ~what:"§6.1's cycle table: tlast on cycle 1+3+7 = 11" (o.Injection.tlast_cycle = Some 11);
     check ~what:"no strobe, no abort" (o.Injection.reports = [] && not o.Injection.abort)
   | _ -> ());
  verdict t;
  [%expect {| |}]
;;

let%expect_test "X-1: REQ-104 — one flipped payload bit fails the REQ-304 residue" =
  (* Rows D1 and D3. §9 row 1: the frame is forwarded IN FULL and tuser[0] = 1
     on tlast; the FCS is still removed, because the frame ended with /T/. *)
  let t =
    one (Injection.corrupt (Injection.frame_of_length 64) [ Injection.Flip_bit { octet = 20; bit = 3 } ])
  in
  check ~what:"construction clean" (Injection.is_clean t);
  (match Injection.outcomes t with
   | [ o ] ->
     check ~what:"forwarded in full: 60 delivered" (o.Injection.delivered = 60);
     check ~what:"tuser[0] = 1" o.Injection.abort;
     check ~what:"one error_bad_fcs on the tlast cycle" (strobes o = [ "error_bad_fcs", 11 ])
   | _ -> check ~what:"exactly one frame opened" false);
  verdict t;
  [%expect {| |}]
;;

let%expect_test "X-1: REQ-105 — /E/ with and without a delivered octet" =
  (* §9 rows 2 and 3, AP rows E1 and E2. With ≥ 1 octet: truncated at the octet
     before the error character, NO FCS removed, so 20 octets received give 20
     delivered — the identity the WO-0033 X-5 tagger repair exists for. With
     none: no output word at all, and the strobe two cycles after the closing
     word (§9's second pinning rule, NOT m + 3 — M03-R2). *)
  let with_octets =
    one
      (Injection.corrupt
         (Injection.frame_of_length 64)
         [ Injection.Place { placement = Injection.At_octet 20; character = Xgmii_word.error_char } ])
  in
  (match Injection.outcomes with_octets with
   | [ o ] ->
     check ~what:"20 received, 20 delivered — no FCS removed" (o.Injection.received = 20 && o.Injection.delivered = 20);
     check ~what:"3 words, tkeep 0x0F" (o.Injection.words = 3 && o.Injection.last_tkeep = 0x0F);
     check ~what:"tlast on cycle 6" (o.Injection.tlast_cycle = Some 6);
     check ~what:"error_bad_frame at the tlast cycle" (strobes o = [ "error_bad_frame", 6 ]);
     check ~what:"aborted" o.Injection.abort
   | _ -> check ~what:"E1: exactly one frame opened" false);
  let at_first =
    one
      (Injection.corrupt
         (Injection.frame_of_length 64)
         [ Injection.Place { placement = Injection.At_octet 0; character = Xgmii_word.error_char } ])
  in
  (match Injection.outcomes at_first with
   | [ o ] ->
     check ~what:"no output word at all (§0.7)" (o.Injection.delivered = 0 && o.Injection.tlast_cycle = None);
     check ~what:"no tkeep and no abort bit to carry" (o.Injection.last_tkeep = 0 && not o.Injection.abort);
     check
       ~what:"error_bad_frame two cycles after the closing word (cycle 2 + 2)"
       (strobes o = [ "error_bad_frame", 4 ])
   | _ -> check ~what:"E2: exactly one frame opened" false);
  verdict at_first;
  [%expect {| |}]
;;

let%expect_test "X-1: REQ-107 — the runt band and the sub-five-octet frame" =
  (* Rows F1 and F2. 63 octets: forwarded, 59 delivered, error_runt alone
     because the FCS is correct (§9's first co-occurrence ruling). 4 octets:
     no output word at all, §9 row 6. *)
  let runt = one (Injection.clean (Injection.frame_of_length 63)) in
  (match Injection.outcomes runt with
   | [ o ] ->
     check ~what:"63 received, 59 delivered" (o.Injection.received = 63 && o.Injection.delivered = 59);
     check ~what:"8 words, tkeep 0x07" (o.Injection.words = 8 && o.Injection.last_tkeep = 0x07);
     check ~what:"error_runt alone — the FCS is correct" (strobes o = [ "error_runt", 11 ]);
     check ~what:"aborted" o.Injection.abort
   | _ -> check ~what:"F1: exactly one frame opened" false);
  let tiny = one (Injection.clean (Injection.frame_of_length 4)) in
  check
    ~what:"a sub-five-octet frame is an injection case, not a schedule error"
    (Injection.is_clean tiny);
  (match Injection.outcomes tiny with
   | [ o ] ->
     check ~what:"4 received, nothing delivered" (o.Injection.received = 4 && o.Injection.delivered = 0);
     check ~what:"error_runt two cycles after the terminate word" (strobes o = [ "error_runt", 4 ])
   | _ -> check ~what:"F2: exactly one frame opened" false);
  verdict tiny;
  [%expect {| |}]
;;

let%expect_test "X-1: REQ-108 — truncation to exactly 1514 delivered octets" =
  (* Row G1. §9 row 7 and its co-occurrence rulings: error_oversize alone, and
     never with error_bad_fcs — no FCS is present at the truncation point. *)
  let t = one (Injection.clean (Injection.frame_of_length 1600)) in
  check ~what:"construction clean" (Injection.is_clean t);
  (match Injection.outcomes t with
   | [ o ] ->
     check ~what:"exactly 1514 delivered" (o.Injection.delivered = 1514);
     check ~what:"190 words, tkeep 0x03" (o.Injection.words = 190 && o.Injection.last_tkeep = 0x03);
     check ~what:"tlast on cycle 1+3+189 = 193" (o.Injection.tlast_cycle = Some 193);
     check ~what:"error_oversize alone" (strobes o = [ "error_oversize", 193 ])
   | _ -> check ~what:"exactly one frame opened" false);
  verdict t;
  [%expect {| |}]
;;

let%expect_test "X-1: REQ-102 — a control character in a preamble position" =
  (* Rows B2, B3 and B4. SPEC-M03 §6.1's third sentence routes each one:
     /T/ to REQ-107, /S/ to REQ-110, anything else to REQ-105 — all with zero
     delivered octets and no output word. *)
  let at position character =
    one
      (Injection.corrupt
         (Injection.frame_of_length 64)
         [ Injection.Place { placement = Injection.At_preamble position; character } ])
  in
  let terminate = at 3 Xgmii_word.terminate_char in
  (match Injection.outcomes terminate with
   | [ o ] ->
     check ~what:"B3: /T/ in a preamble position is REQ-107" (strobes o = [ "error_runt", 3 ]);
     check ~what:"and delivers nothing" (o.Injection.delivered = 0)
   | _ -> check ~what:"B3: exactly one frame opened" false);
  let err = at 3 Xgmii_word.error_char in
  (match Injection.outcomes err with
   | [ o ] -> check ~what:"B2: /E/ in a preamble position is REQ-105" (strobes o = [ "error_bad_frame", 3 ])
   | _ -> check ~what:"B2: exactly one frame opened" false);
  let idle = at 3 Xgmii_word.idle_char in
  (match Injection.outcomes idle with
   | [ o ] ->
     check
       ~what:"M03-N3: an /I/ in a preamble position is 'any other control character' \
              and is REQ-105 too"
       (strobes o = [ "error_bad_frame", 3 ])
   | _ -> check ~what:"N3: exactly one frame opened" false);
  (* B4: a /S/ must land in lane 0 or lane 4. Frame 0 starts at octet time 8,
     so preamble position 4 is lane 4 — legal; position 3 is lane 3 and the
     catalogue refuses it, because §6.3 item 3 leaves that stimulus
     unconstrained BECAUSE the link partner never produces it. *)
  let start_legal = at 4 Xgmii_word.start_char in
  check ~what:"B4: a /S/ at a lane-4 preamble position is buildable" (Injection.is_clean start_legal);
  (match Injection.outcomes start_legal with
   | first :: _ ->
     check
       ~what:"and aborts with error_start_without_terminate, nothing delivered"
       (strobes first = [ "error_start_without_terminate", 3 ] && first.Injection.delivered = 0)
   | [] -> check ~what:"B4: at least one frame opened" false);
  let start_illegal = at 3 Xgmii_word.start_char in
  check
    ~what:"a /S/ outside lanes 0 and 4 is REFUSED, not modelled"
    (not (Injection.is_clean start_illegal));
  verdict terminate;
  [%expect {| |}]
;;

let%expect_test "X-1: §6.1's consequence-1 minimal witness, cycles and all" =
  (* SPEC-M03 §6.1, quoted: "/S/ in lane 0 of word W - 1; word W carries that
     frame's octets 0 … 3 in lanes 0 … 3, a /S/ in lane 4 and a /T/ in lane 6.
     The first frame delivers FOUR octets, so its tlast word (tkeep = 0x0F,
     tuser[0] = 1) is its output word 0 and leaves on W + 2 … while the second
     frame delivers none and its error_runt is on W + 2 too."

     Frame 0 starts at octet time 8, so W - 1 = 1 and W = 2, and both reports
     are owed on cycle 4. This is the row a bench is likeliest to get wrong,
     it is the row dv_lead's own prose got wrong at WO-0030 (M03-N2, corrected
     at WO-0031), and it is the single strongest check available on this model
     because the specification states the answer. *)
  let t =
    one
      (Injection.corrupt
         (Injection.frame_of_length 64)
         [ Injection.Place { placement = Injection.At_octet 4; character = Xgmii_word.start_char }
         ; Injection.Place { placement = Injection.At_octet 6; character = Xgmii_word.terminate_char }
         ])
  in
  check ~what:"construction clean" (Injection.is_clean t);
  (match Injection.outcomes t with
   | [ a; b ] ->
     check ~what:"two frames opened by one word pair" true;
     check
       ~what:"aborted frame: 4 received, 4 delivered, one word, tkeep 0x0F, aborted"
       (a.Injection.received = 4
        && a.Injection.delivered = 4
        && a.Injection.words = 1
        && a.Injection.last_tkeep = 0x0F
        && a.Injection.abort);
     check ~what:"its tlast leaves on W + 2 = 4" (a.Injection.tlast_cycle = Some 4);
     check
       ~what:"and its report is error_start_without_terminate at W + 2"
       (strobes a = [ "error_start_without_terminate", 4 ]);
     check
       ~what:"new frame: opened at lane 4 of W, delivers nothing"
       (b.Injection.start_cycle = 2 && b.Injection.start_lane = 4 && b.Injection.delivered = 0);
     check ~what:"and its error_runt is on W + 2 = 4 as well" (strobes b = [ "error_runt", 4 ]);
     check
       ~what:"the two reports coincide and carry DIFFERENT names (§6.3 item 8 has no \
              instance here)"
       true
   | os ->
     Printf.printf "expected two outcomes, got %d\n" (List.length os);
     check ~what:"exactly two frames opened" false);
  (* and the join to X-3: the events the strobe monitor consumes, with §0.6's
     window computed around each pin. *)
  let events = Injection.expected_strobes t in
  check ~what:"two events handed to the strobe monitor" (List.length events = 2);
  check
    ~what:"every pin lies inside its own §0.6 window"
    (List.for_all
       (fun (e : Dv_monitors.Strobe_monitor.event) ->
         e.Dv_monitors.Strobe_monitor.cycle >= e.Dv_monitors.Strobe_monitor.not_before
         && e.Dv_monitors.Strobe_monitor.cycle <= e.Dv_monitors.Strobe_monitor.not_after)
       events);
  verdict t;
  [%expect {| |}]
;;
