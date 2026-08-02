(* Unit tests for the XGMII probe (WO-0033 X-2).

   What these can and cannot establish. There is no M03 to attach to at this
   SHA, so nothing here judges a design: they exercise the probe against the
   link-partner model on hand-built [Bits.t ref]s, which is exactly the level
   at which a packing error is findable. The property that matters is that
   [to_refs] and [of_refs] are inverse on every word the model can emit — a
   probe that drove lane 7 into bits [7:0] and read it back from the same place
   would pass a self-consistency check and fail against RTL, so the driven
   [Bits.t] is also inspected {e positionally} against REQ-012's convention
   rather than only round-tripped.

   ADR-0005 rule 2: [%expect] blocks are left EMPTY and are promoted from CI's
   own diff output. Every verdict below is asserted in OCaml, so a promotion
   that captured wrong output would still leave a red test. *)

open Hardcaml
module W = Dv_xgmii.Xgmii_word

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
    failwith "xgmii probe verdict mismatch")
;;

(* Every word the link partner can emit, in one list: an idle word, a lane-0
   start word as SPEC-M03 §6.1's cycle table writes it, a lane-4 start word,
   a pure data word with lane 7 at 0xFF (the value that does not fit an OCaml
   int at bit 63 once packed, which is why the probe never builds an Int64),
   a terminate word, an error word and an ordered set. *)
let words =
  let preamble d = if d = 7 then 0xD5 else 0x55 in
  [ "idle", W.idle
  ; ( "lane-0 start"
    , W.of_lanes
        (W.Control W.start_char :: List.init 7 (fun i -> W.Data (preamble (i + 1)))) )
  ; ( "lane-4 start"
    , W.of_lanes
        (List.init 4 (fun i -> W.Data (0xA0 + i))
         @ [ W.Control W.start_char ]
         @ List.init 3 (fun i -> W.Data (preamble (i + 1)))) )
  ; "data, lane 7 = 0xFF", W.of_data [ 0x00; 0x11; 0x22; 0x33; 0x44; 0x55; 0x66; 0xFF ]
  ; ( "terminate in lane 3"
    , W.of_lanes
        (List.init 3 (fun i -> W.Data (0x10 + i))
         @ [ W.Control W.terminate_char ]
         @ List.init 4 (fun _ -> W.Control W.idle_char)) )
  ; ( "error in lane 6"
    , W.of_lanes
        (List.init 6 (fun i -> W.Data (0x20 + i))
         @ [ W.Control W.error_char; W.Data 0x99 ]) )
  ; ( "ordered set in lane 0"
    , W.of_lanes (W.Control W.sequence_char :: List.init 7 (fun i -> W.Data (0x30 + i)))
    )
  ]
;;

let%expect_test "X-2: drive and sample are inverse on every model word" =
  let d = ref (Bits.concat_lsb (List.init 64 (fun _ -> Bits.gnd))) in
  let c = ref (Bits.concat_lsb (List.init 8 (fun _ -> Bits.gnd))) in
  List.iter
    (fun (name, word) ->
      Xgmii_probe.to_refs ~d ~c word;
      let back = Xgmii_probe.of_refs ~d ~c () in
      check ~what:(Printf.sprintf "round trip: %s" name) (W.equal word back);
      check
        ~what:(Printf.sprintf "widths: %s" name)
        (Bits.width !d = 64 && Bits.width !c = 8))
    words;
  verdict ();
  [%expect {| |}]
;;

let%expect_test "X-2: REQ-012 puts lane k at bits [8k+7 : 8k], checked positionally" =
  (* A round trip cannot catch a convention that is wrong in the same way in
     both directions. This case reads the driven [Bits.t] by absolute bit
     range and compares against the lane the model put there. *)
  let d = ref (Bits.concat_lsb (List.init 64 (fun _ -> Bits.gnd))) in
  let c = ref (Bits.concat_lsb (List.init 8 (fun _ -> Bits.gnd))) in
  let word = W.of_lanes (W.Control W.start_char :: List.init 7 (fun i -> W.Data (i + 1))) in
  Xgmii_probe.to_refs ~d ~c word;
  check
    ~what:"lane 0 is bits [7:0] and carries /S/"
    (Bits.to_int (Bits.select !d 7 0) = W.start_char);
  check ~what:"lane 3 is bits [31:24]" (Bits.to_int (Bits.select !d 31 24) = 3);
  check ~what:"lane 7 is bits [63:56]" (Bits.to_int (Bits.select !d 63 56) = 7);
  check ~what:"control bit 0 marks lane 0" (Bits.to_int !c = 0b0000_0001);
  (* and the far lane at a value above 0x7F, which is where an Int64 detour
     would have wrapped *)
  let high = W.of_data [ 0; 0; 0; 0; 0; 0; 0; 0xFF ] in
  Xgmii_probe.to_refs ~d ~c high;
  check ~what:"lane 7 = 0xFF survives packing" (Bits.to_int (Bits.select !d 63 56) = 0xFF);
  check ~what:"no control bit set on a data word" (Bits.to_int !c = 0);
  verdict ();
  [%expect {| |}]
;;

let%expect_test "X-2: a whole schedule cycle walks through the probe unchanged" =
  (* The link partner's own §8 stress schedule, driven word by word and read
     back — the shape an M03 bench's cycle loop has, minus the design. *)
  let schedule = Dv_xgmii.Arrival.stress ~count:3 () in
  check ~what:"schedule is contract-clean" (Dv_xgmii.Arrival.is_clean schedule);
  let d = ref (Bits.concat_lsb (List.init 64 (fun _ -> Bits.gnd))) in
  let c = ref (Bits.concat_lsb (List.init 8 (fun _ -> Bits.gnd))) in
  let mismatches = ref 0 in
  for cycle = 0 to Dv_xgmii.Arrival.cycles schedule - 1 do
    let word = Dv_xgmii.Arrival.word_at schedule ~cycle in
    Xgmii_probe.to_refs ~d ~c word;
    if not (W.equal word (Xgmii_probe.of_refs ~d ~c ())) then incr mismatches
  done;
  check ~what:"every cycle of a 3-frame schedule survives the seam" (!mismatches = 0);
  verdict ();
  [%expect {| |}]
;;
