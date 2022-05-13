#!/bin/bash
# sudo /home/eh/python/p.py

echo 'SUBSYSTEMS=="usb", ATTRS{product}=="Griffin PowerMate", KERNEL=="event?", NAME="input/powermate"' | sudo tee /etc/udev/rules.d/10-local.rules

sudo addgroup powermate
sudo adduser "$USER" powermate

sudo dpkg -i ~/Customizations/evrouter_0.4_amd64.deb

echo 'ATTRS{product}=="Griffin PowerMate" GROUP="powermate", MODE="0666"' | sudo tee /etc/udev/rules.d/40-permissions-powermate.rules


sudo tee ~/.evrouterrc > /dev/null <<EOF
Window ""
"Griffin PowerMate" "" any key/256 "XKey/XF86AudioMute"
"Griffin PowerMate" "" any rel/7/1 "XKey/XF86AudioRaiseVolume"
"Griffin PowerMate" "" any rel/7/-1 "XKey/XF86AudioLowerVolume"
EOF



# Find the device number to plug into the evrouter command .../eventXX below
# sudo evrouter /dev/input/*


sudo tee /usr/local/bin/powermate > /dev/null <<EOF
#!/bin/sh
exec evrouter -c /etc/evrouterrc /dev/input/powermate
EOF
sudo chmod a+x /usr/local/bin/powermate




# sudo apt install cmake libboost-dev libboost-program-options-dev




# sudo groupadd input
# sudo gpasswd -a eh input

# cd ~/Customizations/gizmod-3.5/build
# cmake -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc ../gizmod-3.5
# make
# sudo make install


# sudo cp ~/Configuration/Powermate/99-input.rules /etc/udev/rules.d/

# # Make parent dirs if required and tolerate existing dirs.
# mkdir -p ~/.gizmo/scripts

# cp ~/Customizations/gizmoDaemonConfig.py ~/.gizmo/scripts
