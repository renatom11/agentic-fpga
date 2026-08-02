(** IPv4 header builder and an independent one's-complement checksum oracle.
    WO-0033 item **X-8**; `AP-ip_eth_rx_64.md` §7, rows M14-B2, M14-B3 and
    M14-I1 decisively.

    In `test/golden/` — the charter's canonical oracle home, deliberately
    outside data_wrangler's `tools/**` so the stimulus generator can never
    stage edits to the oracle. Standard-library OCaml only, like [Crc32_ref]:
    it shares no structure with any design and needs no simulator.

    {2 What it must do, from §7's own list}

    (a) build a header from field values; (b) compute the checksum by an
    implementation that shares no structure with any design; (c) verify by
    SPEC-M14 §6.1's residue form — all ten halfwords, the received checksum
    included, sum to 0xFFFF; and (d) be {b anchored on a published worked
    example} before it judges anything.

    {2 (d): the anchor, its authority, and which constant comes from where}

    {b Authority: RFC 1071, "Computing the Internet Checksum"} (Braden, Borman,
    Partridge, September 1988). RFC 1071 is the normative definition of the
    arithmetic SPEC-M14 §6.1 restates ("add as unsigned 16-bit values and fold
    every carry out of bit 15 back into bit 0"), and its §3 "Numerical
    Examples" works one explicit octet string through it.

    {b The three constants do not all have the same standing, and an earlier
    version of this comment said they did.} Corrected at WO-0037:

    - [rfc1071_example_octets] is {b QUOTED} from §3, which prints it twice —
      once byte-by-byte ([Byte 0/1: 00 01] and so on, column-aligned) and once
      as the "Normal" Order halfwords [0001 f203 f4f5 f6f7].
    - [rfc1071_example_sum] is {b QUOTED} from §3, which reaches it at
      [Sum2] and repeats it at [Final Swap].
    - [rfc1071_example_checksum] is {b DERIVED, not quoted}. §3 stops at the
      sum: it never prints a checksum for this example, and {b the token 220d
      does not occur anywhere in RFC 1071}. The constant's authority is §1's
      outline item (2) — "the 1's complement of this sum is placed in the
      checksum field" — applied to §3's quoted sum. The value is right; the
      earlier claim that §3 "prints" it was an overclaim, and it was caught by
      this programme's own anchor check on the first run that could reach the
      text (run 30764198256, WO-0037).

    Two further RFC 1071 claims are embedded as checks rather than as prose,
    because each kills a different wrong implementation. Both citations are now
    verified against the text rather than asserted:

    - {b the residue form} — the sum of the octets {e together with} their own
      checksum is 0xFFFF. RFC 1071 §1 outline item (3) states it: the sum is
      computed "including the checksum field", and the check succeeds if the
      result is "all 1 bits (-0 in 1's complement arithmetic)". This is the
      form SPEC-M14 §6.1 makes normative and the one M14 implements, so
      anchoring the {e residue} rather than only the generated value anchors
      what the design actually does.
    - {b byte-swap invariance} (RFC 1071 §2's second property, (B) "Byte Order
      Independence"): summing the byte-swapped octet string yields the
      byte-swapped sum. §2 states it verbatim as "The sum of 16-bit integers
      can be computed in either byte order." An implementation that has the
      halfword endianness backwards agrees with the correct one on every
      palindromic vector and fails this one. {b The §2 citation is confirmed} —
      it was asserted from memory when written, and the text bears it out.

    {b How far this is discharged, stated plainly.} At WO-0033 this paragraph
    read "embedded and unconfirmed", because five fetches across two egress
    paths had returned HTTP 403 and nothing had compared these constants to the
    RFC. That is no longer the state. `tools/check_rfc1071_anchor.sh` fetches
    RFC 1071 on the CI runner and gates on five claims — the octet string and
    the sum in §3, the checksum's defining sentence and the residue sentence in
    §1, byte-order independence in §2 — with a negative control and with the
    absence of [220d] asserted as its own gated claim, so the reclassification
    above cannot silently revert.

    {b The discharge rule has not been relaxed, only satisfied differently}: no
    sign-off may cite this oracle as anchored on the strength of this comment.
    It must cite a {e run} of that script — its CI run id — because a comment
    is a claim and a run is evidence. Writing a confident citation and calling
    the anchor closed is exactly the fabricated evidence ADR-0005 rule 2 exists
    to prevent, and WO-0037 is what one looks like when it is caught.

    {2 (b): two implementations, and why the second one is not redundant}

    [sum_folding] folds the carry at {e every} addition, in 16-bit arithmetic.
    [sum_accumulate] accumulates in a wide accumulator and folds {e to a
    fixpoint} at the end. They are the two shapes real designs and real
    software take, SPEC-M14 §6.1's "fold {b every} carry out of bit 15 back
    into bit 0" is satisfied by both, and [sum] returns a value only when they
    agree.

    {2 A finding against dv_lead's own attack plan, made by building this file}

    `AP-ip_eth_rx_64.md` row **M14-B3**(a) commissions "one \[header\] whose
    ten-halfword sum needs {b two} folds (the once-folded value still carries
    out of bit 15)", to kill a 32-bit accumulator folded once. {b That stimulus
    does not exist, and the defect it names is unkillable at M14 because it is
    not a defect.} The proof is three lines and is executable as
    [fold_once_divergence]:

    - write g(T) = (T mod 2^16) + ⌊T / 2^16⌋ (fold once) and f = g iterated to a
      fixpoint. Since 2^16 ≡ 1 (mod 65535), both g and f preserve T mod 65535.
    - a 20-octet header is ten halfwords, so T ≤ 10 × 0xFFFF and ⌊T / 2^16⌋ ≤ 9,
      giving g(T) ≤ 0xFFFF + 9.
    - the header verifies iff f(T) = 0xFFFF, i.e. T ≡ 0 (mod 65535) with T > 0.
      Then g(T) ≡ 0 (mod 65535) and 0 ≤ g(T) < 2 × 65535, so g(T) ∈ {0, 0xFFFF};
      g(T) = 0 forces T = 0, which does not verify. Hence g(T) = 0xFFFF.
      Conversely g(T) = 0xFFFF stops the fixpoint at once, so f(T) = 0xFFFF.

    The two arithmetics therefore make the {b same accept/reject decision on
    every 20-octet header}, and no stimulus separates them. [fold_once] is kept
    as the defect made explicit and [fold_once_divergence] searches for the
    stimulus and returns [None], so the claim is a running check rather than a
    paragraph. Row M14-B3 keeps its part (b): a header whose folded sum reaches
    0xFFFF {e by way of an end-around carry} does separate the correct
    arithmetic from a design that adds modulo 2^16 with {b no} fold at all,
    which is a real and reachable defect. This is carried as ledger row
    **C-48**, and it is the third instance of dv_lead's own named failure mode —
    a universal about killability asserted over arithmetic that does not support
    it (C-44, and the WO-0031 prose correction, were the first two).

    {2 Derived from}

    SPEC-M14 §6.1 (the field table, the checksum arithmetic, the byte-order
    rule) and requirements.md REQ-012, REQ-601 … REQ-604, REQ-607, REQ-612 — at
    `06c1eba`. RFC 1071 for the anchor. No RTL was read (PROTOCOL §10), and
    `libs/**` was not opened. *)

(* ------------------------------------------------------------------ *)
(* The arithmetic                                                      *)
(* ------------------------------------------------------------------ *)

(** Octets to 16-bit halfwords, {b first wire octet most significant}
    (SPEC-M14 §6.1, REQ-012). An odd-length string is padded with a zero
    octet, which is RFC 1071's own rule and is never exercised by a 20-octet
    header. *)
let halfwords octets =
  let rec go = function
    | [] -> []
    | [ a ] -> [ (a land 0xff) lsl 8 ]
    | a :: b :: rest -> (((a land 0xff) lsl 8) lor (b land 0xff)) :: go rest
  in
  go octets
;;

(** Fold at every addition, in 16-bit arithmetic. *)
let sum_folding octets =
  List.fold_left
    (fun acc h ->
      let s = acc + h in
      (s land 0xffff) + (s lsr 16))
    0
    (halfwords octets)
;;

(** Accumulate wide, then fold to a fixpoint. SPEC-M14 §6.1's "fold every carry
    … back into bit 0" is a fixpoint statement, and this is it written as one:
    the loop runs until nothing is left above bit 15. *)
let sum_accumulate octets =
  let total = List.fold_left ( + ) 0 (halfwords octets) in
  let rec fold v = if v <= 0xffff then v else fold ((v land 0xffff) + (v lsr 16)) in
  fold total
;;

(** The classic defect, implemented on purpose so a bench can construct the
    stimulus that separates it: accumulate wide, fold {b once}. On most headers
    it agrees with the correct arithmetic; where the once-folded value still
    carries out of bit 15 it does not, and it then rejects a valid datagram —
    a silent connectivity failure reported as `error_ip_bad_checksum`. Never
    call this as an oracle. *)
let fold_once octets =
  let total = List.fold_left ( + ) 0 (halfwords octets) in
  (total land 0xffff) + (total lsr 16)
;;

(** The one's-complement sum SPEC-M14 §6.1 and RFC 1071 define, computed by
    both implementations and returned only when they agree. Disagreement is a
    defect in this file and raises rather than returning a number a bench would
    trust. *)
let sum octets =
  let a = sum_folding octets in
  let b = sum_accumulate octets in
  if a <> b
  then
    invalid_arg
      (Printf.sprintf
         "Ipv4_ref.sum: the folding and accumulating implementations disagree (0x%04X vs \
          0x%04X); the oracle is broken, not the stimulus"
         a
         b);
  a
;;

(** RFC 1071's checksum: the one's complement of the sum. *)
let checksum octets = lnot (sum octets) land 0xffff

(** SPEC-M14 §6.1's verification form: "The header verifies {b iff} that sum is
    0xFFFF", where the sum runs over all ten halfwords {e including} the
    received checksum at octets 10–11. This is the check M14 performs, so it is
    the one the oracle exposes. *)
let residue_ok octets = sum octets = 0xffff

(* ------------------------------------------------------------------ *)
(* RFC 1071's numerical example — the anchor                           *)
(*                                                                     *)
(* Two of these three are quoted and one is derived. The distinction is *)
(* not pedantry: it was wrong here until WO-0037, and the check that    *)
(* found it now gates on each constant's actual provenance. Do not      *)
(* re-flatten these comments into "§3 says so".                        *)
(* ------------------------------------------------------------------ *)

(** QUOTED from RFC 1071 §3, which prints these octets both byte-by-byte
    ([Byte 0/1: 00 01], column-aligned) and as the "Normal" Order halfwords
    [0001 f203 f4f5 f6f7]. *)
let rfc1071_example_octets = [ 0x00; 0x01; 0xf2; 0x03; 0xf4; 0xf5; 0xf6; 0xf7 ]

(** QUOTED from RFC 1071 §3: the 1's complement sum it computes for those
    octets, reached at [Sum2] and repeated at [Final Swap]. *)
let rfc1071_example_sum = 0xddf2

(** DERIVED, not quoted. RFC 1071 §3 stops at the sum and never prints a
    checksum for this example; the token [220d] does not occur anywhere in the
    document. Its authority is §1 outline item (2) — "the 1's complement of
    this sum is placed in the checksum field" — applied to the quoted sum
    above. Corrected at WO-0037 after the anchor check caught the overclaim. *)
let rfc1071_example_checksum = 0x220d

(** Byte-swap an octet string pairwise: RFC 1071 §2's byte-order property says
    the sum of the swapped string is the swapped sum. *)
let byte_swap octets =
  let rec go = function
    | [] -> []
    | [ a ] -> [ a ]
    | a :: b :: rest -> b :: a :: go rest
  in
  go octets
;;

let swap16 v = ((v land 0xff) lsl 8) lor ((v lsr 8) land 0xff)

(* ------------------------------------------------------------------ *)
(* The header builder                                                  *)
(* ------------------------------------------------------------------ *)

(** An IPv4 header as SPEC-M14 §6.1's field table names it. Every multi-octet
    field is a numeric value with the first wire octet most significant
    (REQ-012): destination 192.0.2.1 is [0xC0000201], total length 0x00 0x2E is
    46. [checksum = None] means "compute it"; [Some v] forces a value, which is
    how row M14-B2's one-flipped-bit datagram and a deliberately wrong header
    are built. *)
type header =
  { version : int (** 4 exactly for an accepted datagram (REQ-601) *)
  ; ihl : int (** 5 exactly — 20 octets, no options (REQ-601) *)
  ; dscp : int (** octet 1 bits 7:2 *)
  ; ecn : int (** octet 1 bits 1:0 — carried on the wire, not in [Ip_header] *)
  ; total_length : int
  ; identification : int
  ; flags : int (** 3 bits: bit 2 reserved, bit 1 DF, bit 0 more-fragments *)
  ; fragment_offset : int (** 13 bits *)
  ; ttl : int
  ; protocol : int (** 17 exactly for an accepted datagram (REQ-607) *)
  ; checksum : int option
  ; src_ip : int
  ; dst_ip : int
  }

(** A datagram every one of SPEC-M14 §9's six header conditions accepts, with
    the field values `AP-ip_eth_rx_64.md` row M14-C1 names: source 10.1.2.3,
    destination 192.0.2.1, TTL 64, DSCP 0x2A, ECN 0b11, protocol 17. Every
    field is distinct and asymmetric, so a byte-swapped decode is visible. *)
let accepted ?(total_length = 46) () =
  { version = 4
  ; ihl = 5
  ; dscp = 0x2A
  ; ecn = 0b11
  ; total_length
  ; identification = 0x1234
  ; flags = 0
  ; fragment_offset = 0
  ; ttl = 64
  ; protocol = 17
  ; checksum = None
  ; src_ip = 0x0A010203
  ; dst_ip = 0xC0000201
  }
;;

let octets_of_32 v =
  [ (v lsr 24) land 0xff; (v lsr 16) land 0xff; (v lsr 8) land 0xff; v land 0xff ]
;;

let octets_of_16 v = [ (v lsr 8) land 0xff; v land 0xff ]

(** The twenty header octets, in wire order, in SPEC-M14 §6.1's field layout.
    When [checksum] is [None] the field is computed: the checksum halfword is
    zeroed, the sum taken, and its one's complement written back — which is
    RFC 1071's construction and makes [residue_ok] true by construction, the
    property [test_ipv4_ref.ml] asserts rather than assumes. *)
let octets h =
  let without_checksum value =
    [ ((h.version land 0xf) lsl 4) lor (h.ihl land 0xf)
    ; ((h.dscp land 0x3f) lsl 2) lor (h.ecn land 0x3)
    ]
    @ octets_of_16 h.total_length
    @ octets_of_16 h.identification
    @ [ ((h.flags land 0x7) lsl 5) lor ((h.fragment_offset lsr 8) land 0x1f)
      ; h.fragment_offset land 0xff
      ; h.ttl land 0xff
      ; h.protocol land 0xff
      ]
    @ octets_of_16 value
    @ octets_of_32 h.src_ip
    @ octets_of_32 h.dst_ip
  in
  match h.checksum with
  | Some v -> without_checksum v
  | None -> without_checksum (checksum (without_checksum 0))
;;

(** The checksum halfword carried by an octet string at offsets 10–11. *)
let header_checksum_of os = (List.nth os 10 * 256) + List.nth os 11

(** The checksum field value this header carries on the wire. *)
let header_checksum h = header_checksum_of (octets h)

(** Flip one bit of one header octet {e after} the checksum was computed — row
    M14-B2's stimulus. The result is a header whose residue is not 0xFFFF and
    whose every other field is untouched. *)
let flip_bit h ~octet ~bit =
  let os = octets h in
  let flipped =
    List.mapi (fun k o -> if k = octet then (o lxor (1 lsl bit)) land 0xff else o) os
  in
  flipped
;;

(** The search row M14-B3(a) asks for, kept as a running proof that it comes up
    empty: over the whole identification field — sixteen bits nothing in Phase 1
    receives on, so varying them changes no other outcome — and over both
    accepted and rejected headers, is there one on which [sum] and [fold_once]
    reach different {e verdicts}? Returns the first, or [None].

    [None] is the expected and the {e argued} answer (see the header comment's
    three-line proof, ledger C-48). Searching a field the specification declares
    "any" is deliberate: a search that had to bend an accepted-value field would
    be varying two things at once. *)
let fold_once_divergence ?(base = accepted ()) () =
  let rec go id =
    if id > 0xffff
    then None
    else (
      let h = { base with identification = id; checksum = None } in
      let os = octets h in
      let correct = sum os = 0xffff in
      let defective = fold_once os = 0xffff in
      if correct <> defective
      then Some h
      else (
        (* and the same question on a header the checksum field makes wrong,
           which is the other half of the accept/reject decision *)
        let bad = { h with checksum = Some ((header_checksum_of os + 1) land 0xffff) } in
        let bos = octets bad in
        if (sum bos = 0xffff) <> (fold_once bos = 0xffff) then Some bad else go (id + 1)))
  in
  go 0
;;

(** Row **M14-B3**(b): a header whose folded sum reaches 0xFFFF by way of an
    end-around carry — the second shape the row asks for. Searched the same
    way and over the same field. *)
let end_around_carry ?(base = accepted ()) () =
  let rec go id =
    if id > 0xffff
    then None
    else (
      let h = { base with identification = id; checksum = None } in
      let os = octets h in
      let raw = List.fold_left ( + ) 0 (halfwords os) in
      if raw > 0xffff && residue_ok os then Some h else go (id + 1))
  in
  go 0
;;

(** Deterministic rendering for an expect snapshot: the twenty octets in hex. *)
let to_string h =
  String.concat " " (List.map (fun o -> Printf.sprintf "%02x" o) (octets h))
;;
