# The device ID reported by the tracepoint is a combination of the major and minor numbers of the device, packed into a single integer value. This is the first time in my life I've actually had to do any bit manipulation.
# By the way, what is the major and minor number? This is how the kernel *actually* identifies disks. This is similar to how your numeric user ID is how the kernel *actually* identifies you – your actual username is a mere convenience.
function get_dev_id() {
    local dev=$1
    local major_number=$(lsblk -n -o MAJ:MIN $dev | cut -d: -f1)
    local minor_number=$(lsblk -n -o MAJ:MIN $dev | cut -d: -f2)
    echo $((major_number << 20 | minor_number))
}

export DEVICE_PATH=/dev/sdd

# The stuff inside the backslashes, e.g. args->rwbs == "W", is how you filter events in bpftrace.
# We are filtering down to rwbs == "W" because this corresponds to requests to actually write to the disk.
# Then, just like with awk, you can give bpftrace a function to call for each trace. In our case, we're just printing the bits of the trace payload that we care about: the command, the size of the request, the device, and the request type.
sudo bpftrace -e "t:block:block_rq_issue \
  /args->dev == $(get_dev_id $DEVICE_PATH) && args->rwbs == \"W\"/ \
  { \
    printf(\"comm: %s, dev: %d, rwbs: %s, bytes: %d\n\", \
      comm, args->dev, args->rwbs, args->bytes); \
  }"
