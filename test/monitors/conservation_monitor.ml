(* See conservation_monitor.mli for the contract, its requirements.md
   citations and the three deliberate deviations from §0.6's literal text. *)

type t =
  { name : string
  ; mutable frames_in : int
  ; mutable frames_out : int
  ; mutable frames_exempt : int
  ; mutable zero_payload : int
  ; mutable discards : int
  ; mutable aborts : int
  ; mutable exemptions : (string * int) list
  ; mutable rev_errors : string list
  ; mutable histogram : (string * int) list
  }

(* A run may exempt hundreds of frames for one reason (REQ-810 injects a
   hundred), so reasons are tallied rather than listed. WO-0003 findings §13.2:
   an expect block holds a summary, not a trace — a report nobody can read is a
   report nobody checks. *)
let bump_assoc assoc key =
  let rec go = function
    | [] -> [ key, 1 ]
    | (k, c) :: rest when String.equal k key -> (k, c + 1) :: rest
    | entry :: rest -> entry :: go rest
  in
  go assoc
;;

let create ~name =
  { name
  ; frames_in = 0
  ; frames_out = 0
  ; frames_exempt = 0
  ; zero_payload = 0
  ; discards = 0
  ; aborts = 0
  ; exemptions = []
  ; rev_errors = []
  ; histogram = []
  }
;;

let error t msg = t.rev_errors <- msg :: t.rev_errors
let frame_in t = t.frames_in <- t.frames_in + 1

let frame_in_exempt t ~reason =
  t.frames_exempt <- t.frames_exempt + 1;
  t.exemptions <- bump_assoc t.exemptions reason
;;

let frame_out t ~aborted =
  t.frames_out <- t.frames_out + 1;
  if aborted then t.aborts <- t.aborts + 1
;;

let zero_payload_header t = t.zero_payload <- t.zero_payload + 1

let bump t name = t.histogram <- bump_assoc t.histogram name

let strobe_pulse t ~name =
  if not (Strobes.mem name)
  then
    error
      t
      (Printf.sprintf
         "strobe %S is not one of requirements.md §12's %d names"
         name
         Strobes.count);
  bump t name
;;

let discarded t ~strobes =
  (match strobes with
   | [] ->
     error
       t
       "a discarded frame was reported with no strobe: that is precisely the silent \
        discard REQ-008 prohibits"
   | _ :: _ ->
     List.iter
       (fun s ->
         if not (Strobes.mem s)
         then
           error
             t
             (Printf.sprintf
                "discard attributed to %S, which is not one of requirements.md §12's %d \
                 names"
                s
                Strobes.count))
       strobes);
  t.discards <- t.discards + 1
;;

let name t = t.name
let frames_in t = t.frames_in
let frames_out t = t.frames_out
let frames_exempt t = t.frames_exempt
let zero_payload t = t.zero_payload
let discards t = t.discards
let aborts t = t.aborts
let residual t = t.frames_in - (t.frames_out + t.zero_payload + t.discards)
let errors t = List.rev t.rev_errors

let is_clean t =
  residual t = 0
  &&
  match t.rev_errors with
  | [] -> true
  | _ :: _ -> false
;;

let report t =
  let sorted =
    List.sort (fun (a, _) (b, _) -> String.compare a b) t.histogram
  in
  let histogram_text =
    match sorted with
    | [] -> "  strobes: (none)"
    | _ :: _ ->
      "  strobes: "
      ^ String.concat
          " "
          (List.map (fun (n, c) -> Printf.sprintf "%s=%d" n c) sorted)
  in
  let exemption_text =
    match List.sort (fun (a, _) (b, _) -> String.compare a b) t.exemptions with
    | [] -> []
    | reasons ->
      [ "  exempt inputs: "
        ^ String.concat
            ", "
            (List.map (fun (r, c) -> Printf.sprintf "%s x%d" r c) reasons)
      ]
  in
  let error_text = List.map (fun e -> "  ERROR: " ^ e) (errors t) in
  String.concat
    "\n"
    (Printf.sprintf
       "[%s] in=%d out=%d (aborted=%d) zero_payload=%d discards=%d exempt=%d residual=%d %s"
       t.name
       t.frames_in
       t.frames_out
       t.aborts
       t.zero_payload
       t.discards
       t.frames_exempt
       (residual t)
       (if is_clean t then "CONSERVED" else "NOT CONSERVED")
     :: histogram_text
     :: (exemption_text @ error_text))
;;
