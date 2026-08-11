# SPEC-M12 — `Arp_cache`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `3f6accc`) — batch D, dv_lead
  countersignature `J-dv_lead-0009` (WO-0018); this specification was already
  **SIGNED — clean** on its own merits at a9993ff, with no findings of any class
  (`J-dv_lead-0008`, WO-0015 Return log §1). Changes to §4, §6 or §7 after this
  point are spec diffs recorded in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M12 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/arp_cache.ml`
- **Datapath role**: shared/structural — no frame octet passes through this
  module; both its ports are control edges (architecture.md §6.4.3)
- **Owns REQs**: REQ-504, and the *entry lifetime* half of REQ-506
- **Prior-art counterpart**: `arp_cache.v` (MIT) — consulted for decomposition
  and port naming only. The reference implements an LRU cache with hashing;
  architecture.md §2.5 rejected that for Phase 1 in favour of a 16-entry
  direct-mapped cache with an exactly specified index function, so the behaviour
  below is not the reference's and no source was copied. This is declared
  divergence class **(b)** of REQ-901: eviction order is not compared in
  co-simulation
- **Depends on specs**: SPEC-M01 (for nothing but the programme's record style —
  M12 carries no stream and no header record)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0006`

## 1. Purpose

M12 is the sixteen-entry IPv4-to-MAC table M13 writes on every accepted ARP
packet and reads on every transmit-side resolution. It exists as a separate
module because its behaviour is *entirely* a data structure — an index function,
an overwrite rule and a lifetime — and separating it from M13's resolver means
each can be tested against a specification the other does not mention.

Its only counterpart is M13 `Arp`, which owns both directions of both its ports
(architecture.md §6.4.3). It instantiates nothing and nothing but M13
instantiates it.

## 2. Scope

**In scope.**

- Holding **16 entries**, direct-mapped, indexed by the exact function §6.1
  states (REQ-504).
- Answering a lookup with hit-or-miss and, on a hit, the stored MAC address,
  at the fixed one-cycle delay §7 pins.
- Overwriting a slot on a write, whether or not it already holds a different
  address (REQ-504).
