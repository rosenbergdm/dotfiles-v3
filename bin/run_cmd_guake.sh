#! /usr/local/bin/bash
#
# rum_cmd_guake.sh
# Copyright (C) 2020 David Rosenberg <dmr@davidrosenberg.me>
#
# Distributed under terms of the MIT license.
#

read -re cmdline
echo "Executing ${cmdline}"
exec "${cmdline}" &

exit




# vim: ft=sh
