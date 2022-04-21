#!/bin/sh

if [ "$1" ]; then
  /Users/dmr/src/ro-tools/scripts/time-between "$1" | pbcopy
else
  /Users/dmr/src/ro-tools/scripts/time-between "`pbpaste`" | pbcopy
fi
pbpaste
