#! /usr/bin/env bash
#
# common.sh
# Copyright (C) 2020-2021 David M. Rosenberg <dmr@davidrosenberg.me>
#
# Distributed under terms of the MIT license.
#

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
PERL="$($WHICH perl )" && debuglog "PERL=$PERL"
FIND="$($WHICH gfind || $WHICH find )" && debuglog "FIND=$FIND"
GUNZIP="$($WHICH gunzip)" && debuglog "GUNZIP=$GUNZIP"
JQ=$($WHICH jq) && debuglog "JQ=$JQ"
#SED="$($WHICH gsed || $WHICH sed)" && debuglog "SED=$SED"

#}}}

#{{{ Project settings
WORKINGDIR="$($READLINK -f $($DIRNAME ${BASH_SOURCE[0]})/..)" && debuglog "WORKINGDIR=$WORKINGDIR"
LOGFILE="$($MKTEMP)" && debuglog "LOGFILE=$LOGFILE"
TMPFILE="$($MKTEMP)" && debuglog "TMPFILE=$TMPFILE"
GIT_TAG="$($GIT describe --tags | tail -n1)" && debuglog "GIT_TAG=$GIT_TAG"

if [ -z "$JQ" ]; then
  debuglog "not using jq"
  PASSWD="$(cat "$WORKINGDIR/dbsettings.json" | grep DBPASSWORD | sed -e 's#"##g' | awk '{print $2}')" && debuglog "PASSWD=****"
  USER="$(cat $WORKINGDIR/dbsettings.json | grep DBUSER | sed -e 's#["|,]##g' | awk '{print $2}')" && debuglog "USER=$USER"
  DBNAME="$(cat $WORKINGDIR/dbsettings.json | grep DBNAME | sed -e 's#["|,]##g' | awk '{print $2}')" && debuglog "DBNAME=$DBNAME"
else
  debuglog "using jq..."
  PASSWD="$(cat $WORKINGDIR/dbsettings.json | jq -r '.DBPASSWORD')" && debuglog "PASSWD=****"
  USER="$(cat $WORKINGDIR/dbsettings.json | jq -r '.DBUSER')" && debuglog "USER=$USER"
  DBNAME="$(cat $WORKINGDIR/dbsettings.json | jq -r '.DBNAME')" && debuglog "DBNAME=$DBNAME"
fi

#}}}


failure() {
  local lineno=$1
  local msg=$2
  local errorcode=${3:-0}
  echo "errorcode=$errorcode"
  echo "****Failed at ${BASH_SOURCE[0]}:$lineno: $msg******"
  echo "ABORTING"
  if [ -z $TMPFILE ]; then
    rm -f "$TMPFILE"
  fi
  # trap $'failure ${LINENO} "COMMAND=\'$BASH_COMMAND\'"' ERR
}
# trap $'failure ${LINENO} "COMMAND=\'$BASH_COMMAND\'"' ERR

error() {
  printf "'%s': '%s' failed with exit code %d in function '%s' at line %d.\n" "${1-something}" "${BASH_COMMAND[0]}" "$?" "${FUNCNAME[1]}" "${BASH_LINENO[0]}"
}



