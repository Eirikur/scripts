#!/bin/bash
# Set up a Linux box to talk to a Pi0 using USB gadget on 192.168.0.7:
pigadget() {
    iface=''

    ip -o link | grep en | awk '{print $2, $17}' | \
        while read -r iff mac; do
            # LON is a numeric variable containing the digit we care about.
            # The "let" is required so zsh will know it's numeric,
            # otherwise the bitwise test will fail.
            let LON=0x$(echo $mac | sed -e 's/:.*//' -e 's/.//')

            # Is the 2 bit set? Meaning it's a locally administered MAC
            if ((($LON & 0x2) != 0)); then
                iface=$(echo $iff | sed 's/:.*//')
                break
            fi
        done

    if [[ x$iface == x ]]; then
        echo "No locally administered en interface:"
        ip a | egrep '^[0-9]:'
        echo Bailing.
        return
    fi

    sudo ip a add 192.168.7.1/24 dev $iface
    sudo ip link set dev $iface up

    # Enable routing so the gadget can get to the outside world:
    sudo sh -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'
    sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
}

pigadget

