[[ "$DEBUG_STARTUP:" == "1:" ]] && echo "RUNNING $HOME/.profile"
# export PROFILE_RUN=1
# if [  -z "$BASHRC_RUN" ]; then
#   # .bashrc has not been run
#   . $HOME/.bashrc
# fi


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PATH="$HOME/.cargo/bin:$PATH"

PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH
alias gmvault=/usr/local/bin/gmvault

set_python_2() {
    export PYTHONPATH=/usr/local/lib/python2.7/site-packages:~/Library/Python/2.7/lib/python/site-packages
    alias ipython="$(which ipython2)"
    alias python="$(which python2.7)"
    alias pip="$(which pip2.7)"
}

set_python_3() {
    unset PYTHONPATH
    alias ipython="$(which ipython3)"
    alias python="$(which python3)"
    alias pip="$(which pip3)"
}

set_python_2

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=-1
export HISTFILESIZE=-1
shopt -s histappend

[ -s "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
rvm use 3.0

export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && source_and_log "$NVM_DIR/nvm.sh"  # This loads nvm
nvm use 16.0
