#!/bin/bash
revoco free

if (( $? )); then
    # If command failed or is not found
    cd ~/Customizations/
    cc revoco.c
    gksu cp ~/Customizations/revoco /usr/bin
    chmod 4755 /usr/bin/revoco
else # Command found/succeeded
    echo ''
fi

