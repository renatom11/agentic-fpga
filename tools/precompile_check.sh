#!/usr/bin/env bash
# precompile_check.sh — type-check the DV OCaml tree with the SYSTEM compiler,
# before a push, in an environment where the real toolchain is unavailable.
#
# WHY THIS EXISTS
#
# WO-0033 pushed 23 blind-written OCaml files on the strength of an
# `ocamlc -stop-after parsing` sweep. Parsing does no name resolution, the
# Build step went red at `test/xgmii/injection.ml:380` on an unbound value,
# and J-dv_lead-0018 recorded the general form of the mistake: a claim was
# checkable and the check was not run. ADR-0005 blocks the HARDCAML toolchain
# — a specific compiler version and ~40 Jane Street packages — and NOT the
# system `ocamlc`, which is present. Most of the DV tree is plain stdlib
# OCaml, so most of the DV tree can be type-checked here, today, for free.
#
# WHAT A GREEN RUN PROVES, AND WHAT IT DOES NOT
#
#   PROVES    every name resolves, every arity and label is right, every
#             record field is spelled right, every type agrees — in the DV
#             libraries this harness compiles. That is the defect class that
#             produced the programme's first Build escape.
#   DOES NOT  prove anything about the real Hardcaml API. Lane 2 compiles
#             against transcriptions (tools/precompile_stubs/), and a
#             transcription that has drifted gives a green here and a red in
#             CI. Lane 2b re-checks the transcriptions it can and says
#             UNVERIFIED for the ones it cannot.
#   DOES NOT  run a single test. `dune runtest` is CI's, and so is every
#             [%expect] snapshot: this harness deletes expect-test syntax
#             (see LANE 1) precisely so that it is type-checking bodies and
#             judging no output at all.
#
# CI IS AUTHORITATIVE (ADR-0005). This harness stands down automatically when
# the real toolchain is present — see GATE 2 — because `dune build @default`
# with real Hardcaml strictly dominates everything below.
#
# THE LANES
#
#   LANE 1  The Hardcaml-free DV libraries, compiled for real. ppx_expect
#           syntax is mechanically rewritten away (`let%expect_test "…" =`
#           becomes `let () =`, `[%expect {|…|}]` becomes `()`); the rewrite
#           touches the harness wrapper and the snapshot node and NEVER a
#           body, so every name in every body is still resolved. An
#           unhandled ppx shape does not slip through: `ocamlc` refuses an
#           uninterpreted extension node, so the lane goes red rather than
#           quietly skipping code.
#
#   LANE 2  The Hardcaml-facing DV libraries, compiled against the committed
#           stubs in tools/precompile_stubs/. Each stub names its source path
#           in its own header.
#
#   LANE 2b Stub fidelity. tools/precompile_stubs/ifc_check.ml is re-checked
#           field-for-field against docs/specs/ifc_check/axi64_ifc.ml, which
#           is committed here and can therefore never be skipped;
#           tools/precompile_stubs/hardcaml.ml is re-checked against the
#           hardcaml sources when the opam switch has them unpacked. Anything
#           it cannot re-check is printed as UNVERIFIED-TRANSCRIPTION and
#           named in the summary. It is never silently treated as anchored.
#
#   LANE 3  The cross-library qualification sweep, in two parts.
#           3a COVERAGE: every directory under test/ carrying a dune file is
#              given a disposition (LANE1 / LANE2 / EXCLUDED-with-reason), and
#              every .ml/.mli inside a compiled directory is accounted for by
#              a compiled unit. A new directory or a new file with no
#              disposition FAILS the lane — this is what stops the harness
#              rotting into a checker of a shrinking subset.
#           3b QUALIFICATION: no source names a SIBLING LIBRARY's module by
#              bare name. Lanes 1 and 2 already replicate dune's wrapping
#              exactly (see "HOW THE WRAPPING IS REPLICATED"), so such a
#              reference is already a compile error; 3b is the independent
#              grep that keeps the property checkable if the compile model
#              ever changes, and it strips OCaml comments first so a mention
#              in prose is not a finding.
#
# HOW dune IS REPLICATED (why this is not a flat -I)
#
# A harness that PASSES code dune REJECTS is worse than no harness, because it
# is trusted. Two properties of dune's model therefore had to be reproduced,
# and each has its own seeded defect in --self-test.
#
#   WRAPPING     dune compiles a wrapped library's module Foo as the unit
#                <Lib>__Foo, opens a generated alias module <Lib>__ into every
#                unit so siblings resolve by short name, and exposes one module
#                <Lib> outward. A flat `ocamlc -I` makes `Strobes.all` resolve
#                from any library at all. So this harness mangles unit names
#                the way dune does and compiles with
#                `-open <Lib>__ -no-alias-deps`; an unqualified
#                sibling-library reference is "Unbound module" here exactly as
#                it is under dune.
#
#   ISOLATION    each library is built in its OWN directory and its include
#                path is its own directory plus the directories of the
#                libraries its dune file DECLARES — nothing else. A single
#                shared build directory would let a library use a sibling it
#                never listed in `(libraries …)`, which dune rejects and CI
#                would go red on. Found by testing this harness against a
#                synthetic library, not by reasoning about it.
#
# USAGE
#
#   tools/precompile_check.sh              lanes 1, 2, 2b, 3
#   tools/precompile_check.sh --self-test  prove the harness has teeth: run
#                                          the lanes against three seeded
#                                          defects — an unbound value, an
#                                          unqualified reference to a DECLARED
#                                          sibling library, and a qualified
#                                          reference to an UNDECLARED one —
#                                          and require all three to be caught.
#                                          Reports no verdict about the tree.
#   tools/precompile_check.sh --force      run the lanes even when the real
#                                          toolchain is present (GATE 2)
#   tools/precompile_check.sh --keep       leave the build workspace on disk
#                                          and print its path
#   tools/precompile_check.sh --warnings   additionally run an advisory
#                                          warnings-on pass over real sources
#
# EXIT
#
#   0  every lane passed, OR the harness stood down at a GATE (which it
#      announces; a SKIPPED harness is not coverage and no sign-off packet
#      may cite it as such — the same rule tools/dv_checks.sh states for its
#      PENDING lines)
#   1  a lane failed
#   2  the harness could not run its own machinery (bad workspace, malformed
#      dune file, unclassifiable directory)

