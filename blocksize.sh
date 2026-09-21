#!/usr/bin/env bash
sudo hdparm -I "$1"| grep -i physical
