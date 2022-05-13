#!/bin/bash

list=".bashrc .emacs .emacs.d .local/share/gnote .local/share/tomboy .thunderbird .mozilla"

for item in "$list"
do
    echo $item
    ~/scripts/push-compressed-dir.sh "$item"
done

echo 'Remember ssh keys.'
