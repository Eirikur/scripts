#!/bin/bash
# 21 February 2011 as profile.sh for trading
# 02 November 2013 as google.sh for quick pop-up searches.
google="https://google.com/search?q=SYMBOL"
# Main
xclip -o | xargs -I SYMBOL firefox $
