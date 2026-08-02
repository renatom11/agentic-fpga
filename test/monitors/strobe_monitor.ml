(* See strobe_monitor.mli for the contract and its requirements.md citations.
   Plain OCaml on purpose, like every other module in this library: no
   Hardcaml, no Base, so the monitor's own tests fail when the MONITOR is wrong
   rather than when a design is. *)

type event =
  { strobe : string
  ; frame : int
  ; cycle : int
  ; not_before : int
  ; not_after : int
  ; why : string
  }

type t =
  { name : string
  ; strobes : string list
  ; mutable rev_expected : event list
  ; mutable rev_observed : (string * int) list (* newest first *)
  ; mutable last_cycle : int option
  ; mutable cycles_sampled : int
  ; mutable rev_errors : string list
  }

let error t msg = t.rev_errors <- msg :: t.rev_errors

let create ~name ~strobes =
  let t =
    { name
    ; strobes
    ; rev_expected = []
    ; rev_observed = []
    ; last_cycle = None
    ; cycles_sampled = 0
    ; rev_errors = []
    }
  in
  List.iter
    (fun s ->
      if not (Strobes.mem s)
      then
        error
          t
          (Printf.sprintf
             "roster names %S, which requirements.md §12 does not define; a strobe \
              outside §12 is an invisible way to satisfy a check"
             s))
    strobes;
  t
;;

let name t = t.name
let cycles_sampled t = t.cycles_sampled
let owns t s = List.exists (fun x -> x = s) t.strobes

let expect t event =
  if not (owns t event.strobe)
  then
    error
      t
      (Printf.sprintf
         "frame %d expects %S, which %s's §9 does not own (roster: %s)"
         event.frame
         event.strobe
         t.name
         (match t.strobes with
          | [] -> "(empty)"
          | ss -> String.concat ", " ss));
  (* requirements.md §0.6's window, checked against the SPECIFICATION's own pin
     before anything is checked against a design. See the .mli: a pin outside
     the window is a spec defect of the class M03-R2 already was. *)
  if event.cycle < event.not_before || event.cycle > event.not_after
  then
    error
      t
      (Printf.sprintf
         "frame %d: %s is pinned at cycle %d, outside requirements.md §0.6's window [%d, \
          %d] — this is a defect in the module specification, not in a design (%s)"
         event.frame
         event.strobe
         event.cycle
         event.not_before
         event.not_after
         event.why);
  t.rev_expected <- event :: t.rev_expected
;;

let sample t ~cycle ~high =
  (match t.last_cycle with
   | Some previous when cycle <= previous ->
     error
       t
       (Printf.sprintf
          "cycle %d sampled after cycle %d; C-23 counts HIGH CYCLES, so a repeated or \
           out-of-order sample double-counts an event"
          cycle
          previous)
   | Some _ | None -> ());
  t.last_cycle <- Some cycle;
  t.cycles_sampled <- t.cycles_sampled + 1;
  List.iter
    (fun s ->
      if not (Strobes.mem s)
      then
        error
          t
          (Printf.sprintf
             "cycle %d: sampled strobe %S is not a requirements.md §12 name"
             cycle
             s)
      else if not (owns t s)
      then
        error
          t
          (Printf.sprintf
             "cycle %d: %s pulsed %S, which its §9 does not own"
             cycle
             t.name
             s);
      t.rev_observed <- (s, cycle) :: t.rev_observed)
    high
;;

let expected t = List.rev t.rev_expected
let observed t = List.sort compare (List.rev t.rev_observed)

let high_cycles t strobe =
  List.length (List.filter (fun (s, _) -> s = strobe) t.rev_observed)
;;

(* The matching is one expected event to one high cycle, both ways. It is done
   by removing matched pairs from a working copy rather than by counting,
   because "two events expected, one high cycle seen" and "one event expected,
   two high cycles seen" are different failures and a count comparison reports
   the same number for both. *)
let match_up t =
  let remaining = ref (observed t) in
  let missing = ref [] in
  List.iter
    (fun e ->
      let rec take acc = function
        | [] -> None
        | (s, c) :: rest when s = e.strobe && c = e.cycle -> Some (List.rev_append acc rest)
        | pair :: rest -> take (pair :: acc) rest
      in
      match take [] !remaining with
      | Some rest -> remaining := rest
      | None -> missing := e :: !missing)
    (expected t);
  List.rev !missing, !remaining
;;

let missing t = fst (match_up t)
let unexpected t = snd (match_up t)

let errors t =
  let missing, unexpected = match_up t in
  let of_missing e =
    (* A missing event is reported with the cycles the strobe WAS high, because
       "expected at 47, high at 48" is a one-cycle pin error and "expected at
       47, never high" is a missing report, and the two have different owners. *)
    let elsewhere =
      List.filter_map
        (fun (s, c) -> if s = e.strobe then Some (string_of_int c) else None)
        (observed t)
    in
    Printf.sprintf
      "frame %d: %s was expected on cycle %d and was not high there (%s); high cycles \
       for this strobe over the run: %s"
      e.frame
      e.strobe
      e.cycle
      e.why
      (match elsewhere with
       | [] -> "none"
       | cs -> String.concat ", " cs)
  in
  let of_unexpected (s, c) =
    Printf.sprintf
      "cycle %d: %s pulsed %S and no expected event claims it — a strobe the stimulus \
       did not create (requirements.md §0.6, REQ-008)"
      c
      t.name
      s
  in
  List.rev t.rev_errors @ List.map of_missing missing @ List.map of_unexpected unexpected
;;

let is_clean t =
  match errors t with
  | [] -> true
  | _ :: _ -> false
;;

let report t =
  let show label items =
    let n = List.length items in
    let rec take k = function
      | [] -> []
      | x :: rest -> if k = 0 then [] else x :: take (k - 1) rest
    in
    Printf.sprintf
      "  %s: %s%s"
      label
      (match items with
       | [] -> "none"
       | _ -> String.concat " " (take 12 items))
      (if n > 12 then Printf.sprintf " ... (%d entries)" n else "")
  in
  let roster =
    List.map (fun s -> Printf.sprintf "%s=%d" s (high_cycles t s)) t.strobes
  in
  let header =
    Printf.sprintf
      "[%s strobes] cycles=%d expected=%d high-cycles=%d"
      t.name
      t.cycles_sampled
      (List.length t.rev_expected)
      (List.length t.rev_observed)
  in
  let rows =
    [ show "high cycles per strobe (C-23, never edges)" roster
    ; show
        "observed"
        (List.map (fun (s, c) -> Printf.sprintf "%s@%d" s c) (observed t))
    ]
  in
  let problems =
    match errors t with
    | [] -> [ "  strobes: CLEAN (requirements.md §0.6, §12, the module's §9)" ]
    | es -> List.map (fun e -> "  ERROR: " ^ e) es
  in
  String.concat "\n" ((header :: rows) @ problems)
;;
