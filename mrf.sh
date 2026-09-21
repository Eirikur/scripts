#!/bin/bash
# Print N most recently modified files in current dir or below
mrf() {
    local _n=${1:-3} # Default to 3
    case $OSTYPE in
        linux*|msys*)
            find . -type f -exec stat -c '%X %n' {} \; | sort -nr | awk -v var="${_n}" 'NR==1,NR==var {print $0}' | while read t f; do d=$(date -d @$t "+%b %d %T %Y"); echo "$d -- $f"; done
        ;;
        darwin*)
            find . -type f -exec stat -f '%Dm %N' {} \; | sort -nr | awk -v var="${_n}" 'NR==1,NR==var {print $2}' | while read f; do stat -f '%Sm -- %N' $f; done
        ;;
     esac
 }

Usage:

$ mrf
Jan 10 11:50:03 2019 -- ./somefile
Jan 10 11:44:24 2019 -- ./nested/dir/file.txt
Jan 10 11:40:50 2019 -- ./anotherfile

$ mrf 5
Jan 10 11:50:03 2019 -- ./somefile
Jan 10 11:44:24 2019 -- ./nested/dir/file.txt
Jan 10 11:40:50 2019 -- ./anotherfile
Jan 10 06:30:22 2019 -- ./otherdir/yetanotherfile
Jan 09 10:00:00 2019 -- ./oldfile
