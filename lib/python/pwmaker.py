#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2020 David Rosenberg <dmr@davidrosenberg.me>
#
# Distributed under terms of the MIT license.

"""

"""
import json
OUTPUTFILE = "christina.csv"

def my_escape(s):
    s1 = json.dumps(s)
    s2 = s.replace(',', '\,')
    return s2

def create_password_entry(title, username, password, url=None, Notes=None):
    thetuple = ('', my_escape(title), my_escape(username), my_escape(password), '', '', '', '')
    if url is not None:
        thetuple = (thetuple[1], thetuple[2], thetuple[3], thetuple[4], my_escape(url), thetuple[6], '', '')
    if Notes is not None:
        thetuple = (thetuple[1], thetuple[2], thetuple[3], thetuple[4], thetuple[5], my_escape(Notes), '', '')
    entrystring = ",".join(thetuple)
    return(entrystring)

def create_and_write(title, username, password, url=None, notes=None):
    fh = open(OUTPUTFILE, 'a')
    fh.write(create_password_entry(title, username, password, url, notes) + "\n")
    fh.close()


