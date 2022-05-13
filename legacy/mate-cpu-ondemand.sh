#!/bin/bash
# ondemand stays at maximum speed. powersave stays at low speed. 9 Nov 2020 ArgonOne M.2 Pi4B 8GB
echo "conservative" |sudo tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
