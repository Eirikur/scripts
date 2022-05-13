#!/bin/bash
set -e
rm ~/.cache/* -rf
echo 'Remove cache okay. Starting rsync.'
rsync -a --update ../eh /media/eh/Internal\ Tank/ --stats
./scripts/backup.sh
