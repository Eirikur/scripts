#!/bin/bash

if [[ -z $1 ]]; then
    echo -n "$PWD: "
    du -h --summarize
    du --summarize *  | sort --numeric-sort --reverse | cut -f2 | xargs du -h --summarize
else
    du --summarize "$1"  | sort --numeric-sort --reverse | cut -f2 | xargs du -h --summarize
fi

    
