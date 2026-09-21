#!/bin/bash
dry_run_output=$(rsync -avn --stats "$1" "$2"/)
file_count=$(echo "$dry_run_output" | awk '/to-chk/ || /Number of created files/ {gsub(",", "", $5); print $5}')
rsync -avz --stats "$1"/ "$2"/ | awk '/to-chk/ || /Number of created files/ {print}' | pv -l -s "$file_count"

