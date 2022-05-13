#!/bin/bash
sudo killall openvpn 2>&1 > /dev/null
~/scripts/swain.sh && ~/scripts/swain2.sh
