#!/bin/bash
sudo openvpn --config /home/eh/Configuration/Swain/client.ovpn  > /home/eh/Configuration/Swain/swain-buysmarter-openvpn.log &
disown
