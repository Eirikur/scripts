#!/bin/bash

sudo pv <"$1" | zstd --fast > "$2"
