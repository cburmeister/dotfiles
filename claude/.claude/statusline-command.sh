#!/bin/bash
# Status line converted from ~/.zshrc PS1 (Catppuccin Mocha prompt).
# Original PS1:
#   %F{#89b4fa}%n%f @ %F{#cba6f7}%m%f in %F{#a6e3a1}%~%f ${vcs_info_msg_0_}
#   %F{#f5c2e7}❯%f

input=$(cat)
dir=$(printf '%s' "$input" | jq -r '.workspace.current_dir')
display_dir="${dir/#$HOME/~}"

user=$(whoami)
host=$(hostname -s)

branch=""
if git -C "$dir" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null)
fi

BLUE='\033[38;2;137;180;250m'
MAUVE='\033[38;2;203;166;247m'
GREEN='\033[38;2;166;227;161m'
RED='\033[38;2;243;139;168m'
RESET='\033[0m'

vcs=""
if [ -n "$branch" ]; then
  vcs=" on ${RED}${branch}${RESET}"
fi

printf "${BLUE}%s${RESET} @ ${MAUVE}%s${RESET} in ${GREEN}%s${RESET}%b" "$user" "$host" "$display_dir" "$vcs"
