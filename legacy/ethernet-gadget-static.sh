sudo ifconfig enp0s26f7u4u1u3 192.168.7.1 netmask 255.255.255.0 up # Assign an IP to the USB-Ethernet gadget
sudo route add -net 192.168.7.0/24 gw 192.168.7.1 dev enp0s26f7u4u1u3 # Define a routing to the Pi Zero.
