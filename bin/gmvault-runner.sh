#!/usr/local/bin/bash
#
# gmvault-runner.sh
# Copyright (C) 2020 David Rosenberg <david.m.rosenberg@gmail.com>
#
# Distributed under terms of the MIT license.
#


GMVAULT_EXE=/usr/local/bin/gmvault
LOGFILE=/var/log/gmvault.log
GMVAULT_DB=/Volumes/LaptopBackup2/uic-backups/gmvault-backup-uic/uic-db
ACCOUNT="dmrosenb@uic.edu"
tmplogfile="$(mktemp -t gmv.runner)"


function cleanup() {
  rm -f "${tmplogfile:-NOTEMPLOGFILE}"
}
trap cleanup EXIT


if [ ! -d $GMVAULT_DB ]; then
  echo -e "$(date): GMVAULT skipped backup of $ACCOUNT due to $GMVAULT_DB not existing or not being mounted correctly"
  trap - EXIT
  exit 1
fi
$GMVAULT_EXE sync "$ACCOUNT" -d "$GMVAULT_DB" >> "$tmplogfile" 2>&1
gmvaultstatus=$?
if [ $gmvaultstatus -eq 0 ]; then
  echo -e "$(date): GMVAULT backed up $ACCOUNT to $GMVAULT_DB successfully" | tee -a $LOGFILE
  rm "$tmplogfile"
  trap - EXIT
else
  echo -e "$(date): GMVAULT FAILED to backup $ACCOUNT to $GMVAULT_DB; gmvault log stored at $tmplogfile"
  trap - EXIT
fi

exit $gmvaultstatus


