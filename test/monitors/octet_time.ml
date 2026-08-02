(* See octet_time.mli for the contract, the D-4 argument, and the WO-0012 split
   of the three quantities [Latency.create] used to conflate. *)

let of_xgmii ~cycle ~lane = (8 * cycle) + lane
let of_axi64 ~cycle ~byte_position = (8 * cycle) + byte_position
let cycles_floor l = l / 8
let front_offset ~strip_octets ~start_lane = strip_octets + start_lane

let word_cycles ~front_offset l =
  let sum = l + front_offset in
  if sum < 0 || sum mod 8 <> 0 then None else Some (sum / 8)
;;

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
  type observed =
    { front_offset : int
    ; latencies : int list
    ; word_delay : int option
    ; frames : int
    ; octets : int
    }

  (* One accumulator per observed front offset. [reference] is the first L seen
     in this class, which is what a later divergence is reported against — the
     per-class version of the single reference the tagger used before WO-0012.
     §0.5's "Start lanes" paragraph is why the classes exist: at the XGMII
     boundary a conformant module has one constant per start lane, not one
     constant. *)
  type cls =
    { h : int
    ; mutable ls : int list (* distinct, unsorted *)
    ; mutable reference : int option
    ; mutable n_frames : int
    ; mutable n_octets : int
    }

  type t =
    { name : string
    ; strip_octets : int
    ; tail_octets : int
    ; front_offsets : int list
    ; ceiling : int option
    ; pending : int array Queue.t (* input frames not yet matched, oldest first *)
    ; mutable classes : cls list
    ; mutable frames_compared : int
    ; mutable octets_compared : int
    ; mutable first_offender : string option
    ; mutable rev_errors : string list
    }

  let create ~name ~strip_octets ~tail_octets ~front_offsets ?ceiling () =
    { name
    ; strip_octets
    ; tail_octets
    ; front_offsets
    ; ceiling
    ; pending = Queue.create ()
    ; classes = []
    ; frames_compared = 0
    ; octets_compared = 0
    ; first_offender = None
    ; rev_errors = []
    }
  ;;

  let error t msg = t.rev_errors <- msg :: t.rev_errors
  let frame_in t octet_times = Queue.add octet_times t.pending

  let frame_dropped t =
    match Queue.take_opt t.pending with
    | Some _ -> ()
    | None -> error t "frame_dropped with no input frame pending"
  ;;

  let class_of t ~h =
    match List.find_opt (fun c -> c.h = h) t.classes with
    | Some c -> c
    | None ->
      let c = { h; ls = []; reference = None; n_frames = 0; n_octets = 0 } in
      t.classes <- c :: t.classes;
      c
  ;;

  let note t c ~frame ~octet latency =
    if not (List.exists (fun l -> l = latency) c.ls) then c.ls <- latency :: c.ls;
    match c.reference with
    | None -> c.reference <- Some latency
    | Some r ->
      if r <> latency
      then (
        match t.first_offender with
        | Some _ -> ()
        | None ->
          t.first_offender
          <- Some
               (Printf.sprintf
                  "frame %d octet %d has latency %d octet times; every earlier octet at \
                   front offset %d had %d (REQ-005, requirements.md §0.5)"
                  frame
                  octet
                  latency
                  c.h
                  r))
  ;;

  (* WO-0033 X-5/X-9. The clean-frame identity is one case of the per-frame
     extent, not the rule: see octet_time.mli for why the aborted, truncated
     and padded frames of AP-xgmii_rx_64 and AP-ip_eth_rx_64 need the other
     case, and why the delivered octets are a prefix at both modules so the
     correspondence [out.(j) = in.(j + strip_octets)] is untouched. *)
  let frame_out t ?expected_octets out_times =
    (match Queue.take_opt t.pending with
     | None ->
       error
         t
         (Printf.sprintf
            "output frame %d has no matching input frame (frames out exceed frames in)"
            t.frames_compared)
     | Some in_times ->
       let n_in = Array.length in_times in
       let got = Array.length out_times in
       let available = n_in - t.strip_octets in
       let declared =
         match expected_octets with
         | None -> None
         | Some e when e >= 0 && e <= available -> Some e
         | Some e ->
           error
             t
             (Printf.sprintf
                "frame %d: a per-frame output extent of %d octet(s) is outside 0 .. %d, \
                 the octets this frame's input trace can supply after the %d stripped \
                 from the front (WO-0033 X-5/X-9)"
                t.frames_compared
                e
                (max 0 available)
                t.strip_octets);
           None
       in
       let expected =
         match declared with
         | Some e -> e
         | None -> n_in - t.strip_octets - t.tail_octets
       in
       if n_in <= t.strip_octets || expected < 0
       then
         error
           t
           (Printf.sprintf
              "frame %d: input trace of %d octet(s) is shorter than the %d stripped from \
               the front plus the %d stripped from the back"
              t.frames_compared
              n_in
              t.strip_octets
              t.tail_octets)
       else if expected <> got
       then
         error
           t
           (match declared with
            | Some e ->
              Printf.sprintf
                "frame %d: the specification's own extent for this frame is %d octet(s), \
                 but %d were emitted (WO-0033 X-5/X-9)"
                t.frames_compared
                e
                got
            | None ->
              Printf.sprintf
                "frame %d: %d input octets less %d stripped from the front and %d from \
                 the back is %d, but %d octets were emitted"
                t.frames_compared
                n_in
                t.strip_octets
                t.tail_octets
                expected
                got)
       else if got = 0
       then
         error
           t
           (Printf.sprintf
              "frame %d: an output frame of zero octets has no encoding (REQ-011); a \
               stage emitting none must be recorded with frame_dropped (§0.7)"
              t.frames_compared)
       else (
         (* §0.5's front offset, computed from the trace rather than taken on
            trust: the octet-time base of the input measurement event is the
            word carrying the frame's first octet at the input, and h is the
            octet times from that base to the first octet the module emits. *)
         let base = 8 * (in_times.(0) / 8) in
         let h = in_times.(t.strip_octets) - base in
         if not (List.exists (fun d -> d = h) t.front_offsets)
         then
           error
             t
             (Printf.sprintf
                "frame %d: observed front offset h = %d is not one this module's spec §7 \
                 pins (declared: %s) — h is a property of the module and the start lane \
                 and is not a free choice (requirements.md §0.5)"
                t.frames_compared
                h
                (match t.front_offsets with
                 | [] -> "(none)"
                 | ds -> String.concat ", " (List.map string_of_int ds)));
         if out_times.(0) mod 8 <> 0
         then
           error
             t
             (Printf.sprintf
                "frame %d: the first emitted octet has octet time %d, which is not byte \
                 position 0 of a word — the output stream is not word-aligned at its \
                 producer (REQ-021)"
                t.frames_compared
                out_times.(0));
         let c = class_of t ~h in
         for j = 0 to got - 1 do
           note
             t
             c
             ~frame:t.frames_compared
             ~octet:j
             (out_times.(j) - in_times.(j + t.strip_octets))
         done;
         c.n_frames <- c.n_frames + 1;
         c.n_octets <- c.n_octets + got;
         t.octets_compared <- t.octets_compared + got));
    t.frames_compared <- t.frames_compared + 1
  ;;

  let name t = t.name
  let frames_compared t = t.frames_compared
  let octets_compared t = t.octets_compared

  let observed t =
    List.sort
      (fun a b -> compare a.front_offset b.front_offset)
      (List.map
         (fun c ->
           let latencies = List.sort compare c.ls in
           let word_delay =
             match latencies with
             | [ l ] -> word_cycles ~front_offset:c.h l
             | [] | _ :: _ :: _ -> None
           in
           { front_offset = c.h
           ; latencies
           ; word_delay
           ; frames = c.n_frames
           ; octets = c.n_octets
           })
         t.classes)
  ;;

  let distinct t =
    List.sort_uniq compare (List.concat_map (fun o -> o.latencies) (observed t))
  ;;

  let is_constant t =
    match observed t with
    | [] -> false
    | classes -> List.for_all (fun o -> List.length o.latencies = 1) classes
  ;;

  let constant t =
    match observed t with
    | [ { latencies = [ l ]; _ } ] -> Some l
    | _ -> None
  ;;

  let word_delay t =
    match observed t with
    | [] -> None
    | first :: rest ->
      (match first.word_delay with
       | None -> None
       | Some d ->
         if List.for_all (fun o -> o.word_delay = Some d) rest then Some d else None)
  ;;

  (* Errors that are properties of the accumulated run rather than of one
     frame: the §0.5 closure, REQ-019's ceiling, and §0.5's start-lane bound.
     Computed on demand so the function stays pure and idempotent. *)
  let derived_errors t =
    let classes = observed t in
    let closure_and_ceiling =
      List.concat_map
        (fun o ->
          match o.latencies with
          | [ l ] ->
            (match o.word_delay with
             | None ->
               [ Printf.sprintf
                   "front offset %d: L = %d gives (L + h) = %d, which is not a multiple \
                    of 8 — requirements.md §0.5 makes the word delay a whole number, so \
                    no conformant module has this pair"
                   o.front_offset
                   l
                   (l + o.front_offset)
               ]
             | Some d ->
               (match t.ceiling with
                | Some ceiling when d > ceiling ->
                  [ Printf.sprintf
                      "front offset %d: word delay %d exceeds the requirements.md §1.1 \
                       ceiling of %d (REQ-019)"
                      o.front_offset
                      d
                      ceiling
                  ]
                | Some _ | None -> []))
          | [] | _ :: _ :: _ -> [])
        classes
    in
    (* §0.5, "Start lanes": ordered by ascending h, the larger-h class's word
       delay is the smaller's or one more. Anything else makes the two L
       constants differ by 12 or worse and breaks §0.5's 8-octet-time bound. *)
    let rec adjacent = function
      | a :: (b :: _ as rest) -> (a, b) :: adjacent rest
      | [] | [ _ ] -> []
    in
    let pair_rule =
      List.concat_map
        (fun (a, b) ->
          match a.word_delay, b.word_delay with
          | Some da, Some db when db = da || db = da + 1 -> []
          | Some da, Some db ->
            [ Printf.sprintf
                "front offsets %d and %d have word delays %d and %d; requirements.md \
                 §0.5 admits only the same value or one more for the larger front offset \
                 (the two latency constants would differ by %d octet times, over the \
                 8-octet-time bound)"
                a.front_offset
                b.front_offset
                da
                db
                (abs ((8 * db) - b.front_offset - ((8 * da) - a.front_offset)))
            ]
          | Some _, None | None, Some _ | None, None -> [])
        (adjacent classes)
    in
    closure_and_ceiling @ pair_rule
  ;;

  let errors t = List.rev t.rev_errors @ derived_errors t

  let first_offender t = t.first_offender

  let is_clean t =
    is_constant t
    &&
    match errors t with
    | [] -> true
    | _ :: _ -> false
  ;;

  let report t =
    let classes = observed t in
    let header =
      let state =
        match classes with
        | [] -> "latency=(no octet compared)"
        | _ ->
          if is_constant t
          then
            Printf.sprintf
              "latency=CONSTANT per front offset (%d class%s)"
              (List.length classes)
              (if List.length classes = 1 then "" else "es")
          else "latency=NOT CONSTANT"
      in
      Printf.sprintf
        "[%s] frames=%d octets=%d %s"
        t.name
        t.frames_compared
        t.octets_compared
        state
    in
    let class_line o =
      let rec take n = function
        | [] -> []
        | x :: rest -> if n = 0 then [] else x :: take (n - 1) rest
      in
      let shown = take 8 o.latencies in
      let l_text =
        match o.latencies with
        | [ l ] -> Printf.sprintf "L=%d" l
        | _ ->
          Printf.sprintf
            "L=NOT CONSTANT distinct=[%s]%s"
            (String.concat "; " (List.map string_of_int shown))
            (if List.length o.latencies > 8 then " ..." else "")
      in
      let delay_text =
        match o.word_delay with
        | None -> "word_delay=(undefined)"
        | Some d ->
          (match t.ceiling with
           | None -> Printf.sprintf "word_delay=%d" d
           | Some ceiling ->
             Printf.sprintf
               "word_delay=%d %s ceiling %d"
               d
               (if d <= ceiling then "<=" else ">")
               ceiling)
      in
      Printf.sprintf
        "  h=%d %s %s frames=%d octets=%d"
        o.front_offset
        l_text
        delay_text
        o.frames
        o.octets
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
      ((header :: List.map class_line classes) @ offender_text @ pending_text @ error_text)
  ;;
end
