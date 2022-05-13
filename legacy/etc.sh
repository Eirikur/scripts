#!/bin/bash
file='/home/eh/Configuration/etc.tar.xz'
sudo tar -Jcvf $file /etc
sudo chown eh:eh $file

