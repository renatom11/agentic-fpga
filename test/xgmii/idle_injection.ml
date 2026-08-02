(* See idle_injection.mli for the contract, the M03-N3 constraint as repaired
   at 06c1eba, C-45's scope and the WO-0031 injection scope note. *)

type site =
  { before_cycle : int
  ; idles : int
  }

type t =
  { schedule : Arrival.t
  ; sites : site list (* ascending by before_cycle, merged *)
  ; allow_c45 : bool
  ; source_of : int array (* injected cycle -> source cycle, or -1 for an idle *)
  ; map : int array (* source cycle -> injected cycle *)
  ; rev_errors : string list
  ; c45 : int list
  }

(* The one prohibited boundary per frame: before the word carrying the frame's
   first octet. At a lane-0 start the eight preamble positions are lanes 0 … 7
   of the start word, so the first octet is lane 0 of the next word; at a
   lane-4 start the preamble runs into that next word and the first octet is
   its lane 4. Both give the same boundary index — SPEC-M03 §6.1. *)
let first_octet_cycle (f : Arrival.frame) = Arrival.start_cycle f + 1

(* C-45's instances: the prohibited boundary of a LANE-0-started frame, which
   occupies no preamble position and is therefore refused only by the
   constraint's over-breadth, not by its stated ground. *)
let is_c45_boundary (f : Arrival.frame) cycle =
  f.Arrival.start_lane = 0 && cycle = first_octet_cycle f
;;

let merge sites =
  let sorted = List.sort (fun a b -> compare a.before_cycle b.before_cycle) sites in
  let rec go = function
    | [] -> []
    | a :: b :: rest when a.before_cycle = b.before_cycle ->
      go ({ before_cycle = a.before_cycle; idles = a.idles + b.idles } :: rest)
    | a :: rest -> a :: go rest
  in
  List.filter (fun s -> s.idles > 0) (go sorted)
;;

let check_sites schedule ~allow_c45 sites =
  let problems = ref [] in
  let c45 = ref [] in
  let add fmt = Printf.ksprintf (fun s -> problems := s :: !problems) fmt in
  List.iter
    (fun site ->
      Array.iter
        (fun (f : Arrival.frame) ->
          if site.before_cycle = first_octet_cycle f
          then
            if is_c45_boundary f site.before_cycle
            then (
              c45 := site.before_cycle :: !c45;
              if not allow_c45
              then
                add
                  "site before cycle %d lies between frame %d's start character (lane 0, \
                   cycle %d) and its first octet. SPEC-M03 §6.1 refuses it — 'injection \
                   begins at the frame's first octet' — and this wrapper implements the \
                   constraint AS WRITTEN. Ledger row C-45 records that the prohibition's \
                   stated ground does not hold here, since all eight preamble positions \
                   lie inside the start word and this boundary occupies none of them; \
                   the second ground (the first octet would no longer be 8 octet times \
                   after the start character) does hold. Pass ~allow_c45:true only once \
                   C-45 has landed as a spec diff"
                  site.before_cycle
                  f.Arrival.index
                  (Arrival.start_cycle f))
            else
              add
                "site before cycle %d lies inside frame %d's preamble (lane-4 start at \
                 cycle %d): an injected idle there occupies a preamble position, which \
                 REQ-102's third sentence routes to REQ-105, so the wrapper would be \
                 measuring an abort rather than REQ-016's tolerance (SPEC-M03 §6.1, \
                 M03-N3 at 06c1eba)"
                site.before_cycle
                f.Arrival.index
                (Arrival.start_cycle f))
        (Arrival.frames schedule))
    sites;
  List.rev !problems, List.sort_uniq compare !c45
;;

(* A per-cycle idle count rather than a cursor over the site list: a site whose
   boundary lies outside the schedule would otherwise sit at the head of the
   cursor and swallow every site after it, which is the kind of silent failure
   a stimulus generator must not have. Out-of-range sites are dropped by
   [normalise] with an error, never quietly. *)
let build schedule sites =
  let n = Arrival.cycles schedule in
  let at = Array.make (max n 1) 0 in
  List.iter (fun s -> at.(s.before_cycle) <- at.(s.before_cycle) + s.idles) sites;
  let total = List.fold_left (fun acc s -> acc + s.idles) 0 sites in
  let source_of = Array.make (n + total) (-1) in
  let map = Array.make (max n 1) 0 in
  let out = ref 0 in
  for c = 0 to n - 1 do
    out := !out + at.(c);
    map.(c) <- !out;
    source_of.(!out) <- c;
    incr out
  done;
  source_of, map
;;

let normalise schedule sites =
  let n = Arrival.cycles schedule in
  let kept, dropped =
    List.partition (fun s -> s.before_cycle >= 0 && s.before_cycle < n) (merge sites)
  in
  ( kept
  , List.map
      (fun s ->
        Printf.sprintf
          "site before cycle %d lies outside the schedule's 0 .. %d cycles and was \
           dropped; a stimulus the generator silently discards is a bench asserting \
           against a run it did not drive"
          s.before_cycle
          (n - 1))
      dropped )
;;

let of_sites ?(allow_c45 = false) schedule ~sites =
  let sites, out_of_range = normalise schedule sites in
  let rev_errors, c45 = check_sites schedule ~allow_c45 sites in
  let source_of, map = build schedule sites in
  { schedule
  ; sites
  ; allow_c45
  ; source_of
  ; map
  ; rev_errors = out_of_range @ rev_errors
  ; c45
  }
;;

let create = of_sites

let uniform ?(allow_c45 = false) schedule ~idles =
  (* Every legal in-frame boundary: from the boundary AFTER the word carrying
     the frame's first octet — the first one the constraint admits — through
     the boundary before the word carrying the terminate character. Injection
     inside the gap is not commissioned by §10 and is left to [create]. *)
  let sites =
    Array.to_list (Arrival.frames schedule)
    |> List.concat_map (fun (f : Arrival.frame) ->
      let first = first_octet_cycle f + 1 in
      let last = Arrival.terminate_octet_time f / 8 in
      let rec go c = if c > last then [] else { before_cycle = c; idles } :: go (c + 1) in
      if idles = 0 then [] else go first)
  in
  of_sites ~allow_c45 schedule ~sites
;;

let schedule t = t.schedule
let sites t = t.sites
let injected t = List.fold_left (fun acc s -> acc + s.idles) 0 t.sites
let cycles t = Array.length t.source_of

let word_at t ~cycle =
  if cycle < 0 || cycle >= Array.length t.source_of
  then Xgmii_word.idle
  else (
    let source = t.source_of.(cycle) in
    if source < 0 then Xgmii_word.idle else Arrival.word_at t.schedule ~cycle:source)
;;

let cycle_of t source_cycle =
  if source_cycle < 0
  then 0
  else if source_cycle >= Array.length t.map
  then source_cycle + injected t
  else t.map.(source_cycle)
;;

let is_injected t ~cycle =
  cycle >= 0 && cycle < Array.length t.source_of && t.source_of.(cycle) < 0
;;

(* REQ-016's arithmetic, applied rather than assumed: an octet's injected octet
   time is its position within its source word plus eight times the injected
   cycle that word landed on. Every idle inserted before it moves it by exactly
   8 octet times, which is the whole of what REQ-016 says injection does. *)
let in_times t (f : Arrival.frame) =
  Array.map
    (fun source_time ->
      let source_cycle = source_time / 8 in
      let lane = source_time mod 8 in
      (8 * cycle_of t source_cycle) + lane)
    (Arrival.in_times f)
;;

let errors t = t.rev_errors
let c45_sites t = t.c45

let is_clean t =
  match t.rev_errors with
  | [] -> true
  | _ :: _ -> false
;;

let report t =
  let header =
    Printf.sprintf
      "[idle injection] sites=%d idles=%d source cycles=%d injected cycles=%d \
       allow_c45=%b"
      (List.length t.sites)
      (injected t)
      (Arrival.cycles t.schedule)
      (cycles t)
      t.allow_c45
  in
  let distinct =
    List.sort_uniq compare (List.map (fun s -> s.idles) t.sites)
  in
  let rows =
    [ Printf.sprintf
        "  idles per site: %s"
        (match distinct with
         | [] -> "none (§10's 0-cycle figure)"
         | ds -> String.concat "," (List.map string_of_int ds))
    ; Printf.sprintf
        "  C-45 boundaries touched: %s"
        (match t.c45 with
         | [] -> "none"
         | cs -> String.concat "," (List.map string_of_int cs))
    ]
  in
  let problems =
    match t.rev_errors with
    | [] -> [ "  M03-N3 constraint: SATISFIED (SPEC-M03 §6.1 at 06c1eba)" ]
    | es -> List.map (fun e -> "  VIOLATION: " ^ e) es
  in
  String.concat "\n" ((header :: rows) @ problems)
;;
