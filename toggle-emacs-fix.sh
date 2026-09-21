#!/bin/bash


title="$1" # Window title to search for.


### Incomplete Aug 25 2026.


# The second argument is optional.  If not supplied, title is used as the command.
if [ "$2" == "" ];
then
    command="$1"
else
    command="$2"
fi

