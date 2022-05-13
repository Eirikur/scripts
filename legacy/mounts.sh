#!/bin/bash
# mount -t smb //bamboo/eh /home/eh/mounts/Bamboo -o username=eh
set -x

gvfs-mount ssh://eh@192.168.1.200
# gvfs-mount ssh://eirikurh@eirikur.net
gvfs-mount ssh://eh@192.168.1.202



