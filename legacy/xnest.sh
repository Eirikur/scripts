#!/bin/bash

Xnest :1 -ac &
mate-window-manager --display :1 &
xterm  -display :1    -e ./Applications/thinkTDA/thinkTDA
