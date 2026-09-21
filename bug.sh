#!/bin/bash


set -x
if [[ $(emacsclient -e '(visible-frame-list)' | grep "$HOSTNAME" | head -c1 | wc -c) -ne 0 ]]; then 
	emacsclient -e '(iconify-frame)'
else 
	emacsclient -e '(make-frame-visible)'
	if [[ $(emacsclient -e '(visible-frame-list)' | grep "$HOSTNAME" | head -c1 | wc -c) -ne 1 ]]; then 
		emacsclient -c
	fi
fi
