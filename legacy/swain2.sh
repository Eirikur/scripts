#!/bin/bash
sudo openvpn --config /home/eh/Configuration/Swain/downloaded-client-config-lin.ovpn > /home/eh/Configuration/Swain/swain2-openvpn.log &
#sudo openvpn --config /home/eh/Configuration/Swain/downloaded-client-config-lin.ovpn # > /home/eh/Configuration/Swain/swain-accelerate-openvpn.log
disown


