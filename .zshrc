# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_hist
HISTSIZE=100000000
SAVEHIST=100000000000
setopt autocd extendedglob
bindkey -v

fpath+=( \
  /opt/homebrew/share/zsh-completions \
  /opt/homebrew/share/zsh-vi-mode \
  /opt/homebrew/share/zsh/functions \
  /opt/homebrew/share/zsh/site-functions \
  /opt/homebrew/share/zsh-fast-syntax-highlighting \
  /opt/homebrew/share/zsh-navigation-tools \
  /opt/homebrew/share/zsh/site-functions \
  /usr/share/zsh/5.8/function \
  /usr/share/zsh/site-functions \
  "$HOME/.zshrc.d/functions" \
  "$HOME/.zshrc.d/completions" \
)

path+=( \
  $HOME/.local/bin \
  /opt/homebrew/bin \
  /Users/dmr/go/bin \
  /usr/local/Cellar/qt5/5.7.0/bin \
  /usr/local/bin \
  /usr/local/sbin \
  /opt/homebrew/opt/fzf/bin \
  /usr/bin \
  /bin \
  /usr/sbin \
  /sbin \
  /Applications/VMware Fusion.app/Contents/Public \
  /usr/local/go/bin \
  /usr/local/MacGPG2/bin \
  /opt/X11/bin \
  /Library/Apple/usr/bin \
  /Library/Frameworks/R.framework/Versions/Current/Resources/bin \
)

    setopt   BASH_AUTO_LIST NO_BEEP CLOBBER

  # Job Control
    setopt   CHECK_JOBS NO_HUP

  # History
    setopt   INC_APPEND_HISTORY
    setopt   EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
    setopt	 EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST
    setopt   HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS
    setopt   PRINT_EIGHT_BIT
    setopt   multios
    setopt   auto_param_keys
    setopt   auto_param_slash
    setopt   auto_remove_slash

  # Stay compatible to sh and IFS
    setopt	 SH_WORD_SPLIT

  # miscellanous
    setopt   recexact longlistjobs
    setopt   autoresume pushdsilent
    setopt   extendedglob
    setopt   autopushd pushdminus
    unsetopt mailwarning
    unsetopt HUP autoparamslash
    setopt   BG_NICE

    setopt   notify globdots
    setopt   INTERACTIVE_COMMENTS


      fignore=(.o .c~ .old .pro)
  export DIRSTACKSIZE=50

  eval `gdircolors`


  zmodload zsh/complist
autoload -U zstyle+

zmodload -a zsh/stat stat
zmodload -a zsh/zle zle
zmodload -a zsh/zpty zpty


alias ls="ls -a -G"
alias lsd='ls -ld *(-/DN)'
alias vim=/Users/dmr/.bin/lvim

source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh



#{{{

# ## completion system
#   zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )' # allow one error for every three characters typed in approximate completer
#   zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~' # don't complete backup files as executables
#   zstyle ':completion:*:correct:*'       insert-unambiguous true             # start menu completion only if it could find no unambiguous initial string
#   zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}' #
#   zstyle ':completion:*:correct:*'       original true                       #
#   zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}      # activate color-completion(!)
#   zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'  # format on completion
#   zstyle ':completion:*:*:cd:*:directory-stack' menu yes select              # complete 'cd -<tab>' with menu
#   zstyle ':completion:*:expand:*'        tag-order all-expansions            # insert all expansions for expand completer
#   zstyle ':completion:*:history-words'   list false                          #
#   zstyle ':completion:*:history-words'   menu yes                            # activate menu
#   zstyle ':completion:*:history-words'   remove-all-dups yes                 # ignore duplicate entries
#   zstyle ':completion:*:history-words'   stop yes                            #
#   zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'        # match uppercase from lowercase
#   zstyle ':completion:*:matches'         group 'yes'                         # separate matches into groups
#   zstyle ':completion:*'                 group-name ''
#   if [[ -z "$NOMENU" ]] ; then
#     zstyle ':completion:*'               menu select=5                       # if there are more than 5 options allow selecting from a menu
#   else
#     setopt no_auto_menu # don't use any menus at all
#   fi
#   zstyle ':completion:*:messages'        format '%d'                         #
#   zstyle ':completion:*:options'         auto-description '%d'               #
#   zstyle ':completion:*:options'         description 'yes'                   # describe options in full
#   zstyle ':completion:*:processes'       command 'ps -au$USER'               # on processes completion complete all user processes
#   zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters        # offer indexes before parameters in subscripts
#   zstyle ':completion:*'                 verbose true                        # provide verbose completion information
#   zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d' # set format for warnings
#   zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'       # define files to ignore for zcompile
#   zstyle ':completion:correct:'          prompt 'correct to: %e'             #
#   zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'    # Ignore completion functions for commands you don't have:

# # complete manual by their section
#   zstyle ':completion:*:manuals'    separate-sections true
#   zstyle ':completion:*:manuals.*'  insert-sections   true
#   zstyle ':completion:*:man:*'      menu yes select

