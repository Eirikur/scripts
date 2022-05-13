#!/bin/bash



while true; do
   find -type d  | entr -d ./setup.py
done
