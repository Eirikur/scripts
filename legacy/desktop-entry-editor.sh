#!/bin/bash

yad --title="Desktop entry editor" --text="Simple desktop entry editor" \
    --form --field="Type:CB" --field="Name" --field="Generic name" \
    --field="Comment" --field="Command:FL" --field="Icon" \
    --field="In termianl:CHK" --field="Startup notify:CHK" \
    "Application!URI" "Name" "Generic name" "This is the comment" \
    "/usr/bin/yad" "yad" FALSE TRUE 
