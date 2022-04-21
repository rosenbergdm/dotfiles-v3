#!/opt/homebrew/bin/zsh

exec /opt/homebrew/bin/alacritty -e $HOME/.local/bin/lvim "$@" &!
exit
