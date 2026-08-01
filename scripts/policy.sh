#!/usr/bin/env bash
# policy.sh — shared policy + helpers for the journal/commit protocol.
# Sourced by agent_commit.sh and check_journals.sh. See agents/PROTOCOL.md §5-6.

KNOWN_AGENTS="orchestrator architect_docs_lead rtl_lead rtl_lead_md dv_lead auditor rtl_module_dev tb_writer data_wrangler formal_dv"
WORKER_AGENTS="rtl_module_dev tb_writer data_wrangler formal_dv"

is_known_agent() {
  local a
  for a in $KNOWN_AGENTS; do [ "$a" = "$1" ] && return 0; done
  return 1
}

is_worker_agent() {
  local a
  for a in $WORKER_AGENTS; do [ "$a" = "$1" ] && return 0; done
  return 1
}

# Journal file path for an agent identity.
journal_path_for() {
  if is_worker_agent "$1"; then
    echo "agents/journals/workers/claude_$1_agent.md"
  else
    echo "agents/journals/claude_$1_agent.md"
  fi
}

# Is this path a journal file? (INDEX.md and other files under agents/journals/
# are ordinary work products.)
is_journal_path() {
  case "$1" in
    agents/journals/claude_*_agent.md) return 0 ;;
    agents/journals/workers/claude_*_agent.md) return 0 ;;
    *) return 1 ;;
  esac
}

# Path isolation (PROTOCOL §6): may <agent> stage <path> as a work product?
agent_may_write() {
  local agent="$1" path="$2"
  case "$agent" in
    orchestrator)
      return 0 ;;
    architect_docs_lead)
      case "$path" in
        docs/reports/audit/*|docs/reports/latency/*) return 1 ;;
        docs/*|README.md|ORG_CHART.md|agents/handoffs/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    rtl_lead|rtl_lead_md)
      case "$path" in
        libs/*|top/*|bin/*|rtl_snapshots/*|agents/handoffs/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    dv_lead)
      case "$path" in
        test/*|tools/*|docs/reports/latency/*|agents/handoffs/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    auditor)
      case "$path" in
        docs/reports/audit/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    rtl_module_dev)
      case "$path" in
        libs/*|top/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    tb_writer)
      case "$path" in
        test/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    data_wrangler)
      case "$path" in
        tools/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    formal_dv)
      case "$path" in
        test/*) return 0 ;;
        *) return 1 ;;
      esac ;;
    *)
      return 1 ;;
  esac
}

# Print the last (highest) 4-digit entry number found in journal content on
# stdin, for the given agent; prints 0000 if none.
last_entry_num() {
  local agent="$1"
  local last
  last=$(grep -oE "^## \[J-${agent}-[0-9]{4}\]" | grep -oE '[0-9]{4}' | tail -n 1 || true)
  if [ -z "$last" ]; then echo "0000"; else echo "$last"; fi
}

# Count entry headers for the given agent in content on stdin.
count_entries() {
  local agent="$1"
  grep -cE "^## \[J-${agent}-[0-9]{4}\]" || true
}

# From appended journal text on stdin, print the Files-in-this-commit list
# (one path per line; empty output means the list was `- (none)` or absent).
extract_files_list() {
  awk '
    /^### Files-in-this-commit[[:space:]]*$/ { grab = 1; next }
    grab && /^#/ { grab = 0 }
    grab && /^- / {
      p = substr($0, 3)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", p)
      if (p != "(none)") print p
    }
  '
}

# Does the appended journal text on stdin contain a Files-in-this-commit
# section at all?
has_files_section() {
  grep -qE '^### Files-in-this-commit[[:space:]]*$'
}

# Byte-prefix check: is file $1 a byte-prefix of file $2?
is_byte_prefix() {
  local old="$1" new="$2"
  local old_size new_size
  old_size=$(wc -c < "$old")
  new_size=$(wc -c < "$new")
  [ "$old_size" -le "$new_size" ] || return 1
  head -c "$old_size" "$new" | cmp -s - "$old"
}

fail() {
  echo "PROTOCOL VIOLATION: $*" >&2
  exit 1
}
