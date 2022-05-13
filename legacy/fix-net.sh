#!/bin/bash
/etc/init.d/networking stop
pccardctl eject 0
sleep 2
pccardctl insert 0
/etc/init.d/networking start

