#!/bin/sh

if [ "$1" ]; then
  /Users/dmr/src/ro-tools/scripts/time-between "$1" | "$HOME/.local/bin/expand-dates.sh" | pbcopy
else
  /Users/dmr/src/ro-tools/scripts/time-between "$(pbpaste)" | "$HOME/.local/bin/expand-dates.sh" | pbcopy
fi
pbpaste
