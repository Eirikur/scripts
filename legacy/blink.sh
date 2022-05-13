======================================================
#!/usr/bin/ksh

USB_NUM=$(dmesg | grep "Product: fit_StatUSB" | cut -f1 -d":" | awk '{ print $NF }')
if [ "${USB_NUM}" = "" ]
then
print "/dev/null" > /etc/fit_StatUSB.conf
print "fit_StatUSB NOT DETECTED"
exit
fi

ACM_PORT=$(dmesg | grep "cdc_acm ${USB_NUM}" | cut -f3 -d":" | awk '{ print $NF }' | cut -f1 -d":")
print "/dev/${ACM_PORT}" > /etc/fit_StatUSB.conf

# Initialize serial port baud rate
stty -F /dev/${ACM_PORT} 115200 raw -echo -echoe -echok -echoctl -echoke
# Set transition time to shortest possible time
echo "F0001" > /dev/${ACM_PORT}
# Turn on full bright white for 1 second
# and then turn it off
echo "#FFFFFF" > /dev/${ACM_PORT}
sleep 1
echo "#000000" > /dev/${ACM_PORT}

print "fit_StatUSB initialized: /dev/${ACM_PORT}"
======================================================

In other scripts I then can just reference my "/etc/fit_StatUSB.conf" file to learn the device node, and write the colors as needed.
