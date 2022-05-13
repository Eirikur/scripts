#!/bin/bash
# From Zynthian recipes

sudo apt-get -y install qt4-qmake libqt4-dev portaudio19-dev librtmidi-dev libqcustomplot-dev
git clone https://github.com/davy7125/polyphone.git
cd polyphone/trunk
sed -i -- "s/\-mfpmath\=387//" polyphone.pro
sed -i -- "s/#DEFINES += USE_LOCAL_STK/DEFINES += USE_LOCAL_STK/" polyphone.pro
qmake
make -j 4
make install
