#!/bin/bash
# Send the terminal bell to the pane's TTY so tmux flags the window tab.
# Hooks run without a controlling terminal, so /dev/tty fails with
# "Device not configured"; resolve the pane tty via $TMUX_PANE instead.
if [ -n "$TMUX_PANE" ]; then
  printf '\a' > "$(tmux display-message -p -t "$TMUX_PANE" '#{pane_tty}')"
else
  printf '\a' > /dev/tty 2>/dev/null
fi
