#!/bin/bash

tar -cf - "$1"  | pv | zstd | nc onyx.local 1900
