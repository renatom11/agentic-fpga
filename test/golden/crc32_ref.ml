(* See crc32_ref.mli for the contract, the value convention and the anchoring
   obligation. Plain OCaml, standard library only. *)

let mask32 = 0xFFFFFFFF
let poly = 0x04C11DB7
let init_register = 0xFFFFFFFF
let final_xor = 0xFFFFFFFF
let check_value = 0xCBF43926
let residue = 0x2144DF1C

let reflect ~bits x =
  let r = ref 0 in
  for i = 0 to bits - 1 do
    if (x lsr i) land 1 = 1 then r := !r lor (1 lsl (bits - 1 - i))
  done;
  !r
;;

let running_of_register reg = reflect ~bits:32 (reg land mask32) lxor final_xor
let register_of_running crc = reflect ~bits:32 ((crc land mask32) lxor final_xor)

(* REQ-301 verbatim: polynomial 0x04C11DB7 over a non-reflected register, with
   the input octet reflected on the way in and the register reflected on the
   way out. Bit-serial: eight shifts per octet, no table, no eight-way
   unrolling — nothing this reference shares with the parallel engine it will
   judge. *)
let step_register reg octet =
  let r = ref ((reg lxor (reflect ~bits:8 (octet land 0xff) lsl 24)) land mask32) in
  for _ = 1 to 8 do
    r
      := if !r land 0x80000000 <> 0
         then ((!r lsl 1) lxor poly) land mask32
         else (!r lsl 1) land mask32
  done;
  !r
;;

let update ~crc_in octets =
  running_of_register (List.fold_left step_register (register_of_running crc_in) octets)
;;

let octets_of_string s = List.init (String.length s) (fun i -> Char.code s.[i])
let update_string ~crc_in s = update ~crc_in (octets_of_string s)
let of_octets octets = update ~crc_in:0 octets
let of_string s = of_octets (octets_of_string s)

(* The independent cross-check: the same function computed with a reflected
   register and the reversed polynomial, octets entering at the low end. Same
   parameterisation, different arrangement — so agreement is evidence about the
   arithmetic and not about a shared implementation habit. *)
let poly_reflected = 0xEDB88320

let update_lsb_first ~crc_in octets =
  let r = ref ((crc_in land mask32) lxor final_xor) in
  List.iter
    (fun octet ->
      r := !r lxor (octet land 0xff);
      for _ = 1 to 8 do
        r := if !r land 1 = 1 then (!r lsr 1) lxor poly_reflected else !r lsr 1
      done)
    octets;
  !r lxor final_xor
;;

(* REQ-202: least significant octet first. REQ-304's residue is constant only
   because of this order, which is why the two are one decision seen from two
   sides. *)
let fcs_octets crc =
  let c = crc land mask32 in
  [ c land 0xff; (c lsr 8) land 0xff; (c lsr 16) land 0xff; (c lsr 24) land 0xff ]
;;

let tdata_of_octets octets =
  let n = List.length octets in
  if n < 1 || n > 8
  then
    invalid_arg
      (Printf.sprintf
         "Crc32_ref.tdata_of_octets: %d octets; a word carries 1 to 8 (SPEC-M01 §6.1)"
         n);
  let v = ref 0L in
  List.iteri
    (fun k octet ->
      v := Int64.logor !v (Int64.shift_left (Int64.of_int (octet land 0xff)) (8 * k)))
    octets;
  !v
;;
