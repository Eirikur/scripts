#!/bin/bash
# Use lrzip for tightest compression using multiple cores and more memory.
# Version 2, 20 Aug 2021, Patricia is with her mom.
file="$1-$2-$3-$4-$5-$6-$7-$8"
file="${file#.}" # Somehow strips a leading period.
suffix=".tar"
compressed_suffix=".zapq-lrz"
file="$file$suffix"
compressed_file="$file$compressed_suffix"

echo $file

echo ""





 