- Expiring an entry after the configured lifetime (REQ-506's ageing half), with
  the lifetime a compile-time parameter so tests can use short values.

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Deciding *what* to look up — the destination-class precedence of REQ-507, broadcast and multicast shortcuts (REQ-508, REQ-509) | M13 `Arp`. M12 is asked about one 32-bit address and answers about that address. It never sees a subnet mask or a gateway |
| Reporting a miss as an error | M13 (`error_arp_miss`, REQ-505). **A miss is a normal answer here**, not a condition, and M12 owns no strobe (§9) |
| Issuing an ARP request when a lookup misses, retrying it, or counting retries | M13 (REQ-505, REQ-506's retry half). M12 owns only the *entry lifetime* half of REQ-506 |
| Deciding which packets may be learned from | M13 (REQ-503) and M10 (REQ-501). Every write M12 receives has already been judged |
| Storing anything about a *failed* resolution | nobody: REQ-506 says nothing is negatively cached, so there is no such entry and no such state |
| Least-recently-used replacement | nobody in Phase 1 — architecture.md §2.5 chose direct-mapped precisely so that collision behaviour is derivable rather than emergent |

## 3. Programme invariants that bind this module

M12 is **not** a receive-path module under requirements.md §0.4: it is not on
the chain, and neither of its ports carries frame octets. The invariants that
would otherwise bind a receive-path module are answered here rather than
omitted, because an auditor checks the form.

| REQ | Consequence for M12 |
|---|---|
| REQ-001 | One `clock`. Every entry register, the lifetime mechanism and the result register are synchronous to it. |
| REQ-002 | No instance: M12 carries no `Axi64` stream in either direction. Its three records are control records (§4.1). |
| REQ-003 | No instance in the backpressure sense — M12 has no stream to stall — and none is smuggled in: neither the query port nor the write port carries a `ready`, so **M12 can never refuse a write or a lookup**, and M13 never has to hold one. That is a stronger statement than REQ-003 asks for and §7 makes it a property. |
| REQ-004 | No instance: M12 is not on §0.4's stress-bench list and sees no frame arrival rate. Its equivalent obligation is §8's back-to-back write-and-lookup run. |
| REQ-005 | No instance in the per-octet sense: M12 carries no octet. Its analogue is §7's fixed one-cycle lookup delay, which is a single constant for every address, every hit and every miss — a miss takes exactly as long as a hit, which is what keeps M13's response constant (SPEC-M13 §7). |
| REQ-007, REQ-013 | No instance: there is no `tuser` and no frame to abort. |
| REQ-008 | No instance: M12 discards nothing. A lookup that finds no entry is answered, not discarded, and §9 states so. |
| REQ-009 | Synchronous `clear`: within one cycle of `clear` deasserting **all sixteen entries are invalid** and `result_valid` = 0. This is the only way to empty the cache; there is no invalidate port (§7). |
| REQ-010 | The three records are declared here, in the module that owns the vocabulary; M13 opens them (§4.1). No `Axi64` type appears. |
| REQ-011, REQ-012, REQ-014, REQ-015, REQ-016, REQ-021 | No instance: no `tkeep`, no `tstrb`, no `tlast`, no idle-word tolerance and no word alignment, because there is no stream. REQ-012's **byte order** does bind the interpretation of an IPv4 address, and §6.1 states it, because the index function depends on which end of the 32-bit value is the least significant octet. |
| REQ-017, REQ-018 | No instance: M12 sees nothing at or below XGMII. |
| REQ-019 | No instance: no §1.1 ceiling, and the "no payload storage deeper than two datapath words" clause is about datapath buffering. M12's sixteen entries are 16 × (1 + 32 + 48) bits of *table*, not of frame, and REQ-504 is what fixes their number. |
| REQ-020 | Order preservation applies to M12 as the pipelining property of §7: results leave in the order their queries arrived, one per query, and a write accepted on a cycle is visible to every later query and to no earlier one. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M12 §4.1, lifted verbatim into docs/specs/ifc_check/arp_cache_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   The three records below are declared HERE and not in M01, which is
   FROZEN at f78766e: adding a record to M01 §4.1 would be a breaking
   post-freeze interface change (SPEC-TEMPLATE rule 7, charter §6). The
   rule batch D adopts is that such a record is declared once, at the
   module that owns its vocabulary, and opened by every counterpart —
   SPEC-M10 §4.1 states it in full and SPEC-M13 §4.1 writes
   [open! Arp_cache_ifc] and restates nothing. M12 owns the query and
   write vocabulary because M12 is what defines what a query and a write
   MEAN; M13 is the only module that speaks it.

   No [Axi64] type appears: M12 carries no stream. It does not
   [open! Axi64_ifc] either, because it references nothing from it —
   a lift that opened a module it does not use would compile and would
   still be a lie about the dependency.

   Neither the query port nor the write port carries a [ready]: M12 can
   never refuse either (§7), so no acceptance event exists and none is
   invented. *)

open! Base
open Hardcaml

module Arp_cache_query = struct
  type 'a t =
    { valid : 'a
    ; ip : 'a [@bits 32]
    }
  [@@deriving hardcaml]
end

module Arp_cache_result = struct
  type 'a t =
    { valid : 'a
    ; hit : 'a
    ; mac : 'a [@bits 48]
    }
  [@@deriving hardcaml]
end

module Arp_cache_write = struct
  type 'a t =
    { valid : 'a
    ; ip : 'a [@bits 32]
    ; mac : 'a [@bits 48]
    }
  [@@deriving hardcaml]
end

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; query : 'a Arp_cache_query.t [@rtlprefix "query_"]
    ; write : 'a Arp_cache_write.t [@rtlprefix "write_"]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t = { result : 'a Arp_cache_result.t [@rtlprefix "result_"] }
  [@@deriving hardcaml]
end

module type S = sig
  val create : ?entry_lifetime_cycles:int -> Scope.t -> Signal.t I.t -> Signal.t O.t

  val hierarchical
    :  ?instance:string
    -> ?entry_lifetime_cycles:int
    -> Scope.t
    -> Signal.t I.t
    -> Signal.t O.t
