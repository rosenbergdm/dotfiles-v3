#!/bin/bash
/usr/bin/pbpaste | sed -e 's/"\(.*\)"$/\1/g' | pbcopy
pbpaste
