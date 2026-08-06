(* See canonical.mli for the contract. Plain stdlib OCaml throughout — no
   Base, no Hardcaml: this module is text-processing over WO-0046 §2.3's
   grammar and REQ-901's comparison, shared verbatim between [ours_run.ml]
   (which writes), [compare.ml] (which reads and compares), and
   [tb_xgmii_rx_64.v] (an independent Verilog producer of the same grammar,
   which this module can read but obviously does not write). *)

type word =
  { tkeep : int
  ; tlast : bool
  ; tuser0 : bool
  ; cycle : int
  ; octets : int list
  }

type decision =
  | Accept
  | Discard

type frame =
  { index : int
  ; admit_cycle : int
  ; words : word list
  ; decision : decision
  }

type transaction = frame list

let popcount n =
  let rec go n acc = if n = 0 then acc else go (n lsr 1) (acc + (n land 1)) in
  go n 0
;;

let decision_to_string = function
  | Accept -> "accept"
  | Discard -> "discard"
;;

(* ------------------------------------------------------------------ *)
(* Writer                                                              *)
(* ------------------------------------------------------------------ *)

let write oc (t : transaction) =
  List.iter
    (fun (frame : frame) ->
       (* WO-0075 §2: [admit_cycle] and [cycle] are decimal ([%d]), never hex
          — [%d] on a non-negative OCaml [int] is already unpadded with no
          leading zero beyond the digit [0] itself, so no separate
          zero-stripping step is needed to meet the grammar's own rule. *)
       Printf.fprintf oc "F %d %d\n" frame.index frame.admit_cycle;
       List.iter
         (fun (w : word) ->
            let expected = popcount w.tkeep in
            if List.length w.octets <> expected
            then
              failwith
                (Printf.sprintf
                   "Canonical.write: frame %d: tkeep 0x%02x expects %d octet(s), got %d"
                   frame.index
                   w.tkeep
                   expected
                   (List.length w.octets));
            Printf.fprintf
              oc
              "W %02x %d %d %d"
              w.tkeep
              (if w.tlast then 1 else 0)
              (if w.tuser0 then 1 else 0)
              w.cycle;
            List.iter (fun o -> Printf.fprintf oc " %02x" o) w.octets;
            Printf.fprintf oc "\n")
         frame.words;
       Printf.fprintf oc "D %d %s\n" frame.index (decision_to_string frame.decision))
    t
;;

let write_file path t =
  let oc = open_out_bin path in
  Fun.protect ~finally:(fun () -> close_out_noerr oc) (fun () -> write oc t)
;;

(* ------------------------------------------------------------------ *)
(* Parser                                                              *)
(* ------------------------------------------------------------------ *)

let split_ws line =
  String.split_on_char ' ' line |> List.filter (fun s -> String.length s > 0)
;;

let parse_error ~line_no ~line msg =
  failwith (Printf.sprintf "Canonical.read: line %d: %s (line was %S)" line_no msg line)
;;

let parse_hex2 ~line_no ~line what s =
  if String.length s <> 2
  then parse_error ~line_no ~line (Printf.sprintf "%s must be exactly 2 hex digits" what);
  try int_of_string ("0x" ^ s) with
  | _ -> parse_error ~line_no ~line (Printf.sprintf "%s is not valid hex" what)
;;

let parse_bit ~line_no ~line what s =
  match s with
  | "0" -> false
  | "1" -> true
  | _ -> parse_error ~line_no ~line (Printf.sprintf "%s must be 0 or 1" what)
;;

let parse_int ~line_no ~line what s =
  try int_of_string s with
  | _ -> parse_error ~line_no ~line (Printf.sprintf "%s is not a valid integer" what)
;;

(* WO-0075 §2: [admit_cycle] and [cycle] are the grammar's one deliberate
   decimal field, chosen exactly so an old (pre-WO-0075) producer's file
   fails here rather than being silently misread. Stricter than plain
   [int_of_string]: every character SHALL be a decimal digit (no leading
   [-], no [0x], nothing an old HEX octet token like "0f" or "a3" could ever
   be), and a value of two or more digits SHALL NOT begin with ['0'] (the
   "no leading zeros beyond the digit 0 itself" clause) -- which additionally
   rejects an old HEX octet token that happens to consist only of decimal
   digits with a leading zero, such as "07" or "00". A token this net does
   not catch (an old octet like "42" or "99": two decimal digits, no leading
   zero) still cannot produce a false green: it is consumed as this field,
   leaving the W line's remaining octet-token count one short of its
   [tkeep]'s popcount, which [word_of_tokens]'s existing count check below
   catches as the second net (canonical.mli's own commentary on this). *)
let parse_decimal ~line_no ~line what s =
  let is_digit c = c >= '0' && c <= '9' in
  let all_digits = String.length s > 0 && String.for_all is_digit s in
  if not all_digits
  then
    parse_error
      ~line_no
      ~line
      (Printf.sprintf "%s must be a decimal, unpadded, non-negative integer" what);
  if String.length s > 1 && s.[0] = '0'
  then parse_error ~line_no ~line (Printf.sprintf "%s must not carry a leading zero" what);
  int_of_string s
;;

let word_of_tokens ~line_no ~line tokens =
  match tokens with
  | tkeep_s :: tlast_s :: tuser_s :: cycle_s :: octet_toks ->
    let tkeep = parse_hex2 ~line_no ~line "tkeep" tkeep_s in
    let tlast = parse_bit ~line_no ~line "tlast" tlast_s in
    let tuser0 = parse_bit ~line_no ~line "tuser0" tuser_s in
    let cycle = parse_decimal ~line_no ~line "cycle" cycle_s in
    let octets = List.map (parse_hex2 ~line_no ~line "an octet") octet_toks in
    let expected = popcount tkeep in
    if List.length octets <> expected
    then
      parse_error
        ~line_no
        ~line
        (Printf.sprintf
           "tkeep 0x%02x expects %d octet(s), got %d"
           tkeep
           expected
           (List.length octets));
    { tkeep; tlast; tuser0; cycle; octets }
  | _ ->
    parse_error
      ~line_no
      ~line
      "a W line needs at least tkeep, tlast, tuser0 and cycle (an old-format \
       file predating WO-0075's grammar amendment has no cycle field and is \
       rejected here rather than misread)"
;;

type parse_state =
  | No_frame_open
  | Frame_open of
      { index : int
      ; admit_cycle : int
      ; words_rev : word list
      }

let read ic =
  let rec loop line_no state frames_rev =
    match input_line ic with
    | line ->
      let tokens = split_ws line in
      (match tokens, state with
       | [], _ -> parse_error ~line_no ~line "blank line not permitted"
       | [ "F"; idx_s; admit_s ], No_frame_open ->
         let index = parse_int ~line_no ~line "frame-index" idx_s in
         let admit_cycle = parse_decimal ~line_no ~line "admit-cycle" admit_s in
         loop (line_no + 1) (Frame_open { index; admit_cycle; words_rev = [] }) frames_rev
       | [ "F"; _ ], No_frame_open ->
         parse_error
           ~line_no
           ~line
           "F line is missing its admit-cycle token (an old-format file predating \
            WO-0075's grammar amendment carries only a frame-index here and is \
            rejected rather than misread)"
       | "F" :: _, Frame_open { index; _ } ->
         parse_error
           ~line_no
           ~line
           (Printf.sprintf "F line while frame %d is still open (missing its D line)" index)
       | "W" :: rest, Frame_open { index; admit_cycle; words_rev } ->
         let w = word_of_tokens ~line_no ~line rest in
         loop
           (line_no + 1)
           (Frame_open { index; admit_cycle; words_rev = w :: words_rev })
           frames_rev
       | "W" :: _, No_frame_open -> parse_error ~line_no ~line "W line with no open frame"
       | [ "D"; idx_s; decision_s ], Frame_open { index; admit_cycle; words_rev } ->
         let d_index = parse_int ~line_no ~line "D frame-index" idx_s in
         if d_index <> index
         then
           parse_error
             ~line_no
             ~line
             (Printf.sprintf "D frame-index %d does not match open frame %d" d_index index);
         let decision =
           match decision_s with
           | "accept" -> Accept
           | "discard" -> Discard
           | _ -> parse_error ~line_no ~line "decision must be exactly accept or discard"
         in
         let frame = { index; admit_cycle; words = List.rev words_rev; decision } in
         loop (line_no + 1) No_frame_open (frame :: frames_rev)
       | "D" :: _, No_frame_open -> parse_error ~line_no ~line "D line with no open frame"
       | "D" :: _, Frame_open _ -> parse_error ~line_no ~line "malformed D line"
       | "E" :: rest, _ ->
         (* WO-0078 §2.3 / FINDING WO-0078-1: reserved, never valid input,
            recognised REGARDLESS of [state] (open frame or not) so a
            reference-side refusal fails to read by construction rather than
            by the accident of which guard happened to leave a frame open.
            [tb_xgmii_rx_64.v] writes this line, and only this line, as the
            last thing it writes before a guard-triggered [$finish]; no
            producer on the [ours] side ever emits one (its own refusals are
            plain [failwith]s that never reach [write] at all). *)
         parse_error
           ~line_no
           ~line
           (Printf.sprintf
              "producer refusal recorded by the reference testbench: %s"
              (String.concat " " rest))
       | kind :: _, _ ->
         parse_error ~line_no ~line (Printf.sprintf "unrecognised record kind %S" kind))
    | exception End_of_file ->
      (match state with
       | Frame_open { index; _ } ->
         parse_error
           ~line_no
           ~line:""
           (Printf.sprintf "file ends with frame %d still open (missing its D line)" index)
       | No_frame_open -> List.rev frames_rev)
  in
  loop 1 No_frame_open []
;;

let read_file path =
  let ic = open_in_bin path in
  Fun.protect ~finally:(fun () -> close_in_noerr ic) (fun () -> read ic)
;;

(* ------------------------------------------------------------------ *)
(* REQ-901's comparison                                                *)
(* ------------------------------------------------------------------ *)

type divergence =
  | Missing_frame of
      { index : int
      ; side : [ `Ours | `Theirs ]
      }
  | Decision_mismatch of
      { index : int
      ; ours : decision
      ; theirs : decision
      }
  | Word_count_mismatch of
      { index : int
      ; ours : int
      ; theirs : int
      }
  | Word_mismatch of
      { index : int
      ; word_index : int
      ; field : string
      ; ours : string
      ; theirs : string
      }

(* REQ-901 declares four divergence classes, all named against other module
   pairings (M14's checksum verification, M12/M13's ARP cache, M18's zero UDP
   checksum) — none against M03 (requirements.md REQ-901; WO-0046 §1). This
   lane's permitted-divergence set is EMPTY, so every [divergence] this module
   can produce is a defect, and this function says so by never returning a
   class — never a locally-invented one (CD-xgmii_rx_64_cosim.md §0-bis). *)
let class_of (_ : divergence) : string option = None

let octets_to_string octets = String.concat " " (List.map (Printf.sprintf "%02x") octets)

let side_to_string = function
  | `Ours -> "ours"
  | `Theirs -> "theirs (the reference)"
;;

let divergence_to_string = function
  | Missing_frame { index; side } ->
    Printf.sprintf "frame %d: present only on %s" index (side_to_string side)
  | Decision_mismatch { index; ours; theirs } ->
    Printf.sprintf
      "frame %d: decision mismatch (ours=%s, theirs=%s)"
      index
      (decision_to_string ours)
      (decision_to_string theirs)
  | Word_count_mismatch { index; ours; theirs } ->
    Printf.sprintf "frame %d: word count mismatch (ours=%d, theirs=%d)" index ours theirs
  | Word_mismatch { index; word_index; field; ours; theirs } ->
    Printf.sprintf
      "frame %d word %d: %s mismatch (ours=%s, theirs=%s)"
      index
      word_index
      field
      ours
      theirs
;;

module Int_map = Map.Make (Int)

let index_map (t : transaction) =
  List.fold_left (fun acc (f : frame) -> Int_map.add f.index f acc) Int_map.empty t
;;

let all_indices om tm =
  let add_keys m acc = Int_map.fold (fun k _ acc -> k :: acc) m acc in
  add_keys om (add_keys tm []) |> List.sort_uniq Int.compare
;;

type report =
  { frames_compared : int
  ; frames_matching : int
  ; divergences : divergence list
  }

let compare_words ~index ~word_index (a : word) (b : word) divergences_rev =
  let acc = ref divergences_rev in
  let add d = acc := d :: !acc in
  if a.tkeep <> b.tkeep
  then
    add
      (Word_mismatch
         { index
         ; word_index
         ; field = "tkeep"
         ; ours = Printf.sprintf "%02x" a.tkeep
         ; theirs = Printf.sprintf "%02x" b.tkeep
         });
  if a.tlast <> b.tlast
  then
    add
      (Word_mismatch
         { index
         ; word_index
         ; field = "tlast"
         ; ours = string_of_bool a.tlast
         ; theirs = string_of_bool b.tlast
         });
  if a.tuser0 <> b.tuser0
  then
    add
      (Word_mismatch
         { index
         ; word_index
         ; field = "tuser0"
         ; ours = string_of_bool a.tuser0
         ; theirs = string_of_bool b.tuser0
         });
  if a.octets <> b.octets
  then
    add
      (Word_mismatch
         { index
         ; word_index
         ; field = "octets"
         ; ours = octets_to_string a.octets
         ; theirs = octets_to_string b.octets
         });
  !acc
;;

let compare_transactions ~(ours : transaction) ~(theirs : transaction) : report =
  let om = index_map ours and tm = index_map theirs in
  let indices = all_indices om tm in
  let frames_compared = List.length indices in
  let matching = ref 0 in
  let divergences_rev =
    List.fold_left
      (fun divergences_rev index ->
         match Int_map.find_opt index om, Int_map.find_opt index tm with
         | None, None ->
           (* unreachable: [index] came from at least one of the two maps *)
           divergences_rev
         | None, Some _ -> Missing_frame { index; side = `Theirs } :: divergences_rev
         | Some _, None -> Missing_frame { index; side = `Ours } :: divergences_rev
         | Some ofr, Some tfr ->
           let before = divergences_rev in
           let divergences_rev =
             if ofr.decision <> tfr.decision
             then
               Decision_mismatch { index; ours = ofr.decision; theirs = tfr.decision }
               :: divergences_rev
             else divergences_rev
           in
           (* REQ-901 gives no word-by-word comparison for a frame the two
              sides already disagree on accepting; that disagreement is
              already reported above and a word walk over mismatched lists
              would only add noise. *)
           let divergences_rev =
             if ofr.decision = Accept && tfr.decision = Accept
             then (
               let ow = ofr.words and tw = tfr.words in
               if List.length ow <> List.length tw
               then
                 Word_count_mismatch
                   { index; ours = List.length ow; theirs = List.length tw }
                 :: divergences_rev
               else (
                 let rec walk word_index divergences_rev = function
                   | [], [] -> divergences_rev
                   | a :: ows, b :: tws ->
                     walk
                       (word_index + 1)
                       (compare_words ~index ~word_index a b divergences_rev)
                       (ows, tws)
                   | _ -> divergences_rev
                   (* unreachable: the length check above already equalised
                      [ow] and [tw] *)
                 in
                 walk 0 divergences_rev (ow, tw)))
             else divergences_rev
           in
           if divergences_rev == before then incr matching;
           divergences_rev)
      []
      indices
  in
  { frames_compared; frames_matching = !matching; divergences = List.rev divergences_rev }
;;

let report_to_string (r : report) =
  let buf = Buffer.create 256 in
  Buffer.add_string buf (Printf.sprintf "frames compared: %d\n" r.frames_compared);
  Buffer.add_string buf (Printf.sprintf "frames matching: %d\n" r.frames_matching);
  (match r.divergences with
   | [] -> Buffer.add_string buf "divergences: none\n"
   | ds ->
     Buffer.add_string buf (Printf.sprintf "divergences: %d\n" (List.length ds));
     List.iter
       (fun d ->
          let label = match class_of d with Some c -> c | None -> "DEFECT" in
          Buffer.add_string buf (Printf.sprintf "  %s: %s\n" label (divergence_to_string d)))
       ds);
  Buffer.contents buf
;;

let is_clean (r : report) = match r.divergences with [] -> true | _ :: _ -> false

(* ------------------------------------------------------------------ *)
(* WO-0075 §3 — the three timing tiers                                 *)
(* ------------------------------------------------------------------ *)

type timing_divergence =
  | Admit_cycle_mismatch of
      { index : int
      ; ours : int
      ; theirs : int
      }
  | Spec_cycle_mismatch of
      { index : int
      ; word_index : int
      ; expected : int
      ; observed : int
      }
  | Unassertable of
      { index : int
      ; why : string
      }

type timing_report =
  { base_aligned : bool
  ; spec_divergences : timing_divergence list
  ; admit_cycles : (int * int) list
  ; own_profile : (int * (int * int) list) list
  ; reference_profile : (int * int list) list
  ; offsets : (int * int list) list
  }

let timing_divergence_to_string = function
  | Admit_cycle_mismatch { index; ours; theirs } ->
    Printf.sprintf "frame %d: admit-cycle mismatch (ours=%d, theirs=%d)" index ours theirs
  | Spec_cycle_mismatch { index; word_index; expected; observed } ->
    Printf.sprintf
      "frame %d word %d: SPEC-M03 section 6.1's admit_cycle + m + 3 pins cycle %d, observed %d"
      index
      word_index
      expected
      observed
  | Unassertable { index; why } -> Printf.sprintf "frame %d: T1 UNASSERTABLE -- %s" index why
;;

(* `FINDING RV-0078-S1-1` (WO-0078 Stage-1 repair round): T1's inferred-
   trigger guard, replacing WO-0078 §5.4's own broken-inter-word-delta
   COUNT, which `RV-STAGE1`'s review found fail-open in exactly the
   direction §5.4 did not consider -- two or more idles injected at two or
   more DISTINCT interior positions break two or more deltas, and §5.4's own
   rule ("two or more -> assert") reddened that conformant shape as a
   [Spec_cycle_mismatch] against a design that never violated SPEC-M03 §6.1
   at all (REQ-016 §10's own named failure: "a wrapper asserting it fails a
   conformant design, and one did").

   The successor rule works on the per-word DEPARTURE from the gapless
   formula directly, never on a count of broken pairwise deltas: for a frame
   with per-word observed cycles [o_m] (m = 0 .. length - 1, emission
   order), [deltas] computes [d_m = o_m - (admit_cycle + m + 3)] -- SPEC-M03
   §6.1's own formula, word by word. A LEGITIMATE injection schedule that
   places nothing before D(0) (ruled out separately by the CARRIED count,
   below) but zero-or-more idle words at or after each LATER word's own
   admission can only ever produce a [d] that starts at 0 and never
   decreases -- delay accumulates across a frame, it does not retreat. That
   is what [non_decreasing] tests. *)
let deltas ~admit_cycle (words : word list) =
  List.mapi (fun word_index (w : word) -> w.cycle - (admit_cycle + word_index + 3)) words
;;

let non_decreasing = function
  | [] | [ _ ] -> true
  | d0 :: rest ->
    let rec go prev = function
      | [] -> true
      | d :: tl -> d >= prev && go d tl
    in
    go d0 rest
;;

(* The four-way classification [check_timing] below dispatches on, per
   accepted frame: [Refuse_carried] and [Refuse_ambiguous] both refuse
   (Unassertable -- WO-0075 §3.2's guard, extended WO-0078 §5.2 and now
   `FINDING RV-0078-S1-1`); [Clean] and [Assert] both carry an [own_profile]
   entry (WO-0078 §5.1) because both are frames the guard did NOT refuse,
   whatever [Assert]'s own per-word mismatches separately report about
   them. *)
type frame_timing_verdict =
  | Clean
  | Refuse_carried
  | Refuse_ambiguous
  | Assert

let classify_frame ~carried ~admit_cycle (words : word list) : frame_timing_verdict =
  if carried > 0
  then Refuse_carried
  else (
    let ds = deltas ~admit_cycle words in
    if List.for_all (fun d -> d = 0) ds
    then Clean
    else (
      match ds with
      | d0 :: _ when d0 = 0 && non_decreasing ds -> Refuse_ambiguous
      | _ -> Assert))
;;

(* WO-0078 §5.1 / FINDING RV-0075-1: SPEC-M03 §6.1's own [admit_cycle + m + 3]
   formula, word by word, paired with what was actually observed -- the data
   [own_profile] carries so a clean T1 run prints numbers, not only a
   sentence. Computed over the SAME words [spec_cycle_mismatches] below
   walks, and only ever called where that walk is meaningful (i.e. never for
   a frame the guard below found [Unassertable]). *)
let word_profile ~admit_cycle (words : word list) =
  List.mapi (fun word_index (w : word) -> admit_cycle + word_index + 3, w.cycle) words
;;

(* SPEC-M03 section 6.1's gapless formula, word by word, over one accepted
   frame already cleared by the guard above. *)
let spec_cycle_mismatches ~index ~admit_cycle (words : word list) =
  let rec walk word_index acc = function
    | [] -> List.rev acc
    | (w : word) :: rest ->
      let expected = admit_cycle + word_index + 3 in
      let acc =
        if w.cycle <> expected
        then Spec_cycle_mismatch { index; word_index; expected; observed = w.cycle } :: acc
        else acc
      in
      walk (word_index + 1) acc rest
  in
  walk 0 [] words
;;

let check_timing
      ~(ours : transaction)
      ~(theirs : transaction)
      ?(injected_idle_before_d0 = [])
      ()
  : timing_report
  =
  let om = index_map ours and tm = index_map theirs in
  let common_indices =
    Int_map.fold (fun k _ acc -> if Int_map.mem k tm then k :: acc else acc) om []
    |> List.sort_uniq Int.compare
  in
  (* T0 -- admit-cycle equality, calibration only (WO-0075 section 3.1): no
     claim about either design, only about whether the two producers indexed
     the same stimulus the same way. *)
  let admit_cycle_mismatches =
    List.filter_map
      (fun index ->
         let ofr = Int_map.find index om and tfr = Int_map.find index tm in
         if ofr.admit_cycle <> tfr.admit_cycle
         then
           Some
             (Admit_cycle_mismatch
                { index; ours = ofr.admit_cycle; theirs = tfr.admit_cycle })
         else None)
      common_indices
  in
  let base_aligned = admit_cycle_mismatches = [] in
  if not base_aligned
  then
    (* WO-0075 section 3.1: "On a T0 red the comparator SHALL withhold T1 and
       T2 rather than report them." *)
    { base_aligned = false
    ; spec_divergences = admit_cycle_mismatches
    ; admit_cycles = []
    ; own_profile = []
    ; reference_profile = []
    ; offsets = []
    }
  else (
    (* WO-0078 §5.2 / FINDING RV-0075-2: the CARRIED antecedent, looked up per
       frame index. A frame absent from [injected_idle_before_d0] (every
       frame in every case this packet's Stage 1 ships) reads as 0, exactly
       today's behaviour. *)
    let idle_map =
      List.fold_left
        (fun acc (idx, n) -> Int_map.add idx n acc)
        Int_map.empty
        injected_idle_before_d0
    in
    let idle_before_d0 index = Option.value (Int_map.find_opt index idle_map) ~default:0 in
    (* T1 -- our side alone, against SPEC-M03 section 6.1 (WO-0075 section
       3.2). Iterates [ours] only, and only frames [ours] itself reports
       [Accept]; [theirs] is not consulted here at all.

       [classify_frame] (`FINDING RV-0078-S1-1`, superseding WO-0078 §5.4's
       broken-inter-word-delta COUNT) dispatches each accepted frame to
       exactly one of four verdicts; [t1_divergences] and [own_profile] are
       both built from the SAME classification, in one pass, so the two can
       never disagree about which frames the guard refused. *)
    let t1_and_profile =
      List.filter_map
        (fun (fr : frame) ->
           if fr.decision <> Accept
           then None
           else (
             let carried = idle_before_d0 fr.index in
             match classify_frame ~carried ~admit_cycle:fr.admit_cycle fr.words with
             | Refuse_carried ->
               Some
                 ( [ Unassertable
                       { index = fr.index
                       ; why =
                           Printf.sprintf
                             "the stimulus recorded %d idle word(s) injected at or before \
                              this frame's first octet D(0) (SPEC-M03 section 6.1's own \
                              antecedent for the admit_cycle + m + 3 formula) -- carried \
                              from the stimulus side (WO-0078 section 5.2, FINDING \
                              RV-0075-2), never inferred from output spacing, which a shift \
                              of exactly this shape would otherwise leave looking clean or \
                              ordinarily mismatched rather than unassertable"
                             carried
                       }
                   ]
                 , None )
             | Refuse_ambiguous ->
               Some
                 ( [ Unassertable
                       { index = fr.index
                       ; why =
                           Printf.sprintf
                             "the per-word departure from SPEC-M03 section 6.1's \
                              admit_cycle + m + 3 formula is [%s] -- zero at word 0 and \
                              never decreasing across the frame, exactly the shape a \
                              legitimate idle-injection schedule (nothing before D(0), \
                              zero-or-more idle words at or after each later word's own \
                              admission) would also produce, so cycle evidence alone \
                              cannot convict (FINDING RV-0078-S1-1's successor rule; \
                              WO-0078 section 5.4's own broken-delta COUNT superseded, \
                              having asserted this exact shape whenever it carried two or \
                              more broken deltas)"
                             (String.concat
                                "; "
                                (List.map
                                   string_of_int
                                   (deltas ~admit_cycle:fr.admit_cycle fr.words)))
                       }
                   ]
                 , None )
             | Clean ->
               Some ([], Some (fr.index, word_profile ~admit_cycle:fr.admit_cycle fr.words))
             | Assert ->
               Some
                 ( spec_cycle_mismatches ~index:fr.index ~admit_cycle:fr.admit_cycle fr.words
                 , Some (fr.index, word_profile ~admit_cycle:fr.admit_cycle fr.words) )))
        ours
    in
    (* WO-0078 §5.1 / FINDING RV-0075-1, extended by `FINDING RV-0078-S1-2`
       limb (b): [own_profile] carries every accepted frame [classify_frame]
       did NOT refuse -- [Clean] AND [Assert] alike, because both are
       frames the guard let through, whatever [Assert]'s own per-word
       mismatches separately say about them. [timing_report_to_string]
       prints this UNCONDITIONALLY, never gated on whether some OTHER frame
       in the same case's transaction diverged or was refused. *)
    let t1_divergences = List.concat_map fst t1_and_profile in
    let own_profile = List.filter_map snd t1_and_profile in
    (* T2 -- the reference's own cycles, recorded and never adjudicated
       (WO-0075 section 3.3). *)
    let reference_profile =
      List.map
        (fun (fr : frame) -> fr.index, List.map (fun (w : word) -> w.cycle) fr.words)
        theirs
    in
    let offsets =
      List.filter_map
        (fun index ->
           let ofr = Int_map.find index om and tfr = Int_map.find index tm in
           match ofr.words, tfr.words with
           | [], _ | _, [] -> None
           | ows, tws ->
             let rec zip = function
               | (oa : word) :: ra, (ta : word) :: rb -> (ta.cycle - oa.cycle) :: zip (ra, rb)
               | _ -> []
             in
             Some (index, zip (ows, tws)))
        common_indices
    in
    { base_aligned = true
    ; spec_divergences = t1_divergences
    ; admit_cycles =
        (* `FINDING RV-0078-S1-2` limb (a): ours's and theirs's [admit_cycle]
           are equal by construction of [base_aligned], so one value per
           common frame index suffices. *)
        List.map (fun index -> index, (Int_map.find index om).admit_cycle) common_indices
    ; own_profile
    ; reference_profile
    ; offsets
    })
;;

let cycles_to_string cycles = String.concat " " (List.map string_of_int cycles)

let timing_report_to_string (r : timing_report) =
  let buf = Buffer.create 256 in
  let add fmt = Printf.ksprintf (Buffer.add_string buf) fmt in
  add "--- T0: admit-cycle equality (calibration; asserts nothing about either design) ---\n";
  if not r.base_aligned
  then (
    add
      "T0: RED -- the two producers are not indexing the same stimulus the same way; \
       this is a harness defect, not a design finding\n";
    List.iter
      (fun d -> add "  %s\n" (timing_divergence_to_string d))
      r.spec_divergences;
    add
      "--- T1: WITHHELD -- a timing verdict computed on unaligned time bases is worse \
       than no verdict (WO-0075 section 3.1) ---\n";
    add
      "--- T2: WITHHELD -- RECORDED, NEVER ADJUDICATED under ordinary alignment, \
       withheld here alongside T1 because T0 is red ---\n")
  else (
    add
      "T0: aligned -- every frame index present on both sides shares one admit-cycle\n";
    (* `FINDING RV-0078-S1-2` limb (a): print each frame's admit_cycle
       directly on the ALIGNED path, rather than leaving it inferable from
       T1's own [word 0] entry below -- inference sufficed only while every
       landed case shared case 0's one placement, itself verified by a
       strictly-stronger instrument (the frozen stimulus's byte-identical
       hash, pass criterion 1); a genuinely new stimulus (Stage 2's C1) has
       no such instrument and needs this printed directly, which is what
       pass criterion 2 actually asks for. *)
    (match r.admit_cycles with
     | [] -> add "  (no frame index common to both sides)\n"
     | acs ->
       List.iter
         (fun (index, admit_cycle) -> add "  frame %d: admit_cycle = %d\n" index admit_cycle)
         acs);
    add
      "--- T1: our side against SPEC-M03 section 6.1 (asserting; a red is a defect \
       against OUR spec, never a differential finding) ---\n";
    (match r.spec_divergences with
     | [] ->
       add
         "T1: clean -- every accepted frame's output words landed on their \
          SPEC-M03 section 6.1 (admit_cycle + m + 3) cycles\n"
     | ds ->
       add "T1: %d divergence(s)\n" (List.length ds);
       List.iter (fun d -> add "  %s\n" (timing_divergence_to_string d)) ds);
    (* WO-0078 §5.1 / FINDING RV-0075-1, extended by `FINDING RV-0078-S1-2`
       limb (b): [own_profile]'s per-word numbers are printed for EVERY
       accepted, non-refused frame this case carries, UNCONDITIONALLY --
       never gated on whether [r.spec_divergences] is empty. [own_profile]
       itself already excludes only the frames [check_timing]'s guard
       refused; gating the PRINT on the whole transaction's divergence list
       (as this printer did before this repair) hid a clean frame's own
       numbers whenever some OTHER frame in the same case diverged or was
       refused -- unreachable at Stage 1's one-frame case 0, reachable from
       Stage 2's first multi-frame case (C2) onward. *)
    (match r.own_profile with
     | [] -> add "  (no accepted frame in this case carries an assertable T1 profile)\n"
     | profile ->
       List.iter
         (fun (index, pairs) ->
            add "  frame %d:\n" index;
            List.iteri
              (fun word_index (expected, observed) ->
                 add "    word %d: expected %d, observed %d\n" word_index expected observed)
              pairs)
         profile);
    add
      "--- T2: the reference's own cycles -- RECORDED, NEVER ADJUDICATED \
       (REQ-901's exclusion, applied to time) ---\n";
    (match r.reference_profile with
     | [] -> add "T2: no reference frames recorded\n"
     | profile ->
       List.iter
         (fun (index, cycles) ->
            add "  frame %d: theirs cycles = [%s]\n" index (cycles_to_string cycles))
         profile);
    (match r.offsets with
     | [] ->
       add
         "T2 offsets: none computed (no frame index common to both sides carries \
          output words on both)\n"
     | offs ->
       List.iter
         (fun (index, deltas) ->
            add "  frame %d: theirs - ours per word = [%s]\n" index (cycles_to_string deltas))
         offs));
  Buffer.contents buf
;;
