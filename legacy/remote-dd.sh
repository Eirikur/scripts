#!/bin/bash
source="$1"
remote_host="$2"
dest_file="$3"

set -x

# As netcat, -l conflicts with other options.

ssh $remote_host  'nc -p 19000 -l | dd of=$dest_file bs=16M' &

dd bs=16M if=$source status=progress | nc $remote_host 19000
