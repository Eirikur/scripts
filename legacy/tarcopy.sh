#!/bin/bash
/usr/bin/time -f "%E" tar -zcf - $1 | pv | ssh "$2" "cd $3 && tar -zxf -"
