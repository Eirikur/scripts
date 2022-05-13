#!/bin/bash

target="$1"
port='1900'

ssh "$target" "netcat -l $port | zstd 
