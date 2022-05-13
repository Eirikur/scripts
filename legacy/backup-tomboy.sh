#!/bin/bash
tomboy='./.local/share/tomboy ./.gconf/apps/tomboy ./.config/tomboy'


time rsync --stats -a --partial --partial-dir=~/.rsync-partial --compress --compress-level=9 \
     --update --links --progress --human-readable $tomboy \
     9185@usw-s009.rsync.net:eh/
