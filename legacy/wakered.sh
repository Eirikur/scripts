#!/bin/bash
# wakered.sh 2 Jan 2020 EH

ssh eh@red.local & sleep 2 ; kill $! # Deal with the 'never wakes on first ssh' issue.

time scp /etc/hostname eh@red.local:/media/Lower/
time scp /etc/hostname eh@red.local:/media/Upper/
