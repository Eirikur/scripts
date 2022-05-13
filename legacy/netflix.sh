#!/bin/bash
chromium --app=https://www.netflix.com/browse \
         --kiosk \
         --noerrdialogs \
         --enable-features=OverlayScrollbar \
         --disable-restore-session-state \
         2>&1 > ~/chrome-frame.log & disown

