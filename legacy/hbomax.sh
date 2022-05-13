#!/bin/bash
chromium --app=https://hbomax.com \
         --kiosk \
         --noerrdialogs \
         --enable-features=OverlayScrollbar \
         --disable-restore-session-state \
         2>&1 > ~/chrome-frame.log & disown

