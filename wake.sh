#!/bin/bash
timeout=100
server="$1"
server_list='z.local onyx.local tma-1.local black.local'
servers=($server_list)
mac_list='1c:c1:de:33:87:5a 70:85:c2:f4:8a:77 f8:0d:ac:38:e7:0e 00:e0:4c:68:45:86'
mac_addresses=($mac_list)
waiting=0

# if up "google.com"; then echo 'yes'; fi
function up() {
    timeout 1 gethostip &>/dev/null $1
}

function ctrl_c() {
    echo "^C"
    exit 1
}

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

# Go through our hard-coded server list and....
for ((index=0; index<${#servers[@]}; ++index)); do
    candidate="${servers[index]}"
    if [[ "$candidate" == *"$server"* ]]; then # substring match
        if ! up "$candidate"; then # Wake it up.
            host_name="$candidate"
            mac_address="${mac_addresses[index]}"
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
            echo "$seconds seconds."
        else
            host_name="$candidate"
            # echo 'no wake needed'
        fi

        echo -e "\r$host_name is up."
        exit 0
    fi
done
