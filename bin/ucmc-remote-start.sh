#! /usr/bin/env bash
# ucmc-remote-start
# Copyright (C) 2021 David Rosenberg <dmr@davidrosenberg.me>
# Distributed under terms of the GPLv3 license.
#
# Usage: ucmc-remote-start.sh [-v|--verbose] [-h|--help]
#
#
# Arguments:
#   <REQUIREDARG>            description
#
# Options:
#   -h --help                display usage
#   -v --verbose             verbose mode

set +x
set -eE
set -o pipefail

#{{{ Use GNU utilities and set up functions#{{{#}}}
#{{{ set options from the commandline 
set -o pipefail
set +x
if [ ${DEBUG_SCRIPT:-0} -gt 1 ]; then
  set -x
fi
if echo -- "$@" | grep -- ' -v'>/dev/null; then
  if [ ${DEBUG_SCRIPT:-0} -lt 2 ]; then
    DEBUG_SCRIPT=1
  fi
fi

if echo -- "$@" | grep -- ' -vv'>/dev/null; then
  if [ ${DEBUG_SCRIPT:-0} -lt 2 ]; then
    set -v
  fi
fi
#}}}

#{{{ Basic logging and commands 
WHICH="$(which gwhich || which which)"
ECHO="$($WHICH gecho || $WHICH echo)"
PRINTF="$($WHICH gprintf || $WHICH printf)"

debuglog() {
  if [ ${DEBUG_SCRIPT:-0} -gt 0 ]; then
    ($ECHO "$@" > /dev/stderr) || $ECHO "$ECHO $* > /dev/stderr"
  fi
}

[ ${DEBUG_SCRIPT:-0} -gt 0 ] && debuglog "WHICH=$WHICH" \
 && debuglog "ECHO=$ECHO" \
 && debuglog "PRINTF=$PRINTF"

#}}}

#{{{ Load remainder of commands
DIRNAME="$($WHICH gdirname || $WHICH dirname)" && debuglog "DIRNAME=$DIRNAME"
BASENAME="$($WHICH gbasename || $WHICH basename)" && debuglog "BASENAME=$BASENAME"
READLINK="$($WHICH greadlink || $WHICH readlink)" && debuglog "READLINK=$READLINK"
DATE="$($WHICH gdate || $WHICH date)" && debuglog "DATE=$DATE"
MKTEMP="$($WHICH gmktemp || $WHICH mktemp)" && debuglog "MKTEMP=$MKTEMP"
GIT="$($WHICH git)" && debuglog "GIT=$GIT"
PG_DUMP="$($WHICH pg_dump)" && debuglog "PG_DUMP=$PG_DUMP"
PSQL="$($WHICH psql)" && debuglog "PSQL=$PSQL"
SED="$($WHICH gsed || $WHICH sed)" && debuglog "SED=$SED"
AWK="$($WHICH gawk || $WHICH awk)" && debuglog "AWK=$AWK"
GZIP="$($WHICH gzip )" && debuglog "GZIP=$GZIP"
GUNZIP="$($WHICH gunzip)" && debuglog "GUNZIP=$GUNZIP"
JQ=$($WHICH jq) && debuglog "JQ=$JQ"
WORKINGDIR="$($READLINK -f $($DIRNAME ${BASH_SOURCE[0]})/..)" && debuglog "WORKINGDIR=$WORKINGDIR"
#}}}

#{{{ Error handling routines

failure() {
  local lineno=$1
  local msg=$2
  local errorcode=${3:-0}
  echo "errorcode=$errorcode"
  echo "****Failed at ${BASH_SOURCE[0]}:$lineno: $msg******"
  if [ -z $TMPFILE ]; then
    rm -f "$TMPFILE"
  fi
}
# trap $'failure ${LINENO} "COMMAND=\'$BASH_COMMAND\'"' ERR

error() {
  printf "'%s': '%s' failed with exit code %d in function '%s' at line %d.\n" "${1-something}" "${BASH_COMMAND[0]}" "$?" "${FUNCNAME[1]}" "${BASH_LINENO[0]}"
}
# trap error ERR
# }}}
#}}}

#{{{ docopt parsing of commandline
source $(which docopts.sh) --auto "$@"
if [ -z $1 ];then 
  printf "Starting '%s'...." "/Applications/Citrix Workspace.app"
  sleep 10
  if $(ps -ef | grep 'Citrix Workspace.app' >/dev/null 2>&1); then
    printf "OK!\n\n\n"
  else
    printf "ERROR!\n\n\n"
    exit 1
  fi

  printf "Starting '%s'...." "$HOME/Applications/Live_.app"
  open "$HOME/Applications/Live_.app"
  if [ "$?" -eq 0 ]; then 
    printf "OK!\n\n\n"
  else 
    printf "ERROR!\n\n\n"
    exit 2
  fi

  printf "Starting '%s'...." "$HOME/Applications/Home 3.app"
  open "$HOME/Applications/Home 3.app"
  if [ "$?" -eq 0 ]; then 
    printf "OK!\n\n\n"
  else 
    printf "ERROR!\n\n\n"
    exit 3
  fi
else
  docopts_get_help_string $0
  exit 4
fi

# vim: ft=sh:
