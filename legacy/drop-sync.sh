#!/bin/bash
notify-send "Sending $1 to eirikur.net."
rsync --recursive "${@%/}" eirikurh@eirikur.net:
if (($?)); then  # We failed.
    echo "Copy of $1 to eirikur.net failed!"
    # notify-send --urgency=critical "Copy of $1 to eirikur.net failed!"
    zenity --error --text "Copy of $1 to eirikur.net failed!"
    exit 1
else
    echo "Copy $1 to eirikur.net succeeded."
    notify-send "Successfully sent $1 to eirikur.net."
fi



