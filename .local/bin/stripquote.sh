#!/bin/bash
tmpfile=$(mktemp)

/usr/bin/pbpaste | sed -e 's/"\(.*\)"$/\1/g' >$tmpfile
cat $tmpfile | /usr/bin/pbcopy
sleep 1
cat $tmpfile
rm $tmpfile
