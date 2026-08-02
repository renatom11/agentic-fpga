(* See stream_word.mli for the contract and its SPEC-M01 citations. Plain
   OCaml on purpose: no Hardcaml, no Base, so this file and everything built on
   it compiles and runs with nothing but the standard library. *)

type t =
  { tvalid : bool
  ; tdata : int array
  ; tkeep : int
  ; tstrb : int
  ; tlast : bool
  ; tuser : int
  }

let idle () =
  { tvalid = false
  ; tdata = Array.make 8 0
  ; tkeep = 0
  ; tstrb = 0
  ; tlast = false
  ; tuser = 0
  }
;;

let garbage_idle () =
  (* Every field except [tvalid] is nonsense that would be a violation on a
     word with [tvalid] = 1: non-contiguous [tkeep], non-zero [tstrb],
     [tlast] set. SPEC-M01 §6.3 item 5 says none of it is constrained. *)
  { tvalid = false
  ; tdata = [| 0xde; 0xad; 0xbe; 0xef; 0xba; 0xdc; 0x0f; 0xfe |]
  ; tkeep = 0xa5
  ; tstrb = 0xff
  ; tlast = true
  ; tuser = 1
  }
;;

let pad_to_8 octets =
  let a = Array.make 8 0 in
  List.iteri (fun k o -> if k < 8 then a.(k) <- o land 0xff) octets;
  a
;;

let of_octets ?(tstrb = 0) ?(tuser = 0) ?(tlast = false) octets =
  let n = List.length octets in
  if n < 1 || n > 8
  then
    invalid_arg
      (Printf.sprintf
         "Stream_word.of_octets: %d octets; SPEC-M01 §6.1 admits 1 to 8 (a \
          zero-octet word has no encoding, requirements.md §0.7)"
         n);
  { tvalid = true
  ; tdata = pad_to_8 octets
  ; tkeep = (1 lsl n) - 1
  ; tstrb = tstrb land 0xff
  ; tlast
  ; tuser = tuser land 1
  }
;;

let raw ~tvalid ~tdata ~tkeep ~tstrb ~tlast ~tuser =
  { tvalid
  ; tdata = pad_to_8 tdata
  ; tkeep = tkeep land 0xff
  ; tstrb = tstrb land 0xff
  ; tlast
  ; tuser = tuser land 1
  }
;;

let keep_count t =
  let n = ref 0 in
  for k = 0 to 7 do
    if (t.tkeep lsr k) land 1 = 1 then incr n
  done;
  !n
;;

let keep_is_contiguous_from_zero t =
  let n = keep_count t in
  n >= 1 && n <= 8 && t.tkeep = (1 lsl n) - 1
;;

let octets t =
  let acc = ref [] in
  for k = 7 downto 0 do
    if (t.tkeep lsr k) land 1 = 1 then acc := t.tdata.(k) :: !acc
  done;
  !acc
;;

let to_string t =
  if not t.tvalid
  then "idle"
  else (
    let octet_text =
      String.concat " " (List.map (fun o -> Printf.sprintf "%02x" o) (octets t))
    in
    Printf.sprintf
      "V keep=0x%02x strb=0x%02x last=%d user=%d [%s]"
      t.tkeep
      t.tstrb
      (if t.tlast then 1 else 0)
      t.tuser
      octet_text)
;;
