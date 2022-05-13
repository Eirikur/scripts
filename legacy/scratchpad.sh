#!/bin/bash
TMP=`mktemp --dry-run`
Y="yad --center --window-icon /home/tri/icons/scratchpad.png --title Scratchpad"
function cleanup { rm $TMP; exit 1; }
$Y --on-top --button gtk-save:0 --button gtk-cancel:1 --text-info --wrap --editable > $TMP || cleanup
FILE=`$Y --width 570 --height 600 --text "Save as" --file-selection --save --filename=$HOME/` || cleanup
if [ -e "$FILE" ]; then
	$Y --image dialog-question --text "$FILE existed.  Overwrite?" || cleanup
fi
mv $TMP "$FILE"
