#!/usr/local/bin/bash
#
# recreate_completions.sh
# Copyright (C) 2020 David Rosenberg <dmr@davidrosenberg.me>
#
# Create bash completion scripts instead of having them generated from their
# respective commands at login.  This should be run regularly from 
# cron.
#
# Distributed under terms of the MIT license.
#

COMPLETION_DIR="$HOME/bash_completion.d"
LOGFILE="$HOME/.cache/log/recreate_completions.log"
tmpfile="$(mktemp -t rcrt.compl)"
script_status=0

cleanup() {
  rm -f "$tmpfile"
}
trap cleanup EXIT

# General format:
# CMD > "$tmpfile" 2>/dev/null && \
#   mv "$tmpfile" "$COMPLETION_DIR/CMD"  && \
#   echo "$(date): Recreated CMD completion script" | tee -a "$LOGFILE" || \
#   echo "$(date): Unable to regenerate CMD completion script" | tee -a "$LOGFILE" > /dev/stderr && \
#   false
# script_status=$((script_status+$?))

#stack

/usr/local/bin/stack --bash-completion-script stack > "$tmpfile" 2>/dev/null && \
  mv "$tmpfile" "$COMPLETION_DIR/stack"  && \
  echo "$(date): Recreated stack completion script" | tee -a "$LOGFILE" || \
  echo "$(date): Unable to regenerate stack completion script" | tee -a "$LOGFILE" > /dev/stderr && \
  false
script_status=$((script_status+$?))

#pandoc

/Users/davidrosenberg/.cabal/bin/pandoc --bash-completion > "$tmpfile" 2>/dev/null && \
  mv "$tmpfile" "$COMPLETION_DIR/pandoc"  && \
  echo "$(date): Recreated pandoc completion script" | tee -a "$LOGFILE" || \
  echo "$(date): Unable to regenerate pandoc completion script" | tee -a "$LOGFILE" > /dev/stderr && \
  false
script_status=$((script_status+$?))

#pandoc
/usr/local/bin/pip completion --bash > "$tmpfile" 2>/dev/null && \
  mv "$tmpfile" "$COMPLETION_DIR/pip"  && \
  echo "$(date): Recreated pip completion script" | tee -a "$LOGFILE" || \
  echo "$(date): Unable to regenerate pip completion script" | tee -a "$LOGFILE" > /dev/stderr && \
  false
script_status=$((script_status+$?))

#npm
#/Users/davidrosenberg/.nvm/versions/node/v16.0.0/bin/npm completion bash > "$tmpfile" 2>/dev/null && \
/usr/local/bin/npm completion bash > "$tmpfile" 2>/dev/null && \
  mv "$tmpfile" "$COMPLETION_DIR/npm" && \
  echo "$(date): Recreated npm completion script" | tee -a "$LOGFILE" || \
  echo "$(date): Unable to regenerate npm completion script" | tee -a "$LOGFILE" > /dev/stderr && \
  false
script_status=$((script_status+$?))


trap - EXIT
rm -f "$tmpfile" 
exit $script_status

# vim: ft=sh