end

(* Compile-time witness of the three record field names §4.2 tabulates. *)

let _witness_field_names
      (q : Signal.t Arp_cache_query.t)
      (r : Signal.t Arp_cache_result.t)
      (w : Signal.t Arp_cache_write.t)
  =
  [ q.Arp_cache_query.valid
  ; q.Arp_cache_query.ip
  ; r.Arp_cache_result.valid
  ; r.Arp_cache_result.hit
  ; r.Arp_cache_result.mac
  ; w.Arp_cache_write.valid
  ; w.Arp_cache_write.ip
  ; w.Arp_cache_write.mac
  ]
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless one bit wide: `clock`, `clear` and the
  three `valid` fields and `hit` are one bit; `ip` and `mac` carry their widths.
- Nested interfaces carry `[@rtlprefix]`: `query` emits `query_valid` and
  `query_ip`, `write` emits `write_valid`, `write_ip` and `write_mac`, and
  `result` emits `result_valid`, `result_hit` and `result_mac`.
- **No `Axi64.Source` and no `Axi64.Dest`**, because there is no stream. REQ-003
  is satisfied vacuously and §3 says so rather than claiming a structural
  guarantee this module does not carry.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808). Both take
  `?entry_lifetime_cycles`, which is §5's parameter: REQ-506 requires the
  lifetime to be a compile-time parameter, and a defaulted optional argument is
  how this programme spells one on a module that also has an unparameterised
  default instantiation.

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M12.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear; invalidates all sixteen entries | REQ-009 |
| `query_valid` | in | 1 | a lookup is presented this cycle; M12 always accepts it | REQ-504 |
| `query_ip` | in | 32 | the IPv4 address to look up, as a numeric value with the first wire octet most significant (REQ-012). This is the **resolution target** M13 has already chosen under REQ-507, not the datagram's destination | REQ-504, REQ-012 |
| `write_valid` | in | 1 | an insert is presented this cycle; M12 always accepts it | REQ-503, REQ-504 |
| `write_ip` | in | 32 | the IPv4 address to store, same encoding | REQ-503, REQ-012 |
| `write_mac` | in | 48 | the MAC address to store against it, first wire octet most significant | REQ-503, REQ-012 |
| `result_valid` | out | 1 | one cycle high per presented query, exactly one cycle after it | REQ-504 |
| `result_hit` | out | 1 | on the `result_valid` cycle: 1 if a live entry for `query_ip` was found, 0 otherwise. Meaningful only on that cycle | REQ-504 |
| `result_mac` | out | 48 | on a hit, the stored MAC. Meaningful only on a `result_valid` cycle with `result_hit` = 1 | REQ-504 |

### 4.3 Configuration inputs

