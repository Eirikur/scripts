#!/bin/bash
localdir='/mnt/argon/media'
argoneh='/mnt/argon/eh'
sudo mkdir -p "$localdir"
sudo mkdir -p "$argoneh"
#sudo mount //192.168.1.199/media "$localdir" -o user=eh,password=eh123eh
sudo mount //argon.local/media "$localdir" -o user=eh,password=eh123eh
sudo mount //192.168.1.199/eh "$argoneh" -o user=eh,password=eh123eh

 
