(* See frame.mli for the contract and the spec citations. *)

let fcs octets = Dv_golden.Crc32_ref.fcs_octets (Dv_golden.Crc32_ref.of_octets octets)
let with_fcs octets = octets @ fcs octets

let pad_to_60 octets =
  let n = List.length octets in
  if n >= 60 then octets else octets @ List.init (60 - n) (fun _ -> 0x00)
;;

let delivered frame =
  let n = List.length frame in
  if n < 5
  then
    invalid_arg
      "Frame.delivered: a frame of fewer than five octets delivers nothing (REQ-107, \
       requirements.md §0.7)";
  List.filteri (fun i _ -> i < n - 4) frame
;;

let residue_ok frame = Dv_golden.Crc32_ref.of_octets frame = Dv_golden.Crc32_ref.residue

let stress_frame ?(filler = fun offset -> offset) ~sequence () =
  let da = [ 0x02; 0x00; 0x00; 0x00; 0x00; 0x01 ] in
  let sa = [ 0x02; 0x00; 0x00; 0x00; 0x00; 0x02 ] in
  let ethertype = [ 0x08; 0x00 ] in
  (* REQ-012: the first wire octet of a multi-octet field is its most
     significant octet, and SPEC-M03 §8 states it again for this field. *)
  let seq =
    [ (sequence lsr 24) land 0xFF
    ; (sequence lsr 16) land 0xFF
    ; (sequence lsr 8) land 0xFF
    ; sequence land 0xFF
    ]
  in
  let pad = List.init 42 (fun i -> filler (18 + i) land 0xFF) in
  with_fcs (da @ sa @ ethertype @ seq @ pad)
;;

let sequence_of octets =
  match octets with
  | _ when List.length octets < 18 ->
    invalid_arg "Frame.sequence_of: fewer than 18 octets, no sequence number to read"
  | _ ->
    let at i = List.nth octets i in
    (at 14 lsl 24) lor (at 15 lsl 16) lor (at 16 lsl 8) lor at 17
;;
