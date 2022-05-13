#!/bin/bash
# set -x
# set -e
# Use lrzip for tightest compression using multiple cores and more memory.
file="$1"
file="${file#.}"
file=$(echo "$file" | sed 's:/*$::') # Strip trailing slash.

if [[ ! -z "$2" ]]; then
    dir="$2"
    file="$dir/$file"
fi

# unique="$(date +%s.%N)" # Unix date (epoch) in seconds, period, nanoseconds.
# unique="$(date +%s)" # Unix date (epoch) in seconds, period, nanoseconds.
suffix=".tar"
compressed_suffix=".zapq-lrz"
file="$file$suffix"
compressed_file="$file$compressed_suffix"

echo ""
echo "Archiving $1 into $file..."

# Bash requires distinction of the external program.
/usr/bin/time -f "%E" tar -cf $file $1
du -h $file
echo 'Tarred okay.'
echo "Squashing with lrzip's zapq compression, multicore...."
rm "$compressed_file" 2>&1 | > /dev/null  # Hide complaint if file is not there.
# U: Unlimited window size. Could use all RAM. D: delete existing output file if there.
# b: Bzip2 compression. r: recursively p: processors to use.
# z: Let's use zapq instead.
# && rm removes the uncompressed tar file.
/usr/bin/time -f "%E" lrzip -UDqp `nproc` -S "$compressed_suffix" -L 9 $file && rm -fv $file
echo "Done."
du -h "$file$compressed_suffix"
echo ""




 
