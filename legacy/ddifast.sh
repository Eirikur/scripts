#!/bin/bash
time sudo dd if=$1 of=$2 bs=8M status=progress; sync; echo "Complete and synced."
 
