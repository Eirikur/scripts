#!/bin/bash
set -x
alias time='/usr/bin/time -f "%E"'

time tar -cv "$1" | pv  > "$1.tar.gz" # | gzip --rsyncable > "$1.tar.gz"
set -x
