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
  ; octets : int list
  }

type decision =
  | Accept
  | Discard

type frame =
  { index : int
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
       Printf.fprintf oc "F %d\n" frame.index;
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
              "W %02x %d %d"
              w.tkeep
              (if w.tlast then 1 else 0)
              (if w.tuser0 then 1 else 0);
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

let word_of_tokens ~line_no ~line tokens =
  match tokens with
  | tkeep_s :: tlast_s :: tuser_s :: octet_toks ->
    let tkeep = parse_hex2 ~line_no ~line "tkeep" tkeep_s in
    let tlast = parse_bit ~line_no ~line "tlast" tlast_s in
    let tuser0 = parse_bit ~line_no ~line "tuser0" tuser_s in
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
    { tkeep; tlast; tuser0; octets }
  | _ -> parse_error ~line_no ~line "a W line needs at least tkeep, tlast and tuser0"
;;

type parse_state =
  | No_frame_open
  | Frame_open of
      { index : int
      ; words_rev : word list
      }

let read ic =
  let rec loop line_no state frames_rev =
    match input_line ic with
    | line ->
      let tokens = split_ws line in
      (match tokens, state with
       | [], _ -> parse_error ~line_no ~line "blank line not permitted"
       | [ "F"; idx_s ], No_frame_open ->
         let index = parse_int ~line_no ~line "frame-index" idx_s in
         loop (line_no + 1) (Frame_open { index; words_rev = [] }) frames_rev
       | "F" :: _, Frame_open { index; _ } ->
         parse_error
           ~line_no
           ~line
           (Printf.sprintf "F line while frame %d is still open (missing its D line)" index)
       | "W" :: rest, Frame_open { index; words_rev } ->
         let w = word_of_tokens ~line_no ~line rest in
         loop (line_no + 1) (Frame_open { index; words_rev = w :: words_rev }) frames_rev
       | "W" :: _, No_frame_open -> parse_error ~line_no ~line "W line with no open frame"
       | [ "D"; idx_s; decision_s ], Frame_open { index; words_rev } ->
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
         let frame = { index; words = List.rev words_rev; decision } in
         loop (line_no + 1) No_frame_open (frame :: frames_rev)
       | "D" :: _, No_frame_open -> parse_error ~line_no ~line "D line with no open frame"
       | "D" :: _, Frame_open _ -> parse_error ~line_no ~line "malformed D line"
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
