#!/bin/bash
killall mbuffer
source="$1"
filename=$(basename $1)
dest="$2"
destdir="$3"

port='4242'

# Set up the listener.
#ssh $dest "mkdir -pv $destdir"
# ssh $dest "while killall mbuffer zstd &>/dev/null ; do echo -n '.'; done"
##### mbuffer -q -s 128k -m 1G |
# ssh $dest "nohup mkdir -pv $destdir && cd $destdir && mbuffer -s 128k -m 1G -I 4242 > $filename.tar.lz4 & disown"
#echo "Listener set up."
ssh onyx.local nohup killall mbuffer ;  mbuffer -q -s 128k -m 1G -I 4242 > $filename.tar.lz4 &
/usr/bin/time -f%E tar -cf - $source  | mbuffer -s 128k -m 1G -O "192.168.1.138:$port"
/usr/bin/time -f%E tar -cf - $source  | mbuffer -s 128k -m 1G -O "192.168.1.138:$port"
/usr/bin/time -f%E tar -cf - $source  | mbuffer -s 128k -m 1G -O "192.168.1.138:$port"
/usr/bin/time -f%E tar -cf - $source  | mbuffer -s 128k -m 1G -O "192.168.1.138:$port"
1
/usr/bin/time -f%E tar -cf - $source  | \
    mbuffer -s 128k -m 1G | ssh onyx.local "cat > /syba/Archives/"