**None.** M12 reads no field of the `Config` record. Its one tunable — the entry
lifetime — is a compile-time parameter and not a configuration field, because
REQ-506 requires it to be one ("All three SHALL be compile-time parameters so
tests can use short values") and requirements.md §9.1 does not list it among the
twelve configuration fields. REQ-803 therefore has no instance here.

## 5. Parameters

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| `entry_lifetime_cycles` | `int` | **3 125 000 000** (20 s at 156.25 MHz) | 1 to 2^32 − 1 | REQ-506 requires it: a bench cannot simulate twenty seconds. The ageing test of §8 runs at 8 and asserts the exact expiry cycle §6.1 pins |

**Sixteen is not a parameter.** REQ-504 fixes the entry count and the index
function together — the index is the low four bits of the address, which is the
same statement as "sixteen entries" — so a parameterised depth would make the
index function a function of the parameter and would let a test configure a
cache the programme does not have. This is the same reasoning SPEC-M06 §5 gives
for the constant 14.

**The retry count and the retry interval are not parameters of this module.**
REQ-506 names three; the two that concern unanswered *requests* belong to M13,
which is what issues them (SPEC-M13 §5). M12 owns the lifetime alone, and the
split is stated in both places so no sign-off packet has to guess which module
covers which third of REQ-506.

## 6. Behaviour

### 6.1 Normal path

**The index function, stated exactly** (REQ-504). For a 32-bit IPv4 address `a`,
interpreted per REQ-012 as a numeric value whose **first wire octet is most
significant**:

> **index(a) = a[3:0]**

— the low four bits of the address's least significant octet, which is the
fourth octet in dotted-quad notation. There are sixteen slots, numbered 0 to 15,
and slot index(a) is the only slot that may ever hold `a`.

Worked examples, given so that a test writer can build the collision case
without deriving it:

| Address | 32-bit value | Least significant octet | index |
|---|---|---|---|
| 192.168.1.10 | 0xC0A8010A | 0x0A = 10 | **10** |
| 192.168.1.26 | 0xC0A8011A | 0x1A = 26 | **10** — collides with the above, which is REQ-504's eviction test |
| 192.168.1.11 | 0xC0A8010B | 0x0B = 11 | 11 |
| 10.0.0.1 | 0x0A000001 | 0x01 = 1 | 1 |
| 10.0.0.16 | 0x0A000010 | 0x10 = 16 | **0** — the high nibble of the octet is discarded, which is what makes 10.0.0.16 and 10.0.0.0 collide |

**What a slot holds.** A validity bit, a 32-bit address and a 48-bit MAC. There
is no tag beyond the full address: the stored address is compared in full on a
lookup, so a slot holding 192.168.1.26 answers **miss** for 192.168.1.10 even
though both map to slot 10. Storing only the 28 bits not implied by the index
would be equivalent and is §6.3 item 2.

**A write (REQ-503, REQ-504).** A write presented on cycle T with
`write_valid` = 1 stores `write_ip` and `write_mac` into slot index(`write_ip`),
sets that slot's validity bit and **restarts that slot's lifetime**. It does so
unconditionally:

- if the slot was empty, the entry is created;
- if the slot held a **different** address, that address is evicted — REQ-504's
  own sentence, and the reason nothing needs to be searched;
- if the slot held the **same** address, the MAC is overwritten (possibly with
  the same value) and the lifetime restarts, which is what makes REQ-503's
  "learn from every accepted packet" keep a busy peer alive.

M12 never refuses a write and has no `ready` (§4.1).

**A lookup (REQ-504).** A query presented on cycle Q with `query_valid` = 1
produces `result_valid` = 1 on cycle **Q + 1**, and on that cycle:

- `result_hit` = 1 and `result_mac` = the slot's MAC, if slot index(`query_ip`)
  is valid, live (below) and holds exactly `query_ip`;
- `result_hit` = 0 otherwise. `result_mac` is then unconstrained (§6.3 item 1).

A miss takes exactly as long as a hit. Queries are fully pipelined: a query on
every cycle produces a result on every cycle, in order, one per query
(REQ-020).

**Ordering of a write against a lookup, pinned because it is the one place two
ports meet.** A write accepted on cycle T is visible to every query presented on
cycle **T + 1 or later**, and to **no** query presented on cycle T or earlier. A
query and a write presented on the same cycle therefore see the slot's
*pre-write* contents, whether or not they address the same slot. Stating it as
one rule about cycles, rather than as a same-slot special case, is what lets a
bench drive both ports every cycle and still predict every answer.

**The entry lifetime (REQ-506, ageing half), stated as an observable rather than
as a mechanism.** Let L = `entry_lifetime_cycles` and let a write to slot i be
accepted on cycle T. Then slot i answers as a live entry for queries presented
on cycles

> **T + 1 through T + L inclusive**,

and answers `hit` = 0 for queries presented on cycle **T + L + 1** and later,
until the slot is written again. A write accepted on cycle T′ while the slot is
still live restarts the window at T′ — a write always wins over an expiry
landing on the same cycle, so a peer written to every L−1 cycles never
disappears. Expiry needs no port and produces no output: an entry that expires
does so silently, which is not a REQ-008 discard because nothing was discarded —
a resolution to an expired address simply misses and M13 reports it (REQ-505).

*The observable is what is normative; the mechanism is not.* An implementation
may hold a down-counter per slot, a shared prescaler with a short per-slot
count, or a timestamp compared against a free-running counter, provided the two
cycles above are exact. §6.3 item 3 records that.

**Cycle by cycle, the REQ-504 collision test** — the sequence a bench runs to
check the index function and the eviction rule at once, with L large enough not
to interfere:

| Cycle | `query` | `write` | `result` |
|---|---|---|---|
| 0 | — | 192.168.1.10 → `02:00:00:00:00:0A` (slot 10) | `result_valid` = 0 |
| 1 | 192.168.1.10 | — | `result_valid` = 0 |
| 2 | — | — | **`valid` = 1, `hit` = 1, `mac` = `02:00:00:00:00:0A`** |
| 3 | — | 192.168.1.26 → `02:00:00:00:00:1A` (slot 10, evicting) | `result_valid` = 0 |
| 4 | 192.168.1.10 | — | `result_valid` = 0 |
| 5 | 192.168.1.26 | — | `valid` = 1, **`hit` = 0** — 192.168.1.10 was evicted |
| 6 | — | — | **`valid` = 1, `hit` = 1, `mac` = `02:00:00:00:00:1A`** |

### 6.2 State machine

**M12 has no control state machine.** It has *data* state — sixteen entries and
their lifetimes — and no sequencing: every cycle it does the same three things,
in the order the rules above fix, and there is no cycle on which its response to
a given input depends on which input preceded it except through the entries
themselves. The template's requirement is answered as follows rather than
omitted.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| (the only state) | reset; `clear`; every cycle | accepts a write if one is presented; answers a query presented on the previous cycle; ages every live entry | itself |

**Reset and `clear` state**: all sixteen validity bits are 0 and `result_valid`
is 0 within one cycle of `clear` deasserting (REQ-009, §7). There is no other
way to invalidate an entry except its lifetime expiring, and there is
deliberately no invalidate port: REQ-506's "nothing is negatively cached" and
REQ-503's "learn from every accepted packet" between them leave no event that
would use one.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The value of `result_mac` on a cycle with `result_hit` = 0**, and the value
   of every output field on a cycle with `result_valid` = 0 (SPEC-M01 §6.3
   item 5). No monitor may read them.
2. **Whether a slot stores the full 32-bit address or only the 28 bits the index
   does not imply.** Both compute the same hit predicate, because the four
   implied bits are equal by construction on any lookup that reaches the slot.
   Neither is observable.
3. **How the lifetime is implemented** — a per-slot down-counter, a shared
   prescaler with a short per-slot count, a timestamp compared against a
   free-running counter, or anything else — provided the two boundary cycles of
   §6.1 are exact. §8's ageing run at L = 8 is what fixes them.
4. **Whether the sixteen entries are registers or a small memory**, and whether
   the read is registered at the address or at the data. §7's one-cycle delay
   is what is fixed.
5. **M12's behaviour when `write_valid` and `query_valid` are asserted with the
   same `ip` on the same cycle** is **not** on this list: §6.1's ordering rule
   decides it (the query sees the pre-write contents), and a bench may assert
   it.

## 7. Timing contract

- **Latency.** Pinned at **1 cycle**, for hits and misses alike: a query
  presented on cycle Q is answered on cycle Q + 1. The two measurement events
  are the cycle on which `query_valid` = 1 and the cycle on which
  `result_valid` = 1 for that query.

  requirements.md §0.5's octet times have **no instance** at this module and
  none is claimed: M12 carries no octet, so there is no octet time to difference
  and no front offset h to state. ΔC = (L + h − q)/8 is the unit of §1.1's ceilings,
  and §1.1 allocates M12 nothing because it is not on REQ-006's chain — it is
  not on the receive path at all. The figure that composes into SPEC-M13 §7's
  response constant is the **one cycle** above, stated in cycles because that is
  the only unit this port has. Writing it in octet times would be arithmetic
  without a referent, which is the failure §0.5's own "do not state latency as
  word in to word out" clause warns against from the other direction.

- **Throughput.** One query accepted per cycle and one write accepted per cycle,
  both unconditionally and both indefinitely: **M12 can never refuse either**,
  because neither port carries a `ready` (§4.1). One result emitted per query,
  in order. There is no cycle on which M13 must hold a query or a write, which
  is what lets SPEC-M13 §7 pin a constant response delay.

- **Handshake rules.** `query_valid`, `write_valid` and `result_valid` are all
  one-cycle pulses; the fields beside each are meaningful **only** on the cycle
  its `valid` is 1. There is no held level anywhere in this interface and
  therefore no ADR-0008 discipline to choose: ADR-0008 governs a header record
  travelling with a payload stream, and neither of M12's ports is one. A monitor
  keys on the pulses.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `result_valid` = 0, and all sixteen entries are invalid. A query presented on
  the first cycle after `clear` returns to 0 is answered normally on the next
  cycle, and it misses, because the cache is empty. A write presented on that
  cycle is stored normally. `clear` asserted while a query is in flight loses
  that query's result — no `result_valid` pulse appears for it — which is
  REQ-009's permission; M13 is in the same reset and has abandoned the
  resolution (SPEC-M13 §7).

- **Configuration sampling.** None; M12 reads no configuration (§4.3). Its one
  parameter is compile-time and cannot change during a run, which is REQ-506's
  intent and is why it is not in requirements.md §9.1.

## 8. Line-rate stress obligation

**Not applicable.** M12 is not in requirements.md §0.4's stress-bench list (M03,
M06, M08, M10, M14, M17, M20) and could not be: that list enumerates
receive-path modules, and REQ-004's invariant is about surviving a frame arrival
rate a module cannot slow down. No frame reaches M12, and it cannot be slowed
down by anything — it refuses nothing (§7).

