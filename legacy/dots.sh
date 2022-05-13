#!/bin/bash
du -h --summarize ~/.local/share/Trash
sudo rm ~/.local/share/Trash/* -rf
du -h --summarize ~/.cache
rm ~/.cache/* -rf
echo 'Making tar archive of all .hidden items...'
/usr/bin/time -f%E tar --exclude='.' --exclude='..' -cf - ~/.* | pf | zstd -z --adapt --rsyncable -f  > dots.tar.gz
