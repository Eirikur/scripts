#!/bin/bash

# smartctl --smart=on --offlineauto=on --saveauto=on /dev/hda
# smartctl developer recommends the above at boot time.

#smartctl -q errorsonly -H -l selftest /dev/hda
# Produces output only if the device returns failing SMART status, or
# if some of the logged self-tests ended with errors.

#smartctl -q silent -a /dev/hda
# Examine all SMART data for device /dev/hda, but produce no printed
# output. You must use the exit status (the $? shell variable) to
# learn if any Attributes are out of bound, if the SMART status is
# failing, if there are errors recorded in the self-test log, or if
# there are errors recorded in the disk error log.





# get all disks into an array
disks=($(ls  /dev/sd* | grep -v '[0-9]')) 

# loop over disks in array
for i in $(echo ${disks[@]}); do
    echo $i
    # check if it has a partition
    diskcheck=$(ls ${i}* | grep '[0-9]')
    # if not, print it
    if [ -z "$diskcheck" ]; then
        echo $i
    fi
done