Its equivalent obligation is a **saturation run**, specified here so that no
sign-off packet has to invent it: drive `write_valid` = 1 and `query_valid` = 1
on **every** cycle for 10 000 cycles, with addresses cycling through all sixteen
indices and a MAC derived from the address, and assert that

1. exactly 10 000 `result_valid` pulses appear, one per query, on consecutive
   cycles, in order (REQ-020, §7);
2. every answer matches the model implied by §6.1's index function, overwrite
   rule and same-cycle ordering rule — which is the one property that would
   break if a write were ever visible to the query beside it;
3. no cycle carries two results and none carries none.

**The ageing run**, with `entry_lifetime_cycles` overridden to **8**: write slot
0 on cycle T; query it on cycles T+1 … T+9; assert `hit` = 1 for the queries
presented on T+1 … T+8 and `hit` = 0 for the one presented on T+9. Then repeat
with a refresh write on cycle T+4 and assert the window moves to T+5 … T+12.
Those two runs are what pin §6.1's boundary cycles, and they are why the
lifetime is a parameter (REQ-506).

**The collision run** is §6.1's cycle table, driven verbatim (REQ-504).

## 9. Errors and discards

**Not applicable as a detection table.** M12 detects no abnormal condition and
raises no strobe. **A miss is not an error**: it is one of the two answers a
lookup has, it is reported on `result_hit`, and the module that decides a miss
matters is M13, which owns `error_arp_miss` (REQ-505). An expiry is likewise not
an error and not a discard: nothing was in flight to discard, and the entry's
absence is reported the next time it is asked for.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| (none detected here — see above) | — | — | — |

