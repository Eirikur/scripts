#!/bin/bash
echo 'Tar phase...'
time tar -cf ~/dot-thunderbird.tar ~/.thunderbird
echo 'Rsync phase...'
rsync -avhz --partial --progress ~/dot-thunderbird.tar 9185@usw-s009.rsync.net: && rm ~/dot-thunderbird