set -uo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
REPO="$(cd "$HERE/.." && pwd)"
STUBS="$HERE/precompile_stubs"
TEST_ROOT="$REPO/test"

FORCE=0
KEEP=0
SELFTEST=0
WARNINGS=0

for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1 ;;
    --keep) KEEP=1 ;;
    --self-test) SELFTEST=1 ;;
    --warnings) WARNINGS=1 ;;
    -h | --help)
      sed -n '2,/^set -uo/p' "$0" | sed 's/^# \{0,1\}//;$d'
      exit 0
      ;;
    *)
      printf 'precompile_check: unknown argument %s (try --help)\n' "$arg" >&2
      exit 2
      ;;
  esac
done

# Libraries this harness is able to transcribe. A dune library whose
# dependencies are a subset of {sibling DV libraries} is LANE 1; a subset of
# {sibling DV libraries} + STUBBABLE is LANE 2; anything else is EXCLUDED and
# the reason printed is the list of dependencies that put it there.
STUBBABLE="hardcaml hardcaml_axi ifc_check"

# ------------------------------------------------------------------ #
# small helpers                                                       #
# ------------------------------------------------------------------ #

cap() { printf '%s' "$(printf '%s' "$1" | cut -c1 | tr '[:lower:]' '[:upper:]')$(printf '%s' "$1" | cut -c2-)"; }

say() { printf '%s\n' "$*"; }
hdr() { printf '\n--- %s\n' "$*"; }

# ------------------------------------------------------------------ #
# GATE 1 — is there a compiler at all?                                #
# ------------------------------------------------------------------ #

if ! command -v ocamlc >/dev/null 2>&1; then
  say "precompile_check: SKIPPED"
  say "  reason: no ocamlc on PATH."
  say "  This harness is a pre-push instrument for the development container,"
  say "  where ADR-0005 blocks the Hardcaml toolchain but a system ocamlc is"
  say "  present. Where there is no compiler at all there is nothing for it to"
  say "  do, and CI's own Build step is the authority regardless."
  say "  A SKIPPED harness is NOT coverage and may not be cited as such."
  exit 0
fi
OCAMLC_VERSION="$(ocamlc -version 2>/dev/null)"

# ------------------------------------------------------------------ #
# GATE 2 — is the real toolchain present, i.e. is this harness the    #
#          weaker of two available instruments?                       #
# ------------------------------------------------------------------ #

real_hardcaml_installed() {
  if command -v ocamlfind >/dev/null 2>&1; then
    ocamlfind query hardcaml >/dev/null 2>&1 && return 0
  fi
  local libdir
  libdir="$(opam var lib 2>/dev/null | tail -n 1)"
  [ -n "$libdir" ] && [ -d "$libdir/hardcaml" ] && return 0
  return 1
}

SKIP_REASON=""
if real_hardcaml_installed; then
  SKIP_REASON="the real Hardcaml toolchain is installed here"
elif [ -n "${GITHUB_ACTIONS:-}" ] || [ -n "${CI:-}" ]; then
  # Belt and braces. On a runner the authoritative build runs in the same
  # workflow, so this harness has nothing to add there even if the switch
  # probe above cannot see it (opam may not be on PATH in a plain `run:`
  # step). Standing down on a false negative of that probe is the safe
  # direction: the failure it would otherwise cause is a red CI step from the
  # WEAKER instrument, which is exactly the false alarm this gate exists to
  # prevent.
  SKIP_REASON="this is a CI runner, where the authoritative build runs anyway"
fi

if [ "$FORCE" -eq 0 ] && [ -n "$SKIP_REASON" ]; then
  say "precompile_check: SKIPPED"
  say "  reason: $SKIP_REASON."
  say "  \`dune build @default\` against real Hardcaml strictly dominates every"
  say "  lane below: lane 2's stubs are transcriptions, and running them beside"
  say "  the authoritative build could only produce a weaker signal or a false"
  say "  alarm the programme would learn to ignore. The harness stands down on"
  say "  purpose. Re-run with --force to override."
  say "  A SKIPPED harness is NOT coverage and may not be cited as such."
  exit 0
fi

# ------------------------------------------------------------------ #
# discovery — classify every test/ directory from its dune file       #
# ------------------------------------------------------------------ #
#
# Parsed out of each dune file: the stanza kind, the (name …) and the
# (libraries …) list. Comment lines (";" first) are dropped first. A
# (modules …) field is refused rather than guessed at, because it would make
# the file list a subset of the directory and this harness's whole anti-rot
# property is that it is not.

