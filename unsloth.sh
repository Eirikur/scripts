#!/bin/bash

# New log file each time. They are large.
unsloth studio  &> ~/.local/logs/unsloth-studio.log &

sleep 2

~/Applications/firefox/firefox http://localhost:8888
~/Applications/helium http://localhost:8888
