#!/bin/bash
# NFS client setup, Eirikur, 16 Nov 2020.
server="argon.local"
server_ip=$(getent hosts $server | awk '{ print $1 }')

sudo apt-get install -y nfs-common
sudo mkdir -p /mnt/B1
sudo mkdir -p /mnt/C1

sudo mount $server_ip:/media/B1 /mnt/B1
sudo mount $server_ip:/media/C1 /mnt/C1


