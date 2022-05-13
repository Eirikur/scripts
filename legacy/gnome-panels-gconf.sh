#!/bin/bash
gconftool-2 -s -t bool /apps/panel/toplevels/top_panel_screen0/auto_hide true
gconftool-2 -s -t bool /apps/panel/toplevels/bottom_panel_screen0/auto_hide true

gconftool-2 -s -t int /apps/panel/toplevels/top_panel_screen0/auto_hide_size 1
gconftool-2 -s -t int /apps/panel/toplevels/bottom_panel_screen0/auto_hide_size 1

gconftool-2 -s -t int /apps/panel/toplevels/top_panel_screen0/background/opacity 0
gconftool-2 -s -t int /apps/panel/toplevels/bottom_panel_screen0/background/opacity 0
