#! /usr/bin/env bash
# fmtsql.sh
# Copyright (C) 2021 David Rosenberg <dmr@davidrosenberg.me>
# Distributed under terms of the MIT license.
#
# Usage: fmtsql.sh [-vhq] [--debug] [--inplace] [--output=OUTPUT] FILE
#        fmtsql.sh [-vhq] [--debug] --clipboard
#        fmtsql.sh [-vhq] [--debug] [--output=OUTPUT]
#
#
# Arguments:
#   FILE                     File to read sql from
#
# Options:
#   -h --help                display usage
#   -v --verbose             verbose mode
#   -q --quiet               quiet mode
#   --debug                  debug this script
#   --output=OUTPUT          Write output to file
#   --clipboard              read and write from the clipboard/pasteboard
#


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
[[ ${ARGS[--debug]} == true ]] && docopt_print_ARGS
if [[ "${ARGS[--verbose]}" == true ]]; then
  DEBUG_SCRIPT=${DEBUG_SCRIPT:-1}
fi
#}}}
# docopt_print_ARGS => ARGS
#             --output =
#          --clipboard = false
#            --verbose = false
#              --debug = true
#              --quiet = false
#               FILE = thefile
#               --help = false
#            --inplace = false


tmpfile=$(mktemp)
msg() {
  if [[ ${ARGS[--quiet]} == false ]]; then
    $PRINTF "%s\n" "$@"
  fi
}

if [[ ${ARGS[--inplace]} == true ]]; then
  sqlformat -a -k upper -i lower ${ARGS[FILE]} > $tmpfile
  if [ $? -gt 0 ]; then
    echo "FORMAT FAILURE" > /dev/stderr
    exit 2
  fi
  mv $tmpfile ${ARGS[FILE]}
  msg "Successfully reformatted ${ARGS[FILE]}"
  exit 0
fi

if [[ ${ARGS[--clipboard]} == true ]]; then
  ws="$(pbpaste | head -n1 | perl -p -e 's/^(\s*).*$/$1/g')"
  sqlformat -a -k upper -i lower <( pbpaste ) | /usr/bin/perl -p -e "s/^/$ws/g" > $tmpfile
elif [[ ${ARGS[FILE]}a == a ]]; then
  thetext=""
  IFS=''
  while read LINE; do
    thetext="$thetext$LINE"
  done
  ws="$(echo -e $thetext | head -n1 | perl -p -e 's/^(\s*).*$/$1/g')"
  sqlformat -a -k upper -i lower <( echo $thetext ) | /usr/bin/perl -p -e "s/^/$ws/g" > $tmpfile
else
  sqlformat -a -k upper -i lower ${ARGS[FILE]} > $tmpfile
fi

if [ -n "${ARGS[--output]}" ]; then
  if [ -f "${ARGS[--output]}" ]; then
    msg "Can't write to file '${ARGS[--output]}' as it already exists\n"
    exit 2
  else
    mv "$tmpfile" "${ARGS[--output]}"
  fi
elif [[ ${ARGS[--clipboard]} == true ]]; then
  cat "$tmpfile" | pbcopy
  rm "$tmpfile"
  msg "Formatted text copied to clipboard"
else
  cat $tmpfile && rm $tmpfile
fi




# vim: ft=sh
