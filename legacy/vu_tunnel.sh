#!/bin/bash
source ~/scripts/vu.sh &
sleep 5
ssh -L 3838:localhost:80 ehallgrimsson@10.224.40.77
