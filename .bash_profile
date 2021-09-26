[[ "$DEBUG_STARTUP:" == "1:" ]] && echo "Executing $HOME/.bash_profile from the top"
export BASH_PROFILE_RUN=1
if [ -z "$BASHRC_RUN" ]; then
	# bash_rc has been run
	source $HOME/.bashrc
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

. "$HOME/.cargo/env"
[[ -f ~/.bashrc ]] && source ~/.bashrc # ghcup-env
