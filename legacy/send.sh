#!/bin/bash
payload="$1"
remote="$2"
destination="$3"
port='4242'
local_interface=$(ip route get 8.8.8.8 | awk -- '{printf $5}')
# cat /sys/class/net/$local_interface/mtu
sudo ip link set dev $local_interface mtu 9000
remote_interface=$(ssh $remote sudo ip route get 8.8.8.8 | grep -v cache |  cut -d ' ' -f5)
# echo "Interfaces: $local_interface, $remote_interface"
# ssh $remote cat /sys/class/net/$remote_interface/mtu
ssh $remote "sudo ip link set dev $remote_interface mtu 9000"

receiver="nc -l $port | mbuffer -q -s 128k -m 1G | pv -rtab | tar -zxf -"
ssh $remote $receiver &
sender="tar -zcf - $payload | mbuffer -q -s 128k -m 1G | pv -b | nc $remote $port"
echo "sender: $sender"

tar -zvcf -  | pv -b | nc onyx.local 4242



# payload="$1"
# set -x
# cmd='ip link set dev "$(ip route get 8.8.8.8 | grep -v cache |  cut -d ' ' -f5)" mtu 9000'
# echo "cmd: $cmd"
# set -x
# $cmd

# ip link set dev <blah> mtu 9000


# # ip link set dev "$local_interface" mtu 9000
# # echo $(ssh $remote $interface)
# # echo $(ssh $remote $interface)
# # remote_interface=$(ssh $remote ip route get 8.8.8.8 | grep -v cache |  cut -d ' ' -f5)
# # echo "remote: $remote_interface"
# # interface=$(ip route get 8.8.8.8 | grep -v cache |  cut -d ' ' -f5) ip set link dev "$interface" 9000


# # ip link set dev $(ip route get 8.8.8.8 | grep -v cache |  cut -d ' ' -f5)    mtu 9000


# # nc -l "$port" | \
# #   mbuffer -q -s 128k -m 1G | \
# #   pv -rtab | \
# #   tar -zxf -


# # ssh "$target" 
