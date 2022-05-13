#!/bin/bash

if ping argon.local -W 5 -c 1 &> /dev/null;
then
    echo 'argon is up'
else
    echo 'argon is not up'
fi
