#!/bin/bash
# Status line converted from ~/.zshrc PS1 (Catppuccin Mocha prompt).
# Original PS1:
#   %F{#89b4fa}%n%f @ %F{#cba6f7}%m%f in %F{#a6e3a1}%~%f ${vcs_info_msg_0_}
#   %F{#f5c2e7}❯%f

input=$(cat)
# One jq for the whole payload. Fields are US-separated so empty ones survive the
# read (tabs are IFS whitespace and would collapse); numbers arrive pre-floored.
vals=$(printf '%s' "$input" | jq -r '
  [ .workspace.current_dir,
    .model.display_name,
    .context_window.used_percentage,
    .effort.level,
    .vim.mode,
    .rate_limits.five_hour.used_percentage,
    .rate_limits.five_hour.resets_at,
    .rate_limits.seven_day.used_percentage,
    .rate_limits.seven_day.resets_at,
    .pr.number,
    .pr.url
  ] | map(if type == "number" then floor else . // "" end | tostring) | join("")' 2>/dev/null)
IFS=$'\x1f' read -r dir model pct effort vim five five_reset week week_reset pr_num pr_url <<< "$vals"

display_dir="${dir/#$HOME/~}"
# fish-style: every segment but the last shrinks to its first character
# (~/src/cburmeister/x -> ~/s/c/x); dot-segments keep two (.config -> .c)
IFS=/ read -ra segs <<< "$display_dir"; short=""
for i in "${!segs[@]}"; do
  seg=${segs[$i]}
  if [ "$i" -eq $(( ${#segs[@]} - 1 )) ] || [ "$seg" = "~" ] || [ -z "$seg" ]; then short+="$seg"
  else case $seg in .?*) short+="${seg:0:2}";; *) short+="${seg:0:1}";; esac; fi
  [ "$i" -lt $(( ${#segs[@]} - 1 )) ] && short+="/"
done
display_dir=$short

branch=""; dirty=""; ab=""
if git -C "$dir" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null)
  # detached HEAD (rebases, worktree flows): still say where we are
  [ -n "$branch" ] || branch=$(git -C "$dir" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  [ -n "$(git -C "$dir" --no-optional-locks status --porcelain 2>/dev/null | head -1)" ] && dirty="*"
  read -r behind ahead <<< "$(git -C "$dir" --no-optional-locks rev-list --left-right --count '@{u}...HEAD' 2>/dev/null || echo "0 0")"
  [ "${ahead:-0}" -gt 0 ] && ab+="↑$ahead"; [ "${behind:-0}" -gt 0 ] && ab+="↓$behind"
fi

MAUVE='\033[38;2;203;166;247m'
GREEN='\033[38;2;166;227;161m'
RED='\033[38;2;243;139;168m'
RESET='\033[0m'

YELLOW='\033[38;2;249;226;175m'
DIM='\033[2m'

vcs=""
if [ -n "$branch" ]; then
  vcs=" on ${RED}${branch}${dirty}${RESET}"; [ -n "$ab" ] && vcs+=" ${DIM}${ab}${RESET}"
fi
if [ -n "$pr_num" ]; then   # OSC 8 hyperlink: clickable in Ghostty
  vcs+=" ${DIM}·${RESET} \033]8;;${pr_url}\033\\PR #${pr_num}\033]8;;\033\\"
fi

# context usage: green under 50%, yellow under 80%, red after; blank until the first turn reports it
ctx=""
if [ -n "$pct" ]; then
  c=$GREEN; [ "$pct" -ge 50 ] && c=$YELLOW; [ "$pct" -ge 80 ] && c=$RED
  ctx=" ${DIM}·${RESET} ${c}${pct}%${RESET} ctx"
fi

# account usage limits (5-hour and 7-day windows): dim under 50%, yellow from 50, red from 80,
# with time-to-reset once past 50%.
until_reset() {   # until_reset <epoch> -> "37m" / "2h30" / "1d4h" / ""
  [ -n "$1" ] || return 0; local m=$(( ($1 - $(date +%s)) / 60 )); [ "$m" -gt 0 ] || return 0
  if [ "$m" -ge 1440 ]; then printf '%dd%dh' $((m/1440)) $((m%1440/60))
  elif [ "$m" -ge 60 ]; then printf '%dh%02d' $((m/60)) $((m%60))
  else printf '%dm' "$m"; fi
}
# Per-model weekly limit (the footer's "N% of your Fable 5 limit"). Not in the statusline
# payload, so ask the same endpoint /usage uses, with the OAuth token Claude Code keeps in
# the Keychain. A render never waits on the network: it shows whatever the cache holds and
# refreshes in the background. The touch is the debounce - one refresher per 60s window,
# however many sessions render meanwhile. STATUSLINE_NO_USAGE=1 skips it all (tests).
refresh_usage() {   # replace the cache; any failure leaves the old one in place
  local cache=$1 tok tmp
  tok=$(security find-generic-password -s 'Claude Code-credentials' -w 2>/dev/null | jq -r '.claudeAiOauth.accessToken // empty') || return 0
  [ -n "$tok" ] || return 0
  tmp=$(mktemp "$cache.XXXXXX" 2>/dev/null) || return 0
  if curl -sS -m 5 -H "Authorization: Bearer $tok" -H 'anthropic-beta: oauth-2025-04-20' \
       https://api.anthropic.com/api/oauth/usage -o "$tmp" 2>/dev/null && [ -s "$tmp" ]; then
    mv "$tmp" "$cache"
  else rm -f "$tmp"; fi
}
model_usage() {
  [ -n "$model" ] && [ -z "$STATUSLINE_NO_USAGE" ] || return 0
  local cache="${TMPDIR:-/tmp}/claude-statusline-usage.json" full word
  if [ "$(( $(date +%s) - $(stat -f %m "$cache" 2>/dev/null || echo 0) ))" -gt 60 ]; then
    touch "$cache"; refresh_usage "$cache" >/dev/null 2>&1 &
  fi
  [ -s "$cache" ] || return 0
  # exact display-name match first, so "Sonnet 4.5" and "Sonnet 5" stay distinct; then the
  # first-word fallbacks: new shape limits[] scoped to a model, legacy seven_day_<model>
  full=$(printf '%s' "$model" | tr '[:upper:]' '[:lower:]'); word=${full%% *}
  jq -r --arg full "$full" --arg word "$word" '
    def by(f): [.limits[]? | select(((.scope.model.display_name // "") | ascii_downcase) | f)] | first | (.percent // .utilization);
    ( by(. == $full), by(contains($word)), .["seven_day_" + $word].utilization )
    | select(. != null)' "$cache" 2>/dev/null | head -1 | cut -d. -f1
}
lim=""
for pair in "5h:$five:$five_reset" "7d:$week:$week_reset"; do
  IFS=: read -r label val reset <<< "$pair"
  [ -n "$val" ] || continue
  c=$DIM; [ "$val" -ge 50 ] && c=$YELLOW; [ "$val" -ge 80 ] && c=$RED
  lim+=" ${DIM}·${RESET} ${c}${label} ${val}%${RESET}"
  r=""; [ "$val" -ge 50 ] && r=$(until_reset "$reset")
  [ -n "$r" ] && lim+=" ${DIM}[${r}]${RESET}"
done
mu=$(model_usage)
if [ -n "$mu" ]; then
  c=$DIM; [ "$mu" -ge 50 ] && c=$YELLOW; [ "$mu" -ge 80 ] && c=$RED
  lim+=" ${DIM}·${RESET} ${c}${model%% *} ${mu}%${RESET}"
fi

# vim: only NORMAL is worth announcing; INSERT is the resting state (pairs with hideVimModeIndicator)
mode=""
[ "$vim" = NORMAL ] && mode="${YELLOW}N${RESET} ${DIM}·${RESET} "

eff=""; [ -n "$effort" ] && eff=" ${DIM}${effort}${RESET}"
printf "%b${MAUVE}%s${RESET}%b%b%b ${DIM}·${RESET} ${GREEN}%s${RESET}%b" "$mode" "${model:-claude}" "$eff" "$ctx" "$lim" "$display_dir" "$vcs"
