#!/bin/bash
timeout=100
server="$1"
server_list='z.local onyx.local tma-1.local'
servers=($server_list)
mac_list='1c:c1:de:33:87:5a 70:85:c2:f4:8a:77 f8:0d:ac:38:e7:0e'
mac_addresses=($mac_list)
waiting=0

for ((index=0; index<${#servers[@]}; ++index)); do
    candidate="${servers[index]}"
    if [[ "$candidate" == *"$server"* ]]; then # substring match
        host_name="$candidate"
        mac_address="${mac_addresses[index]}"
        # echo "Found $candidate index $index MAC $mac_address";
        wakeonlan "$mac_address" &>/dev/null
        seconds=0
        while ! timeout 1 gethostip &>/dev/null "$host_name"; do
            [[ $waiting == 0 ]] && echo -n "Waiting" && waiting=1 
            let "seconds+=1"
            if (( $seconds > $timeout )); then
                echo -e "\n$host_name is not on line."
                exit 1; fi
            echo -n "."
        done
        echo -e "\r$host_name is up." 
    fi
done

# for candidate in "$servers"; do
#     if [[ "$server" == *"$candidate"* ]]; then
#     else
#         echo "Who?"; exit 1;
#     fi
# done

# #
# wakeonlan 1c:c1:de:33:87:5a
