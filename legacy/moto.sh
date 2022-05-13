#!/bin/bash
rm ~/.ssh/known_hosts
yes | sshfs root@192.168.1.103:/ ~/Moto
