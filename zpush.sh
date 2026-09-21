#!/usr/bin/env bash

name="$1"
extension="tar.zst"
extended_name="$name.$extension"
time tar  --zstd -cf "$extended_name" "$name"
~/scripts/push.sh "$extended_name"
