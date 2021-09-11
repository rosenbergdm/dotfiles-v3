#!/usr/local/bin/bash
# shellcheck disable=SC1090
# SC1090: Not all references will be resolvable

# set -E
# set -o functrace
shopt -s autocd

set_iterm_title() {
	if [[ "${TERM_PROGRAM}p" == "iTerm.appp" ]]; then
		echo -ne "\033]0;$*\007"
	fi
}

if [ -a $HOME/DEBUG_STARTUP ]; then
	if [[ "$(cat $HOME/DEBUG_STARTUP)" == "" ]]; then
		file_dbg_startup=1
	else
		file_dbg_startup=$(cat $HOME/DEBUG_STARTUP)
	fi
fi
export DEBUG_STARTUP=${DEBUG_STARTUP-${file_dbg_startup-0}}

export FAST_STARTUP=${FAST_STARTUP-0}
if [ -a "$HOME/FAST_STARTUP" ]; then
	printf "%s\n\n" "Fast startup enabled by environment variable '\$FAST_STARTUP'"
	if [[ "$(head -n30 "$HOME/FAST_STARTUP")" == "" ]]; then
		file_fast_startup=1
	else
		file_fast_startup="$(head -n1 "$HOME/FAST_STARTUP")"
	fi
	FAST_STARTUP=$file_fast_startup
elif [ "${FAST_STARTUP-0}" -gt 0 ]; then
	printf "%s\n\n" "Fast startup enabled by file '$HOME/FAST_STARTUP'"
else
	read -n1 -r -t0.1 -s _startfast || true
	if [[ "$_startfast" == "f" ]] || [[ "$_startfast" == "F" ]]; then
		printf "%s\n\n" "Fast starup enabled by keypress"
		FAST_STARTUP=1
	fi
fi
export FAST_STARTUP

[[ "$DEBUG_STARTUP" -gt 0 ]] && echo "Executing $HOME/.bashrc from the top" 1>&2
export BASHRC_RUN=1

declare -a STARTUP_SOURCED=()
declare -a MY_FUNCTIONS=()
STARTUP_SOURCED+=("$HOME/bashrc")
set_iterm_title "Loading '$HOME/.commands'"
source "$HOME/.commands"
# This is where we get "$PRINTF", etc
STARTUP_SOURCED+=("$HOME/.commands")
declare -A thresholds=([4]="4" [3]="3" [2]="2" [1]="1" [0]="0"
	[trace]="4" [info]="3" [warn]="2" [error]="1" [always]="0")
export MY_FUNCTIONS
export thresholds
export STARTUP_SOURCED

# debug messaging {{{
_dbg() {
	_usage="
    cat<<-EOF
    USAGE: _dbg MESSAGE [level] [-n]

      MESSAGE:    The debugging message you want displayed
      level:      One of the threshold levels or its corresponding integer: 
                    4, 3, 2, 1 and 0, and trace, info, warn, error, always.
      [-n]:       Don't print a trailing newline


    $ > _dbg 'TESTING' always
    TESTING

  "
	if [ -z "$1" ]; then
		gprintf "%s\n" "$_usage"
		return 1
	elif [ -n "$2" ]; then
		if [ -z "${thresholds[$2]}" ]; then
			echo "ERROR: level doesn't correspond to a correct level"
			gprintf "%s\n" "$_usage"
		fi
	fi

	local thresh=${thresholds["${2:-1}"]}
	if [[ "${3}p" == "p" ]] && [[ ${3-0} == "-n" ]]; then
		local newline=''
	else
		local newline='\n'
	fi

	if [ "${DEBUG_STARTUP-0}" -ge "$thresh" ]; then
		gprintf "%s$newline" "$1"
	fi
}

MY_FUNCTIONS+=(_dbg)

set_debug() {
	local lv=${1-always}
	export DEBUG_STARTUP=${thresholds[$lv]}
	echo "Set DEBUG_STARTUP to '${thresholds[$lv]}'"
}
MY_FUNCTIONS+=(set_debug)

source_and_log() {
	local cmdfile="$1"
	local status=1
	local completionfile=${2-THISIS_NOT_A_FILE}
	set_iterm_title "Running '$cmdfile'"
	_dbg "Attempting to load '$cmdfile'..." error -n
	if [ -e "$cmdfile" ]; then
		if [[ ${STARTUP_SOURCED[*]} =~ (^|[[:space:]])"$($BASENAME "$cmdfile")"($|[[:space:]]) ]]; then
			_dbg " FAIL.  Already sourced." error
		else
			source "$cmdfile"
			status=0
			if [ $? -gt 0 ]; then
				_dbg " FAIL.  Error sourcing." error
			else
				_dbg " Success."
				STARTUP_SOURCED+=("$($BASENAME "$cmdfile")")
				if [ -e $completionfile ]; then
					set_iterm_title "Loading completions for '$completionfile'"
					source "$completionfile"
					if [ $? -gt 0 ]; then
						_dbg "Attempting to load completions '$completionfile'... FAIL.  Error loading" error
						status=1
					else
						_dbg "Attempting to load completions '$completionfile'... Success." error
						status=0
					fi
				fi
			fi
		fi
	else
		_dbg " FAIL.  File does not exist."
	fi
	set_iterm_title "bash"
	return $status
}
MY_FUNCTIONS+=(source_and_log)
# }}}

if [ -z "$BASH_PROFILE_RUN" ]; then
	source_and_log ~/.bash_profile
fi

for file in ~/.{functions,path,exports,aliases,bash_prompt}; do
	source_and_log "$file"
done

# For bash_completion@2
if [[ $FAST_STARTUP == 0 ]]; then
	set_iterm_title "Loading completions"
	if [ -f /usr/local/etc/profile.d/bash_completion.sh ]; then
		# This will end up sourcing "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion"
		# Then it will read from the following dirs for commands of the form 'cmd', 'cmd.bash' or '_cmd':
		#   ${BASH_COMPLETION_USER_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion}/completions
		#   ${XDG_DATA_DIRS:-/usr/local/share:/usr/share}/*/bash-completion/completions
		#   ${BASH_SOURCE%/}/completions (for scripts) or ./completions (for not being in a script)
		# For each of these it will load the completion when the command is required
		# TLDR
		#   Dynamically loaded completions go in  $HOME/.local/share/bash-completion/completions
		#   Eagerly loaded completions should be loaded by $HOME/.config/bash/completion
		#   In the end completions stored in $HOME/.bash_completion will be executed
		source_and_log /usr/local/etc/profile.d/bash_completion.sh
		___git_complete dfg __git_main
	fi
	set_iterm_title "bash"
fi

if [[ $FAST_STARTUP == 0 ]]; then
	source_and_log "$HOME/.extra"
	[ -f ~/.fzf.bash ] && source_and_log ~/.fzf.bash
else
	_dbg "Skipping $HOME/.extra and fzf loading for speed"
fi

# vim: ft=sh :
