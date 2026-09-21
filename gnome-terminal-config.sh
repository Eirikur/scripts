#!/bin/bash

terminal="$1"

# if no argument...
if [[ ! -z "$terminal-settings" ]]; then
    dconf dump /org/gnome/terminal > 
