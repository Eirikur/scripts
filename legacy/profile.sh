#!/bin/bash
# 21 February 2011
yahoo="http://finance.yahoo.com/q/pr?s=SYMBOL+Profile"
bloomberg="http://www.bloomberg.com/apps/quote?ticker=SYMBOL:US"
URLS="$yahoo $bloomberg"
# Main
xclip -o | xargs -I SYMBOL firefox $yahoo