dune_field() {
  # $1 = dune file, $2 = field name. Accumulates from "(<field>" until the
  # parens balance, then prints the field's contents.
  awk -v field="$2" '
    { line = $0; sub(/^[ \t]*;.*$/, "", line) }
    depth > 0 {
      buf = buf " " line
      n = gsub(/\(/, "(", line); m = gsub(/\)/, ")", line)
      depth += n - m
      if (depth <= 0) { print buf; exit }
      next
    }
    {
      i = index(line, "(" field)
      if (i == 0) next
      rest = substr(line, i + length(field) + 1)
      buf = rest
      depth = 1
      n = gsub(/\(/, "(", rest); m = gsub(/\)/, ")", rest)
      depth += n - m
      if (depth <= 0) { sub(/\).*$/, "", buf); print buf; exit }
    }
  ' "$1" | sed 's/)[^)]*$//' | tr -s ' \t\n' ' ' | sed 's/^ *//;s/ *$//'
}

declare -a LANE1_DIRS=() LANE1_LIBS=() LANE1_DEPS=()
declare -a LANE2_DIRS=() LANE2_LIBS=() LANE2_DEPS=()
declare -a EXCLUDED_LINES=()

discover() {
  local d dune kind name libs dep bad
  for dune in "$TEST_ROOT"/*/dune; do
    [ -e "$dune" ] || continue
    d="$(dirname "$dune")"
    if grep -qE '^[[:space:]]*\(library\b' "$dune"; then
      kind=library
    elif grep -qE '^[[:space:]]*\(executable(s)?\b' "$dune"; then
      kind=executable
    else
      say "precompile_check: MACHINERY ERROR — $dune has no (library) or (executable) stanza."
      return 2
    fi

    if [ "$kind" = executable ]; then
      EXCLUDED_LINES+=("$(basename "$d")|executable stanza; this harness compiles libraries only")
      continue
    fi

    name="$(dune_field "$dune" name)"
    if [ -z "$name" ]; then
      say "precompile_check: MACHINERY ERROR — no (name …) in $dune."
      return 2
    fi
    if [ -n "$(dune_field "$dune" modules)" ]; then
      say "precompile_check: MACHINERY ERROR — $dune has a (modules …) field."
      say "  This harness compiles every .ml in the directory, so a (modules …)"
      say "  subset would make its coverage claim false. Teach the harness the"
      say "  field or exclude the directory explicitly; do not let it guess."
      return 2
    fi

    libs="$(dune_field "$dune" libraries)"
    bad=""
    for dep in $libs; do
      case " $STUBBABLE " in *" $dep "*) continue ;; esac
      case "$dep" in dv_*) continue ;; esac
      bad="$bad $dep"
    done
    if [ -n "$bad" ]; then
      EXCLUDED_LINES+=("$(basename "$d")|depends on$bad, which this harness cannot transcribe")
      continue
    fi

    local stubbed=0
    for dep in $libs; do
      case " $STUBBABLE " in *" $dep "*) stubbed=1 ;; esac
    done
    if [ "$stubbed" -eq 1 ]; then
      LANE2_DIRS+=("$d"); LANE2_LIBS+=("$name"); LANE2_DEPS+=("$libs")
    else
      LANE1_DIRS+=("$d"); LANE1_LIBS+=("$name"); LANE1_DEPS+=("$libs")
    fi
  done
  return 0
}

# ------------------------------------------------------------------ #
# ppx_expect strip                                                    #
# ------------------------------------------------------------------ #

STRIP_AWK='
BEGIN { inexp = 0; unhandled = 0 }
{
  line = $0
  if (inexp) {
    p = index(line, "|}]")
    if (p > 0) { inexp = 0; print substr(line, p + 3) } else { print "" }
    next
  }
  if (line ~ /^[ \t]*let%expect_test/) {
    if (line !~ /=[ \t]*$/) { unhandled = 1; print line; next }
    sub(/let%expect_test.*$/, "let () =", line)
    print line
    next
  }
  out = ""; rest = line
  while (1) {
    i = index(rest, "[%expect")
    if (i == 0) { out = out rest; break }
    after = substr(rest, i + 8)
    j = 1
    while (substr(after, j, 1) == " " || substr(after, j, 1) == "\t") j++
    if (substr(after, j, 2) != "{|") {
      # not a snapshot node (e.g. the token quoted inside a comment) — leave
      # it exactly as written. If it is code, ocamlc refuses the extension.
      out = out substr(rest, 1, i + 7)
      rest = after
      continue
    }
    out = out substr(rest, 1, i - 1) "()"
    after2 = substr(after, j + 2)
    p = index(after2, "|}]")
    if (p > 0) { rest = substr(after2, p + 3) }
    else { inexp = 1; rest = ""; break }
  }
  print out
}
END { if (unhandled) exit 3; if (inexp) exit 4 }
'

# ------------------------------------------------------------------ #
# OCaml comment stripper (lane 3b)                                    #
# ------------------------------------------------------------------ #

COMMENT_AWK='
BEGIN { depth = 0; instr = 0; inquo = 0 }
{
  line = $0; out = ""; i = 1; n = length(line)
  while (i <= n) {
    c2 = substr(line, i, 2); c1 = substr(line, i, 1)
    if (depth > 0) {
      if (c2 == "(*") { depth++; out = out "  "; i += 2; continue }
      if (c2 == "*)") { depth--; out = out "  "; i += 2; continue }
      out = out " "; i++; continue
    }
    if (instr) {
      if (c1 == "\\") { out = out "  "; i += 2; continue }
      if (c1 == "\"") { instr = 0; out = out " "; i++; continue }
      out = out " "; i++; continue
    }
    if (inquo) {
      if (c2 == "|}") { inquo = 0; out = out "  "; i += 2; continue }
      out = out " "; i++; continue
    }
    if (c2 == "(*") { depth = 1; out = out "  "; i += 2; continue }
    if (c2 == "{|") { inquo = 1; out = out "  "; i += 2; continue }
    if (c1 == "\"") { instr = 1; out = out " "; i++; continue }
    out = out c1; i++
  }
  print out
}
'

# ------------------------------------------------------------------ #
# the pipeline                                                        #
# ------------------------------------------------------------------ #
#
# materialise_lane copies each library's sources into a build directory under
# dune's own unit-naming convention, generates the alias module and the
# wrapper, and records the unit list. compile_fixpoint then compiles until no
# further progress is possible, so no dependency order has to be hard-coded
# and none can go stale.

WORK=""
cleanup() {
  if [ -n "$WORK" ] && [ "$KEEP" -eq 0 ]; then rm -rf "$WORK"; fi
}
trap cleanup EXIT

MATERIALISED=0   # count of real source files copied (lane 3a)

# Each library gets its OWN directory, and its include path is exactly its own
# directory plus the directories of the libraries its dune file DECLARES. This
# is the second place the harness refuses to be more permissive than dune: a
# shared flat directory would let a library use a sibling it never declared —
# which dune rejects and CI would go red on — and the harness would have
# passed it. Units are named "<lib>/<unit>" from here on so the include path
# is always recoverable.

materialise_lane() {
  # $1 = build dir, $2… = triples: dir lib deps
  local build="$1"; shift
  mkdir -p "$build" || return 2
  local d lib deps f base mangled aliasfile wrapfile mods dep incl
  while [ "$#" -gt 0 ]; do
    d="$1"; lib="$2"; deps="$3"; shift 3
    mkdir -p "$build/$lib" || return 2
    mods=""
    for f in "$d"/*.ml; do
      [ -e "$f" ] || continue
      base="$(basename "$f" .ml)"
      if [ "$base" = "$lib" ]; then
        say "precompile_check: MACHINERY ERROR — $f is the library's own interface module."
        say "  dune gives that module a different role; this harness does not model it."
        return 2
      fi
      mangled="${lib}__$(cap "$base")"
      if ! awk "$STRIP_AWK" "$f" > "$build/$lib/$mangled.ml"; then
        say "precompile_check: MACHINERY ERROR — unhandled ppx_expect shape in $f."
        say "  The strip understands \`let%expect_test \"…\" =\` on one line and"
        say "  \`[%expect {|…|}]\`. Extend it; do not let the file go unchecked."
        return 2
      fi
      MATERIALISED=$((MATERIALISED + 1))
      if [ -e "$d/$base.mli" ]; then
        awk "$STRIP_AWK" "$d/$base.mli" > "$build/$lib/$mangled.mli" || return 2
        MATERIALISED=$((MATERIALISED + 1))
      fi
      mods="$mods $(cap "$base")"
    done
    aliasfile="$build/$lib/${lib}__.ml"
    wrapfile="$build/$lib/${lib}.ml"
    : > "$aliasfile"
    : > "$wrapfile"
    for base in $mods; do
      printf 'module %s = %s__%s\n' "$base" "$(cap "$lib")" "$base" >> "$aliasfile"
      printf 'module %s = %s__%s\n' "$base" "$(cap "$lib")" "$base" >> "$wrapfile"
    done
    # include path: own dir + every DECLARED dependency's dir. An undeclared
    # sibling is therefore invisible, exactly as under dune.
    incl="-I ."
    for dep in $deps; do
      case " $STUBBABLE " in
        *" $dep "*) incl="$incl -I ../.stub_$dep" ;;
        *) incl="$incl -I ../$dep" ;;
      esac
    done
    printf '%s\n' "$incl" > "$build/.incl.$lib"
    ALIAS_UNITS="$ALIAS_UNITS $lib/${lib}__"
    WRAP_UNITS="$WRAP_UNITS $lib/${lib}"
    for base in $mods; do UNITS="$UNITS $lib/${lib}__${base}"; done
  done
  return 0
}

try_compile() {
  # $1 = build dir, $2 = "<lib>/<unit>"
  local build="$1" spec="$2" lib="${2%%/*}" u="${2##*/}" flags incl
  incl="$(cat "$build/.incl.$lib" 2>/dev/null || printf -- '-I .')"
  flags="-c -w -a -no-alias-deps $incl"
  case "$u" in
    *__*[!_]) flags="$flags -open $(cap "${u%%__*}")__" ;;
  esac
  ( cd "$build/$lib" || exit 9
    if [ -e "$u.mli" ]; then ocamlc $flags "$u.mli" || exit 1; fi
    ocamlc $flags "$u.ml" ) >"$build/.log.${lib}__${u}" 2>&1
}

