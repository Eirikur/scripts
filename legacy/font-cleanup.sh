#!/bin/bash
dpkg -S fonts | cut -d ':' -f 1 > mega-font-list.txt

