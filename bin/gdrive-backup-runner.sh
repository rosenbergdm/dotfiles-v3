#!/usr/local/bin/bash
#
# gdrive-backup-runner.sh
# Copyright (C) 2020 David Rosenberg <dmr@davidrosenberg.me>
#
# Distributed under terms of the MIT license.
#

declare -a TARGETS_SHARED
declare -a TARGETS_NONSHARED
declare -a SOURCES_SHARED
declare -a SOURCES_NONSHARED

TGT_DIR=/Volumes/LaptopBackup2/uic-backups
RCLONE=/usr/local/bin/rclone
SOURCES_SHARED=( "/Phase 2 - M3／M4 Google Drive" "/Old Curriculum - M2 Google Drive")
TARGETS_SHARED=( "Texts/Phase 2/" "Texts/M2 Google Drive/")
SOURCES_NONSHARED=( "/syncable/" )
TARGETS_NONSHARED=( "MyDrive/syncable/" )
SHARED_ARGS='--drive-shared-with-me'
ARGS='--drive-formats "docx,xlsx,pdf" -v --update --exclude-from "/Users/davidrosenberg/.config/rclone/M2_exclusions.txt"'

scriptlog="$(mktemp -t gdbkrun)"
LOGFILE=/var/log/rclone.log
LOGCMD="tee -a $LOGFILE"

RUNCMD=eval
if [[ "$DEBUG_RCLONE:" == "1:" ]]; then
  RUNCMD=echo
  LOGCMD="xargs echo"
  echo "Running in debug mode"
fi


function sync_dir() {
  src="$1"
  tgt="$2"
  shared="$3"
  if [[ $shared == "shared" ]]; then
    [[ "$DEBUG_RCLONE:" == "1:" ]] && $RUNCMD "$RCLONE $SHARED_ARGS $ARGS sync \"dmrosenb-uic-google:$src\" \"$TGT_DIR/$tgt\"" > /dev/stderr
    $RUNCMD "$RCLONE $SHARED_ARGS $ARGS sync \"dmrosenb-uic-google:$src\" \"$TGT_DIR/$tgt\"" 2>&1
    retstatus=${PIPESTATUS[0]}
  else
    [[ "$DEBUG_RCLONE:" == "1:" ]] && $RUNCMD "$RCLONE $ARGS sync \"dmrosenb-uic-google:$src\" \"$TGT_DIR/$tgt\"" > /dev/stderr
    $RUNCMD "$RCLONE $ARGS sync \"dmrosenb-uic-google:$src\" \"$TGT_DIR/$tgt\"" 2>&1
    retstatus=${PIPESTATUS[0]}
  fi
  return $retstatus
}

function _cleanup() {
  echo "AN UNKNOWN ERROR HAS OCCURED"
  rm -f "$scriptlog"
  exit 1
}
trap _cleanup EXIT
running_status=0


if [ -d $TGT_DIR ]; then 
  for ((i=0; i<${#SOURCES_SHARED[@]}; i++)); do
    sync_dir "${SOURCES_SHARED[$i]}" "${TARGETS_SHARED[$i]}" shared >> "$scriptlog"
    if [[ $? -gt 0 ]]; then
      running_status=$((running_status+1))
      echo "$(date) sync of \"${SOURCES_SHARED[$i]}\" to \"${TARGETS_SHARED[$i]}\" FAILED" | $LOGCMD
    else
      echo "$(date) sync of \"${SOURCES_SHARED[$i]}\" to \"${TARGETS_SHARED[$i]}\" Succeeded" | $LOGCMD
    fi
  done

  for ((i=0; i<${#SOURCES_NONSHARED[@]}; i++)); do
    sync_dir "${SOURCES_NONSHARED[$i]}" "${TARGETS_NONSHARED[$i]}" nonshared >> "$scriptlog"
    if [[ $? -gt 0 ]]; then
      running_status=$((running_status+1))
      echo "$(date) sync of \"${SOURCES_NONSHARED[$i]}\" to \"${TARGETS_NONSHARED[$i]}\" FAILED" | $LOGCMD
    else
      echo "$(date) sync of \"${SOURCES_NONSHARED[$i]}\" to \"${TARGETS_NONSHARED[$i]}\" Succeeded" | $LOGCMD
    fi
  done

  if [[ $running_status -gt 0 ]]; then
    echo "$(date) SYNC FAILED, log at $scriptlog"
    trap - EXIT
    exit $running_status
  else
    echo "$(date) SYNC SUCCEEDED"
    rm "$scriptlog"
    trap - EXIT
    exit $running_status
  fi
else
  echo "$(date) SYNC SKIPPED DUE TO '$TGT_DIR' not existing"
  rm "$scriptlog"
  trap - EXIT
  exit 1
fi


