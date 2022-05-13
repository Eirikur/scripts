#!/bin/bash
find . ! -empty -type f -printf "%s " -exec ls -dQ {} \; | sort -n | uniq -D -w 1 | \
cut -d" " -f2- | \
xargs md5sum | sort | \
uniq -w32 -d --all-repeated=separate | \
cut -c35-


# !!!!!!!!!!!!!!!!!!!!!! NOT THE SAME CODE !!!!!!!!!!!!!!!!!!!!!!!!!!
# Prints out the size and filename of each file found on the path.
# and sort using the filesize as the key, then using uniq to
# only leave filenames with the same size in the pipeline
#find . ! -empty -type f -printf "%s '%p'\n" | sort -n | uniq -D -W 1 | \

# Trim off the file size in preparation for next stage
#cut -d" " -f2- | \

# Create the checksum for the files of the same size and then sort
#xargs md5sum | sort | \

# Strip out any checksums that are unique, leaving only the duplicates
#uniq -w32 -d --all-repeated=separate | \

# Strips out the checksum part, just leaving the duplicate filenames
#cut -c35-
