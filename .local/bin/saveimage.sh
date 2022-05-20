#!/opt/homebrew/bin/bash

# set -x
PATH=$HOME/.local/bin:/opt/homebrew/bin:$HOME/.nvm:$HOME/go/bin:$PATH

source "/Users/dmr/.nvm/nvm.sh"
nvm use 16.10

osxalert() {
  message=${1:-"Message"}
  /usr/bin/osascript <<-EndOfScript
button returned of ¬
(display dialog "$message" ¬
buttons {"OK","Cancel"} ¬
default button "OK")
EndOfScript

}

tmp="$(gmktemp)"
fname="$("$HOME/.local/bin/jxaprompt" "Image base name")"
cd "$HOME" || exit 1
if [ -f "$HOME/tmp/$fname.png" ]; then
  osxalert "ERROR $fname.png exists!"
  exit 1
else
  if ! pngpaste "$tmp"; then
    osxalert "ERROR, no image in clipboard"
    exit 1
  fi
  mv "$tmp" "$HOME/tmp/$fname.png"
fi
open "$HOME/tmp/$fname.png"