# ## correction
# # run rehash on completion so new installed program are found automatically:
#   _force_rehash() {
#       (( CURRENT == 1 )) && rehash
#          return 1 # Because we didn't really complete anything
#     }
# # some people don't like the automatic correction - so run 'NOCOR=1 zsh' to deactivate it
#   if [[ -n "$NOCOR" ]] ; then
#     zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _files
#     setopt nocorrect # do not try to correct the spelling if possible
#   else
# #    zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _correct _approximate _files
#     setopt correct  # try to correct the spelling if possible
#     zstyle -e ':completion:*' completer '
#         if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]]; then
#           _last_try="$HISTNO$BUFFER$CURSOR"
#           reply=(_complete _match _prefix _files)
#         else
#           if [[ $words[1] = (rm|mv) ]]; then
#             reply=(_complete _files)
#           else
#             reply=(_oldlist _expand _force_rehash _complete _correct _approximate _files)
#           fi
#         fi'
#   fi

# # command for process lists, the local web server details and host completion
#   zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'
#
#   # caching
#   [ -d $ZSHDIR/cache ] && zstyle ':completion:*' use-cache yes && \
#                           zstyle ':completion::complete:*' cache-path $ZSHDIR/cache/

# # host completion /* add brackets as vim can't parse zsh's complex cmdlines 8-) {{{ */
#     [ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
#     [ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
#   hosts=(
#       `hostname`
#       "$_ssh_hosts[@]"
#       "$_etc_hosts[@]"
#       grml.org
#       localhost
#   )
#   zstyle ':completion:*:hosts' hosts $hosts
# #  zstyle '*' hosts $hosts

# ## add colors to processes for kill completion
# zstyle ':completion:*:*:kill:*:processes' command 'ps -axco pid,user,command'
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# # echo $fpath
# autoload -Uz compinit
# compinit -i

# zle -C _build_completion complete-word _build_completion
# compdef _gnu_generic xmonad

# # }}}
zstyle ':completion:*' completer _expand _complete _ignored _correct _prefix
zstyle ':completion:*' special-dirs true
zstyle :compinstall filename '/Users/dmr/.zshrc'

autoload -Uz compinit
compinit -i











bindkey -v
autoload -U incremental-complete-word predict-on
zle -N incremental-complete-word
zle -N predict-on
zle -N predict-off


# Most important bindings

bindkey -M viins '^K' vi-kill-line
bindkey -M viins '^L' yank          # put back what we've yanked...
bindkey -M viins '^Xh' _complete_help
bindkey -M vicmd '^[[3~' delete-char
bindkey '^XH' _history_complete_word

bindkey '^Xi' incremental-complete-word
bindkey '^Xp' predict-on
bindkey '^X^P' predict-off
bindkey '^X\t' _build_completion



# bindkey "^[[3~" delete-char
# bindkey '\eq' push-line-or-edit
# bindkey '^p' history-search-backward
# bindkey "^[[3A"  history-beginning-search-backward
# bindkey "^[[3B"  history-beginning-search-forward
# bindkey -s '^B' " &\n"

# Another Esc key.
bindkey -M viins '\C-@' vi-cmd-mode
bindkey -M vicmd '\C-@' vi-cmd-mode

# to delete characters beyond the starting point of the current insertion.
bindkey -M viins '\C-h' backward-delete-char
bindkey -M viins '\C-w' backward-kill-word
bindkey -M viins '\C-u' backward-kill-line

# undo/redo more than once.
bindkey -M vicmd 'u' undo
bindkey -M vicmd '\C-r' redo

# history
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd '?' history-incremental-search-forward
bindkey -M vicmd '^[k' history-beginning-search-backward
bindkey -M vicmd '^[j' history-beginning-search-forward
bindkey -M vicmd 'gg' beginning-of-history

# modification
bindkey -M vicmd 'gu' down-case-word
bindkey -M vicmd 'gU' up-case-word
bindkey -M vicmd 'g~' vi-oper-swap-case


# alias gcabal="$(which cabal) install --with-haddock=$(which haddock) --haddock-option=--hoogle --haddockdir=/usr/doc/haddock --docdir=/usr/doc --htmldir=/usr/doc/html --enable-documentation --with-hscolour=$(which HsColour) --verbose=2"


# Misc.  #{{{2

bindkey -M vicmd '\C-t' transpose-chars
bindkey -M viins '\C-t' transpose-chars
bindkey -M vicmd '^[t' transpose-words
bindkey -M viins '^[t' transpose-words

# Disable - the default binding _history-complete-older is very annoying
# whenever I begin to search with the same key sequence.
bindkey -M viins -r '^[/'

# Experimental: Alternate keys to the original bindings.
bindkey -M viins '^[,' _history-complete-newer
bindkey -M viins '^[.' _history-complete-older

# Hot key to continue a Vim process from the previous pseudo-:suspend.
# my-screen-to-other () { screen -X other; }
# zle -N my-screen-to-other
bindkey -M vicmd '^Z' my-screen-to-other
bindkey -M viins '^Z' my-screen-to-other

# End of lines added by compinstall
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh  source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh  source /opt/homebrew/share/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh  source "/opt/homebrew/opt/zsh-git-prompt/zshrc.sh"
