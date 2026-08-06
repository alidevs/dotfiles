#!/usr/bin/env bash
# Guarded kill for panes/windows running a protected program.
#   guard-kill.sh pane|window <pane_id>       - entry point, bound to keys
#   guard-kill.sh confirm <scope> <id> <word> - internal, called by the prompt
#
# Note: ids are passed without their sigil ('%'/'@'). command-prompt rewrites
# every %N token in its template, so a literal pane id would be clobbered by
# whatever the user types.
set -euo pipefail

PROTECTED_RE="${TMUX_GUARD_KILL_RE:-^(herdr)$}"
self="${BASH_SOURCE[0]}"
scope="${1:-pane}"

if [ "$scope" = confirm ]; then
  case "$2" in
    pane) [ "${4:-}" = kill ] && exec tmux kill-pane -t "%$3" ;;
    window) [ "${4:-}" = kill ] && exec tmux kill-window -t "@$3" ;;
  esac
  exec tmux display-message "kill aborted"
fi

target="${2:-${TMUX_PANE:?guard-kill needs a target pane}}"

case "$scope" in
  pane)
    running=$(tmux display-message -p -t "$target" '#{pane_current_command}')
    id=$(tmux display-message -p -t "$target" '#{pane_id}')
    label=$(tmux display-message -p -t "$target" '#{session_name}:#{window_index}.#{pane_index}')
    quick="confirm-before -p 'kill-pane $label? (y/n)' 'kill-pane -t $id'"
    ;;
  window)
    running=$(tmux list-panes -t "$target" -F '#{pane_current_command}')
    id=$(tmux display-message -p -t "$target" '#{window_id}')
    label=$(tmux display-message -p -t "$target" '#{session_name}:#{window_index}')
    quick="confirm-before -p 'kill-window $label? (y/n)' 'kill-window -t $id'"
    ;;
  *)
    tmux display-message "guard-kill: unknown scope '$scope'"
    exit 1
    ;;
esac

if grep -Eq "$PROTECTED_RE" <<<"$running"; then
  hit=$(grep -Eo "$PROTECTED_RE" <<<"$running" | head -1)
  tmux command-prompt -p "$scope runs $hit — type 'kill' to confirm:" \
    "run-shell \"'$self' confirm $scope ${id#[%@]} '%1'\""
else
  # shellcheck disable=SC2086
  eval tmux $quick
fi
