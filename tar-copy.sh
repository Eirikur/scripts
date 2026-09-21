#!/bin/bash
/usr/bin/time -f "%E" tar -zcf - $1 | /dev/null 
# pv | tar -C "$2" -zxf -
