(* See octet_time.mli for the contract, the D-4 argument and the C-1 note. *)

let of_xgmii ~cycle ~lane = (8 * cycle) + lane
let of_axi64 ~cycle ~byte_position = (8 * cycle) + byte_position
let cycles_floor l = l / 8
let word_cycles ~strip_octets l = (l + strip_octets) / 8

let of_word ~cycle (w : Stream_word.t) =
  if not w.Stream_word.tvalid
  then []
  else (
    let acc = ref [] in
    for k = 7 downto 0 do
      if (w.Stream_word.tkeep lsr k) land 1 = 1
      then acc := of_axi64 ~cycle ~byte_position:k :: !acc
    done;
    !acc)
;;

let of_words words =
  Array.of_list (List.concat_map (fun (cycle, w) -> of_word ~cycle w) words)
;;

module Latency = struct
  type t =
    { name : string
    ; strip_octets : int
    ; pending : int array Queue.t (* input frames not yet matched, oldest first *)
    ; mutable frames_compared : int
    ; mutable octets_compared : int
    ; mutable observed : int list (* distinct, unsorted *)
    ; mutable reference : int option
    ; mutable first_offender : string option
    ; mutable rev_errors : string list
    }

  let create ~name ~strip_octets () =
    { name
    ; strip_octets
    ; pending = Queue.create ()
    ; frames_compared = 0
    ; octets_compared = 0
    ; observed = []
    ; reference = None
    ; first_offender = None
    ; rev_errors = []
    }
  ;;

  let error t msg = t.rev_errors <- msg :: t.rev_errors
  let frame_in t octet_times = Queue.add octet_times t.pending

  let frame_dropped t =
    match Queue.take_opt t.pending with
    | Some _ -> ()
    | None ->
      error t "frame_dropped with no input frame pending"
  ;;

  let note t ~frame ~octet latency =
    if not (List.exists (fun l -> l = latency) t.observed)
    then t.observed <- latency :: t.observed;
    match t.reference with
    | None -> t.reference <- Some latency
    | Some r ->
      if r <> latency
      then (
        match t.first_offender with
        | Some _ -> ()
        | None ->
          t.first_offender
          <- Some
               (Printf.sprintf
                  "frame %d octet %d has latency %d octet times; every earlier octet had \
                   %d (REQ-005, requirements.md §0.5)"
                  frame
                  octet
                  latency
                  r))
  ;;

  let frame_out t out_times =
    match Queue.take_opt t.pending with
    | None ->
      error
        t
        (Printf.sprintf
           "output frame %d has no matching input frame (frames out exceed frames in)"
           t.frames_compared)
    | Some in_times ->
      let expected = Array.length in_times - t.strip_octets in
      let got = Array.length out_times in
      if expected <> got
      then
        error
          t
          (Printf.sprintf
             "frame %d: %d input octets less %d stripped is %d, but %d octets were \
              emitted"
             t.frames_compared
             (Array.length in_times)
             t.strip_octets
             expected
             got)
      else (
        for j = 0 to got - 1 do
          note
            t
            ~frame:t.frames_compared
            ~octet:j
            (out_times.(j) - in_times.(j + t.strip_octets))
        done;
        t.octets_compared <- t.octets_compared + got);
      t.frames_compared <- t.frames_compared + 1
  ;;

  let name t = t.name
  let frames_compared t = t.frames_compared
  let octets_compared t = t.octets_compared
  let distinct t = List.sort compare t.observed

  let is_constant t =
    match distinct t with
    | [] | [ _ ] -> true
    | _ :: _ :: _ -> false
  ;;

  let constant t =
    match distinct t with
    | [ l ] -> Some l
    | [] | _ :: _ :: _ -> None
  ;;

  let first_offender t = t.first_offender
  let errors t = List.rev t.rev_errors

  let is_clean t =
    is_constant t
    &&
    match t.rev_errors with
    | [] -> true
    | _ :: _ -> false
  ;;

  let report t =
    let latency_text =
      match constant t with
      | Some l ->
        Printf.sprintf
          "latency=CONSTANT %d octet times (cycles_floor=%d, word_cycles[h=%d]=%d)"
          l
          (cycles_floor l)
          t.strip_octets
          (word_cycles ~strip_octets:t.strip_octets l)
      | None ->
        (match distinct t with
         | [] -> "latency=(no octet compared)"
         | values ->
           let shown =
             let rec take n = function
               | [] -> []
               | x :: rest -> if n = 0 then [] else x :: take (n - 1) rest
             in
             take 8 values
           in
           Printf.sprintf
             "latency=NOT CONSTANT distinct=[%s]%s"
             (String.concat "; " (List.map string_of_int shown))
             (if List.length values > 8 then " ..." else ""))
    in
    let offender_text =
      match t.first_offender with
      | None -> []
      | Some o -> [ "  first offender: " ^ o ]
    in
    let pending_text =
      if Queue.is_empty t.pending
      then []
      else
        [ Printf.sprintf
            "  WARNING: %d input frame(s) never matched by an output frame or \
             frame_dropped"
            (Queue.length t.pending)
        ]
    in
    let error_text = List.map (fun e -> "  ERROR: " ^ e) (errors t) in
    String.concat
      "\n"
      (Printf.sprintf
         "[%s] frames=%d octets=%d %s"
         t.name
         t.frames_compared
         t.octets_compared
         latency_text
       :: (offender_text @ pending_text @ error_text))
  ;;
end
