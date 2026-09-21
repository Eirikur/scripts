#!/bin/bash1

# if [ -z "$1" ];
# then
#     du -hs -- * 2>/dev/null | sort -rh | head -n 25
# else
#     du -hs --  $1/* 2>/dev/null | sort -rh | head -n 25
# fi



if [[ -z $1 ]]; then
    array=$(echo "$PWD"/*)
    echo $array
    echo 
    echo "$PWD: "
    du -h --summarize
    # IFS=$(echo -en "\n\b")

#     du -shx "$array" | sort --numeric-sort --reverse | cut -f2 | xargs du -h --summarize
# else
#     du -shx "$1"  | sort --numeric-sort --reverse | cut -f2 | xargs du -h --summarize
# fi
# IFS=


