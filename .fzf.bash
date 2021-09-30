#!/usr/bin/env bash

# Setup fzf
# ---------
FZFPATH="$HOMEBREW_PREFIX/opt/fzf"
if [[ ! "$PATH" == */fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/${FZFPATH}/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZFPATH/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$FZFPATH/shell/key-bindings.bash"

# vim : ft=sh :