compile_fixpoint() {
  # $1 = build dir, $2 = space-separated "<lib>/<unit>" list. Sets FAILED_UNITS.
  local build="$1" pending="$2" progressed next u
  FAILED_UNITS=""
  while [ -n "$pending" ]; do
    progressed=0
    next=""
    for u in $pending; do
      if try_compile "$build" "$u"; then progressed=1; else next="$next $u"; fi
    done
    pending="$(printf '%s' "$next" | tr -s ' ' ' ' | sed 's/^ //;s/ $//')"
    [ -z "$pending" ] && break
    [ "$progressed" -eq 0 ] && break
  done
  FAILED_UNITS="$pending"
  [ -z "$FAILED_UNITS" ]
}

report_failures() {
  local build="$1" u lib unit
  for u in $FAILED_UNITS; do
    lib="${u%%/*}"; unit="${u##*/}"
    printf '  !!! %s\n' "$u"
    sed 's/^/      /' "$build/.log.${lib}__${unit}" 2>/dev/null | head -20
  done
}

# ------------------------------------------------------------------ #
# lane 2b — stub fidelity                                             #
# ------------------------------------------------------------------ #

record_fields() {
  # $1 = file, $2 = module path like "Xgmii" — prints the field names of
  # `type 'a t = { … }` inside `module <name> = struct`, in order.
  awk -v want="$2" '
    $0 ~ "^[ \t]*module[ \t]+" want "[ \t]*=" { inmod = 1; next }
    inmod && /type '\''a t *=/ { intype = 1; next }
    intype {
      if ($0 ~ /^[ \t]*}/) { intype = 0; inmod = 0; exit }
      line = $0
      sub(/^[ \t]*[{;][ \t]*/, "", line)
      if (line ~ /^[a-z_][a-zA-Z0-9_'\'']* *:/) {
        sub(/ *:.*$/, "", line)
        print line
      }
    }
  ' "$1"
}

