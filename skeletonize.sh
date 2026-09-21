#!/bin/bash
# Make tree of directories found under $1 in a new root $2
# The content is not copied.

find /home/eh -type d  -name "*[:space:]*" -printf "%P\n" -exec mkdir -p $2/'{}' \;

