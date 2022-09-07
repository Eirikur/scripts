#!/bin/bash
tar cf - "$1" | tar xvf - -C "$2"

