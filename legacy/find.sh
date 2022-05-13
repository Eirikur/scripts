#!/bin/bash
rm ~/.ssh/known_hosts
yes | sshfs root@192.168.198.279:/ ~/Moto