**REQ-008 is not weakened by an empty table.** REQ-008 makes every *discard*
observable. M12 discards nothing: every query is answered and every write is
stored. The one event that removes information — an entry expiring — is
observable in the only way that matters, as a subsequent miss, and the cycle it
happens on is pinned exactly by §6.1 so a bench can predict it rather than
detect it.

Frame conservation (requirements.md §0.6) has no instance: no frame passes
through M12. Its analogue, which §8 asserts, is **one result per query**.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock; no gated or derived clock | §3 | the emitted-Verilog edge-expression check |
| REQ-008 | no instance: nothing is discarded, and §9 says why the empty table is not a gap | §9 | none — stated so that no sign-off packet claims a strobe row for M12 |
| REQ-009 | `clear` invalidates all sixteen entries within one cycle of deassertion | §7 | write four entries, assert `clear`, deassert, query all four and assert four misses |
| REQ-010 | the three records are declared once, here, and opened by M13 | §4.1 | interface compile check; SPEC-M13's lift opening this module is the cross-check |
| REQ-012 | an IPv4 address is a numeric value with the first wire octet most significant, which is what makes "least significant octet" in REQ-504 unambiguous | §6.1 | the worked examples of §6.1 driven as directed queries, including 10.0.0.16 → slot 0 |
| REQ-020 | one result per query, in order, fully pipelined | §7 | the saturation run of §8 item 1 |
| REQ-503 | consumer side: every write M13 presents is stored, unconditionally, and restarts the lifetime | §6.1 | write the same address twice with different MACs; the second is returned |
| REQ-504 | 16 entries; index = `ip`[3:0]; a write to an occupied slot with a different address evicts it; a full-address comparison decides the hit | §6.1 | the collision run of §6.1's cycle table, plus one directed query per worked example |
| REQ-506 (ageing half) | entries expire after `entry_lifetime_cycles`, with the two boundary cycles pinned; the lifetime is a compile-time parameter | §5, §6.1 | the ageing run of §8 at L = 8, asserting the exact expiry cycle and the refresh case |
| REQ-506 (retry half) | **not** M12's: retries are M13's (SPEC-M13 §5, §6.2) | §5 | none — stated so that no sign-off packet claims retry coverage here |
| REQ-505 | **not** M12's: a miss is an answer here, and the strobe is M13's | §9 | none — stated so that no sign-off packet claims miss-reporting coverage here |
| REQ-802, REQ-803 | no instance: M12 reads no configuration, and its one tunable is compile-time (REQ-506) | §4.3 | none |
| REQ-901 | declared divergence class **(b)**: direct-mapped here versus the reference's LRU, so eviction order is excluded from co-simulation | header, §2 | the co-simulation report names class (b) against this module |
| REQ-903, REQ-808 | `arp_cache` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M12's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `arp_cache_ifc.ml` is new in this commit, declares three records and is the first lift whose `module type S` carries an optional parameter on both entry points. | **CLOSED (WO-0017).** CI `build` run **30736107842** at 2f29888 reports `success` with all four batch-D lifts in it, and `git diff a9993ff 2f29888 -- docs/specs/` is **empty**, so the run elaborated byte-identically the text drafted at a9993ff. The labelled-optional-`int` entry points compile, which is what SPEC-M13's three-parameter form and SPEC-M15's `?ttl`-free form both stand on. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **Sixteen 32-bit lifetime counters is the specification's worst case**, if an implementation reads §6.1's observable literally and builds one down-counter per slot at the default L. | **DEFERRED — nothing depends on the choice and §6.3 item 3 leaves it open.** A reader builds whatever meets §6.1's two boundary cycles; the obvious cheap form is a shared prescaler plus a small per-slot count, and §8's L = 8 run tests either. Phase 1 is simulation-only (REQ-018) so no area or timing budget binds; if a later phase synthesises this design and the counters matter, the remedy is an implementation change with no spec diff at all, because the observable is what this specification fixes. | this item | architect_docs_lead, rtl_lead | Phase-3 attach, or the first synthesis attempt |
| 11.3 | **REQ-506 is owned in two halves by two modules** — ageing here, retry at M13 — and requirements.md states it as one requirement. | **CLOSED (WO-0017), affirmatively: AGREED, and no requirements.md diff is owed.** dv_lead's answer (`J-dv_lead-0008`, WO-0015 Return log §4/Q5 — the fifth §11 item, whose closing gate was this countersignature and which the packet did not name): REQ-506 states its clauses separably — retry count and interval govern unanswered requests, entry lifetime governs entries — and the split falls on that seam. Verified mechanically rather than read: `traceability.md`'s REQ-506 row lists `M12 Arp_cache, M13 Arp` with `SPEC-M12 §5, §6.1 (ageing); SPEC-M13 §5, §6.2 (retry)`, and both specs name their own half **and disclaim the other's** in §5 and in their §10 tables, so a sign-off packet can show the whole requirement covered with neither module claiming the other's part and neither leaving a hole. **This is the pattern dv_lead asks batches E and F to copy** wherever a REQ spans modules; SPEC-M15 §5 and §10 apply it first, to REQ-610's IPv4 and UDP halves. | `traceability.md` REQ-506 | architect_docs_lead, dv_lead | closed |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5); this
spec is DRAFT.

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30736107842**, conclusion **`success`**, SHA **2f29888** — all thirteen lifts elaborate, the four batch-D lifts for the first time; per ADR-0005 a local build is not acceptable evidence. `git diff a9993ff 2f29888 -- docs/specs/` is empty, so the run witnesses the text drafted at a9993ff. CI `build` run **30739442056** at the freeze SHA **3f6accc** is likewise **`success`** with every lift in it (dv_lead fetched it through the GitHub API rather than taking it from the packet, `J-dv_lead-0009` §0), so the **frozen** text carries compile evidence at its own SHA and no witnessing argument is owed for this row either. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0006`; §11.3's closure and the §6.1 table repair `J-architect_docs_lead-0007` |
| dv_lead testability countersignature | **SIGNED — clean** for this spec at a9993ff (`J-dv_lead-0008`, WO-0015 Return log §1): index(a) = a[3:0] re-derived from REQ-504 **and** REQ-012, all five worked examples recomputed, the collision cycle table verified row by row against the T+1 visibility rule, the ageing windows verified against §8's L = 8 run — **no findings of any class**. The batch signature is **`J-dv_lead-0009`** (WO-0018), **COUNTERSIGNED at 3f6accc** |
| Frozen at | SHA **3f6accc**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. The WO-0017 diffs — §11.3's closure, §12's evidence row
and one cosmetic table cell in §6.1 — are **pre-freeze** corrections and are not
rows here: they touch no constant, no record and no cycle, and this is the one
batch-D specification that returned from countersignature with nothing to repair.
The row below is this specification's first post-freeze change, and it moves no
figure this module states — it repairs a sentence about a quantity M12 does not
have. (§12's *"this spec is DRAFT"* is stale against this document's own
**FROZEN** header and its own `Frozen at` row; it is left standing and tracked at
`J-architect_docs_lead-0043`, because a status claim is not this row's subject.)

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| 2026-08-11 | **`FINDING Q-5` (MINOR, dv_lead, `J-dv_lead-0181` §9) SUSTAINED — §7's no-instance recital stated the *retired* conversion, and it stated it as a general rule.** The paragraph explaining that requirements.md §0.5's octet times have **no instance** at M12 read *"ΔC = (L + h)/8 is the unit of §1.1's ceilings, and §1.1 allocates M12 nothing"*. §0.5's conversion has been **ΔC = (L + h − q)/8** since `0b7be1f`; the clause is now written in that form. **One symbol, and nothing else in the paragraph moves.** Why it survived the 2026-08-11 sweep of the retired forms, recorded because the mechanism is the interesting part: the sweep classified a site by whether it *states* the rule (repair) or *evaluates* it at a module's numbers (leave — a specification stating no q is stating q = 0, so `(L + h)` beside a number is the amended identity evaluated), and a **no-instance recital is a general-rule statement wearing a per-module coat** — it appears in a module's own §7, beside that module's name, and states the rule in its most general form *precisely because* the module has no numbers to put in it. dv filed this against dv's own class-A call, and the sweep followed that call faithfully. **Nothing at M12 moves and nothing could**: M12 carries no octet, so it has no octet time, no L, no h, no q, no ΔC, no §1.1 allocation and no ceiling; the one-cycle query-to-result figure §7 pins is stated in cycles and is untouched, as is the composition of it into SPEC-M13 §7 | no — **editorial**. No port, record, state, cycle, table cell or figure moves; no conformant design is admitted or excluded, and no committed test names this module's latency at all. The clause was **false as a general statement** from `0b7be1f` and is now true; it named no quantity M12 has, so it convicted nothing and licensed nothing here | none — the amended conversion is requirements.md §0.5's, ruled at `J-architect_docs_lead-0041` and countersigned at `J-dv_lead-0180`; this row applies it and chooses nothing | `J-architect_docs_lead-0043` |
