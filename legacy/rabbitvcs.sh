#!/bin/bash
sudo apt-get install python-nemo rabbitvcs-core
sudo cp ~/Customizations/RabbitVCS.py /usr/share/nemo-python/extensions/
nemo -q; nemo
