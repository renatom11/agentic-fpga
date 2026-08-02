(* See xgmii_word.mli for the contract and the spec citations. *)

let idle_char = 0x07
let start_char = 0xFB
let terminate_char = 0xFD
let error_char = 0xFE
let sequence_char = 0x9C

type lane =
  | Data of int
  | Control of int

type t =
  { data : int array
  ; control : int
  }

let of_lanes lanes =
  if List.length lanes <> 8
  then invalid_arg "Xgmii_word.of_lanes: an XGMII word has exactly eight lanes";
  let data = Array.make 8 0 in
  let control = ref 0 in
  List.iteri
    (fun k l ->
      match l with
      | Data d -> data.(k) <- d land 0xFF
      | Control c ->
        data.(k) <- c land 0xFF;
        control := !control lor (1 lsl k))
    lanes;
  { data; control = !control }
;;

let idle = of_lanes (List.init 8 (fun _ -> Control idle_char))

let of_data octets =
  if List.length octets <> 8
  then invalid_arg "Xgmii_word.of_data: an XGMII word has exactly eight lanes";
  of_lanes (List.map (fun d -> Data d) octets)
;;

let is_control t k = (t.control lsr k) land 1 = 1
let lane t k = if is_control t k then Control t.data.(k) else Data t.data.(k)

let is_idle t =
  let rec check k = k = 8 || (is_control t k && t.data.(k) = idle_char && check (k + 1)) in
  check 0
;;

let start_lane t =
  let rec find k =
    if k = 8
    then None
    else if is_control t k && t.data.(k) = start_char
    then Some k
    else find (k + 1)
  in
  find 0
;;

let equal a b =
  a.control = b.control
  &&
  let rec same k = k = 8 || (a.data.(k) = b.data.(k) && same (k + 1)) in
  same 0
;;

let lane_to_string t k =
  if is_control t k
  then (
    let c = t.data.(k) in
    if c = idle_char
    then "I"
    else if c = start_char
    then "S"
    else if c = terminate_char
    then "T"
    else if c = error_char
    then "E"
    else if c = sequence_char
    then "Q"
    else Printf.sprintf "C:%02X" c)
  else Printf.sprintf "%02X" t.data.(k)
;;

let to_string t = String.concat " " (List.init 8 (fun k -> lane_to_string t k))

let to_wire t =
  let w = ref 0L in
  for k = 7 downto 0 do
    w := Int64.logor (Int64.shift_left !w 8) (Int64.of_int (t.data.(k) land 0xFF))
  done;
  !w, t.control land 0xFF
;;

let of_wire data control =
  let byte k = Int64.to_int (Int64.logand (Int64.shift_right_logical data (8 * k)) 0xFFL) in
  { data = Array.init 8 byte; control = control land 0xFF }
;;