hardcaml_source_dir() {
  local sw
  sw="$(opam var switch 2>/dev/null | tail -n 1)"
  for c in \
    "${sw:-}/.opam-switch/sources/hardcaml/src" \
    "$HOME/.opam/fpga/.opam-switch/sources/hardcaml/src"; do
    [ -n "$c" ] && [ -d "$c" ] && { printf '%s' "$c"; return 0; }
  done
  return 1
}

lane2b() {
  local status=0 unverified=0 m lift stub hsrc name
  lift="$REPO/docs/specs/ifc_check/axi64_ifc.ml"
  stub="$STUBS/ifc_check.ml"

  say "  ifc_check.ml vs docs/specs/ifc_check/axi64_ifc.ml (committed here — never skippable)"
  if [ ! -e "$lift" ]; then
    say "    !!! the lift is missing; the stub cannot be re-checked and this is a FAILURE,"
    say "        not a skip: the source it claims to transcribe must exist."
    return 1
  fi
  for m in Xgmii Eth_header Ip_header Udp_header Config Status; do
    if diff <(record_fields "$lift" "$m") <(record_fields "$stub" "$m") >/dev/null 2>&1; then
      say "    $m: fields agree"
    else
      say "    !!! $m: STUB DRIFT — field lists differ (lift left, stub right)"
      diff <(record_fields "$lift" "$m") <(record_fields "$stub" "$m") | sed 's/^/        /'
      status=1
    fi
  done
  say "    Axi64.Source / Axi64.Dest: UNVERIFIED-TRANSCRIPTION"
  say "      not in the lift (it applies Hardcaml_axi.Stream.Make); hardcaml_axi"
  say "      sources are absent here. SPEC-M01 §11.4 already records these six"
  say "      names as unverified by compilation. CI settles them."
  unverified=$((unverified + 1))

  say "  hardcaml.ml vs the hardcaml package sources"
  if hsrc="$(hardcaml_source_dir)"; then
    say "    source: $hsrc"
    while read -r name; do
      [ -n "$name" ] || continue
      if grep -qF "$name" "$hsrc"/comb_intf.ml "$hsrc"/bits.mli "$hsrc"/bits_intf.ml 2>/dev/null; then
        say "    found verbatim: $name"
      else
        say "    !!! NOT FOUND in the hardcaml sources: $name"
        status=1
      fi
    done < <(sed -n 's/^  \(val [a-z_0-9]* : .*\)$/\1/p' "$STUBS/hardcaml.ml")
  else
    say "    UNVERIFIED-TRANSCRIPTION — hardcaml sources not found in this switch."
    say "      Lane 2's Hardcaml names are therefore transcriptions checked by"
    say "      nothing local. CI is their authority."
    unverified=$((unverified + 1))
  fi

  say "  base.ml: UNVERIFIED-TRANSCRIPTION"
  say "    base is not installed and its sources are absent (ADR-0005); the one"
  say "    signature it carries (Array.init ~f) is quoted from Base's published"
  say "    interface, not from a local copy."
  unverified=$((unverified + 1))

  LANE2B_UNVERIFIED="$unverified"
  return "$status"
}

# ------------------------------------------------------------------ #
# lane 3b — qualification grep                                        #
# ------------------------------------------------------------------ #

lane3b() {
  local status=0 i j d lib odir olib f base stripped hits
  local -a alldirs=() alllibs=()
  for i in "${!LANE1_DIRS[@]}"; do alldirs+=("${LANE1_DIRS[$i]}"); alllibs+=("${LANE1_LIBS[$i]}"); done
  for i in "${!LANE2_DIRS[@]}"; do alldirs+=("${LANE2_DIRS[$i]}"); alllibs+=("${LANE2_LIBS[$i]}"); done

  stripped="$WORK/stripped"
  mkdir -p "$stripped"
  for i in "${!alldirs[@]}"; do
    d="${alldirs[$i]}"; lib="${alllibs[$i]}"
    # every module name owned by a DIFFERENT in-scope library
    local foreign=""
    for j in "${!alldirs[@]}"; do
      [ "$j" = "$i" ] && continue
      odir="${alldirs[$j]}"; olib="${alllibs[$j]}"
      for f in "$odir"/*.ml; do
        [ -e "$f" ] || continue
        foreign="$foreign $(cap "$(basename "$f" .ml)")"
      done
    done
    for f in "$d"/*.ml "$d"/*.mli; do
      [ -e "$f" ] || continue
      base="$(basename "$f")"
      awk "$COMMENT_AWK" "$f" > "$stripped/$base.$lib" || return 2
      for name in $foreign; do
        hits="$(grep -nE "(^|[^A-Za-z0-9_.'])$name\\." "$stripped/$base.$lib" 2>/dev/null)"
        if [ -n "$hits" ]; then
          say "    !!! $f names sibling-library module $name without its library prefix:"
          printf '%s\n' "$hits" | sed 's/^/        /'
          status=1
        fi
      done
    done
  done
  return "$status"
}

# ------------------------------------------------------------------ #
# one full pass                                                       #
# ------------------------------------------------------------------ #

run_pass() {
  # $1 = "clean" | a mutation spec "unit:text"
  local mutation="${1:-clean}"
  local build1 build2 rc=0 f
  build1="$WORK/lane1"
  build2="$WORK/lane2"
  rm -rf "$build1" "$build2"
  UNITS=""; ALIAS_UNITS=""; WRAP_UNITS=""; MATERIALISED=0

  # ---- lane 1
  local triples=()
  for i in "${!LANE1_DIRS[@]}"; do
    triples+=("${LANE1_DIRS[$i]}" "${LANE1_LIBS[$i]}" "${LANE1_DEPS[$i]}")
  done
  materialise_lane "$build1" "${triples[@]}" || return 2
  local lane1_units="$UNITS" lane1_alias="$ALIAS_UNITS" lane1_wrap="$WRAP_UNITS"

  if [ "$mutation" != clean ]; then
    local mu="${mutation%%:*}" mtext="${mutation#*:}"
    if [ ! -e "$build1/$mu.ml" ]; then
      say "precompile_check: MACHINERY ERROR — self-test target $mu.ml not materialised."
      return 2
    fi
    printf '\n%s\n' "$mtext" >> "$build1/$mu.ml"
  fi

  hdr "LANE 1 — Hardcaml-free DV libraries, compiled for real"
  say "  compiler: ocamlc $OCAMLC_VERSION (system; ADR-0005 blocks the Hardcaml"
  say "            toolchain, not this)"
  for i in "${!LANE1_DIRS[@]}"; do
    say "  library ${LANE1_LIBS[$i]}  <- ${LANE1_DIRS[$i]#$REPO/}  (deps: ${LANE1_DEPS[$i]:-none})"
  done
  local all1="$lane1_alias $lane1_units $lane1_wrap"
  if compile_fixpoint "$build1" "$all1"; then
    say "  RESULT: $(printf '%s\n' $all1 | grep -c .) units compiled, 0 errors"
  else
    say "  RESULT: FAILED"
    report_failures "$build1"
    rc=1
  fi

  # ---- lane 2
  hdr "LANE 2 — Hardcaml-facing DV libraries, against tools/precompile_stubs/"
  mkdir -p "$build2"
  # the lane-1 libraries, already compiled, keep their own directories
  for i in "${!LANE1_LIBS[@]}"; do
    cp -r "$build1/${LANE1_LIBS[$i]}" "$build2/" 2>/dev/null
  done
  # one directory per stubbed package name, so a library sees a stub only if
  # its dune file declares that package
  mkdir -p "$build2/.stub_hardcaml" "$build2/.stub_ifc_check" "$build2/.stub_hardcaml_axi"
  cp "$STUBS/hardcaml.ml" "$STUBS/base.ml" "$build2/.stub_hardcaml/" 2>/dev/null
  cp "$STUBS/ifc_check.ml" "$build2/.stub_ifc_check/" 2>/dev/null
  printf -- '-I .\n' > "$build2/.incl..stub_hardcaml"
  printf -- '-I .\n' > "$build2/.incl..stub_ifc_check"
  local stub_units=".stub_hardcaml/base .stub_hardcaml/hardcaml .stub_ifc_check/ifc_check"
  UNITS=""; ALIAS_UNITS=""; WRAP_UNITS=""
  triples=()
  for i in "${!LANE2_DIRS[@]}"; do
    triples+=("${LANE2_DIRS[$i]}" "${LANE2_LIBS[$i]}" "${LANE2_DEPS[$i]}")
  done
  materialise_lane "$build2" "${triples[@]}" || return 2
  for i in "${!LANE2_DIRS[@]}"; do
    say "  library ${LANE2_LIBS[$i]}  <- ${LANE2_DIRS[$i]#$REPO/}  (deps: ${LANE2_DEPS[$i]})"
  done
  say "  stubs:  hardcaml (+base) and ifc_check, each visible only to a library"
  say "          whose dune file declares it"
  local all2="$stub_units $ALIAS_UNITS $UNITS $WRAP_UNITS"
  if compile_fixpoint "$build2" "$all2"; then
    say "  RESULT: $(printf '%s\n' $all2 | grep -c .) units compiled, 0 errors"
  else
    say "  RESULT: FAILED"
    report_failures "$build2"
    rc=1
  fi

  PASS_MATERIALISED="$MATERIALISED"
  return "$rc"
}

# ------------------------------------------------------------------ #
# main                                                                #
# ------------------------------------------------------------------ #

say "precompile_check — DV OCaml type-check harness"
say "repo: $REPO"
say "ocamlc: $OCAMLC_VERSION (system compiler; the Hardcaml toolchain is absent by ADR-0005)"
say ""
say "A green run proves NAME RESOLUTION, ARITIES, LABELS and TYPES in the DV"
say "libraries below. It runs no test, judges no [%expect] snapshot, and is not"
say "authoritative for the real Hardcaml API — CI is (ADR-0005)."

discover
drc=$?
if [ "$drc" -ne 0 ]; then exit 2; fi

if [ "${#LANE1_DIRS[@]}" -eq 0 ] && [ "${#LANE2_DIRS[@]}" -eq 0 ]; then
  say "precompile_check: MACHINERY ERROR — discovery classified no library at all."
  exit 2
fi

WORK="$(mktemp -d "${TMPDIR:-/tmp}/precompile_check.XXXXXX")" || exit 2

STATUS=0

if [ "$SELFTEST" -eq 1 ]; then
  hdr "SELF-TEST — does the harness catch what it claims to catch?"
  say "  Three seeded defects. Each is a class this harness CLAIMS to see, and"
  say "  each must be CAUGHT. This mode judges the HARNESS, never the tree: it"
  say "  reports no verdict about test/**."
  say ""
  say "  A harness whose teeth are never exercised can be blunted by a"
  say "  well-meaning simplification without anything going red — the same"
  say "  argument tools/check_emitted_verilog.sh --self-test makes for REQ-001."

  st_unit_of() {  # first materialisable unit of library $1, as <lib>/<unit>
    local lib="$1" i f
    for i in "${!LANE1_LIBS[@]}"; do
      [ "${LANE1_LIBS[$i]}" = "$lib" ] || continue
      for f in "${LANE1_DIRS[$i]}"/*.ml; do
        [ -e "$f" ] || continue
        printf '%s/%s__%s' "$lib" "$lib" "$(cap "$(basename "$f" .ml)")"
        return 0
      done
    done
    return 1
  }
  st_module_of() {  # first module name of library $1
    local lib="$1" i f
    for i in "${!LANE1_LIBS[@]}"; do
      [ "${LANE1_LIBS[$i]}" = "$lib" ] || continue
      for f in "${LANE1_DIRS[$i]}"/*.ml; do
        [ -e "$f" ] || continue
        cap "$(basename "$f" .ml)"
        return 0
      done
    done
    return 1
  }

  st_case() {  # $1 label, $2 mutation, $3 expected error substring, $4 note
    local out
    hdr "  seeded defect: $1"
    out="$(run_pass "$2" 2>&1)"
    if printf '%s' "$out" | grep -q -- "$3"; then
      say "  CAUGHT — \"$3\". $4"
    else
      say "  !!! NOT CAUGHT — expected \"$3\" and did not get it."
      printf '%s\n' "$out" | sed 's/^/      /'
      STATUS=1
    fi
  }

  # ---- defect 1: the WO-0033 escape's exact class, a name with no binding.
  st_target="$(st_unit_of "${LANE1_LIBS[0]}")"
  if [ -z "$st_target" ]; then
    say "  MACHINERY ERROR — no lane-1 unit to seed into."
    exit 2
  fi
  st_case "unbound value (the injection.ml:380 class)" \
    "$st_target:let _precompile_self_test1 = precompile_self_test_unbound_value" \
    "Unbound value" \
    "This is the class that produced the programme's first Build escape."

  # ---- defect 2: a sibling-library module named WITHOUT its library prefix,
  # inside a library that legitimately DECLARES that sibling. dune rejects it;
  # a flat -I harness resolves it and passes. This is the wrapping tooth.
  d2_target=""; d2_mod=""
  for i in "${!LANE1_LIBS[@]}"; do
    for dep in ${LANE1_DEPS[$i]}; do
      case "$dep" in dv_*) ;; *) continue ;; esac
      d2_mod="$(st_module_of "$dep")" || continue
      [ -n "$d2_mod" ] && { d2_target="$(st_unit_of "${LANE1_LIBS[$i]}")"; break 2; }
    done
  done
  if [ -n "$d2_target" ] && [ -n "$d2_mod" ]; then
    st_case "unqualified reference to a DECLARED sibling library's module ($d2_mod)" \
      "$d2_target:let _precompile_self_test2 = $d2_mod.__precompile_self_test" \
      "Unbound module $d2_mod" \
      "The wrapping replication is doing its job: a flat -I would have passed this."
  else
    say "  seeded defect 2 SKIPPED: no lane-1 library declares a lane-1 sibling."
  fi

  # ---- defect 3: a FULLY QUALIFIED reference to a library the target does NOT
  # declare. Correctly written OCaml, wrong dune file. This is the
  # include-path tooth, and it is what a single shared build directory misses.
  d3_target=""; d3_lib=""
  for i in "${!LANE1_LIBS[@]}"; do
    for j in "${!LANE1_LIBS[@]}"; do
      [ "$i" = "$j" ] && continue
      case " ${LANE1_DEPS[$i]} " in *" ${LANE1_LIBS[$j]} "*) continue ;; esac
      d3_target="$(st_unit_of "${LANE1_LIBS[$i]}")"
      d3_lib="${LANE1_LIBS[$j]}"
      break 2
    done
  done
  if [ -n "$d3_target" ] && [ -n "$d3_lib" ]; then
    st_case "qualified reference to an UNDECLARED library ($(cap "$d3_lib"))" \
      "$d3_target:let _precompile_self_test3 = $(cap "$d3_lib").__precompile_self_test" \
      "Unbound module $(cap "$d3_lib")" \
      "Per-library include paths are isolating as dune's do."
  else
    say "  seeded defect 3 SKIPPED: every lane-1 library declares every other."
  fi

  hdr "SELF-TEST VERDICT"
  if [ "$STATUS" -eq 0 ]; then
    say "  self-test: OK — every seeded defect was caught."
    say "  The harness has said nothing about test/**; run it without --self-test"
    say "  for that."
  else
    say "  self-test: FAILED — do not read a green lane from this harness until"
    say "  this passes."
  fi
  exit "$STATUS"
fi

run_pass clean
prc=$?
if [ "$prc" -eq 2 ]; then exit 2; fi
[ "$prc" -ne 0 ] && STATUS=1

LANE2B_UNVERIFIED=0
hdr "LANE 2b — stub fidelity (are the transcriptions still true?)"
if ! lane2b; then STATUS=1; fi

hdr "LANE 3a — coverage sweep (can this harness's claim have gone stale?)"
declare -i counted=0
for i in "${!LANE1_DIRS[@]}"; do
  n=$(ls "${LANE1_DIRS[$i]}"/*.ml "${LANE1_DIRS[$i]}"/*.mli 2>/dev/null | wc -l)
  counted=$((counted + n))
  say "  LANE1   ${LANE1_DIRS[$i]#$REPO/}  ($n files)"
done
for i in "${!LANE2_DIRS[@]}"; do
  n=$(ls "${LANE2_DIRS[$i]}"/*.ml "${LANE2_DIRS[$i]}"/*.mli 2>/dev/null | wc -l)
  counted=$((counted + n))
  say "  LANE2   ${LANE2_DIRS[$i]#$REPO/}  ($n files)"
done
for line in "${EXCLUDED_LINES[@]}"; do
  say "  EXCLUDED ${line%%|*} — ${line#*|}"
done
undisposed=0
for d in "$TEST_ROOT"/*/; do
  d="${d%/}"
  case "$(basename "$d")" in attack_plans | golden_data) continue ;; esac
  if [ ! -e "$d/dune" ]; then
    orphans=0
    for g in "$d"/*.ml "$d"/*.mli; do [ -e "$g" ] && orphans=1; done
    if [ "$orphans" -eq 1 ]; then
      say "  !!! ${d#$REPO/} holds OCaml sources but no dune file — no disposition"
      say "      is possible, so this harness cannot say whether they are checked."
      undisposed=1
    fi
  fi
done
if [ "$counted" -ne "${PASS_MATERIALISED:-0}" ]; then
  say "  !!! coverage mismatch: $counted files in compiled directories,"
  say "      ${PASS_MATERIALISED:-0} materialised into the build. Some file was not checked."
  STATUS=1
elif [ "$undisposed" -ne 0 ]; then
  STATUS=1
else
  say "  RESULT: $counted files in compiled directories, all $counted materialised and compiled."
  say "  Every directory under test/ carrying OCaml sources has a disposition above."
fi

hdr "LANE 3b — qualification sweep (no bare sibling-library module names)"
say "  comments are stripped first, so a module named in prose is not a finding."
if lane3b; then
  say "  RESULT: no unqualified sibling-library reference."
else
  say "  RESULT: FAILED"
  STATUS=1
fi

if [ "$WARNINGS" -eq 1 ]; then
  hdr "ADVISORY — warnings-on pass over real sources (never fails the run)"
  wcount=0
  for f in "$WORK"/lane1/*/*.ml "$WORK"/lane2/*/*.ml; do
    [ -e "$f" ] || continue
    b="$(basename "$f" .ml)"
    case "$b" in *__ | hardcaml | ifc_check | base) continue ;; esac
    case " $(printf '%s ' "${LANE1_LIBS[@]}" "${LANE2_LIBS[@]}") " in *" $b "*) continue ;; esac
    o="$( cd "$(dirname "$f")" && ocamlc -c -no-alias-deps -I . $( [[ "$b" == *__*[!_] ]] && printf -- '-open %s__' "$(cap "${b%%__*}")" ) "$b.ml" 2>&1 )"
    if [ -n "$o" ]; then wcount=$((wcount + 1)); printf '  %s\n' "$b"; printf '%s\n' "$o" | sed 's/^/      /'; fi
  done
  [ "$wcount" -eq 0 ] && say "  no warnings in any real source unit."
fi

hdr "SUMMARY"
if [ "$STATUS" -eq 0 ]; then
  say "  precompile_check: ALL LANES PASSED"
  say "  ${LANE2B_UNVERIFIED} transcription(s) remain UNVERIFIED here and are settled only by CI"
  say "  (listed under LANE 2b). This run is NOT a substitute for \`dune build @default\`."
else
  say "  precompile_check: AT LEAST ONE LANE FAILED"
fi
[ "$KEEP" -eq 1 ] && say "  workspace kept at $WORK"
exit "$STATUS"
