#!/bin/bash

power() {
  t=$1
  a=`cat /sys/class/powercap/intel-rapl/intel-rapl\:0/energy_uj`
  sleep $t
  b=`cat /sys/class/powercap/intel-rapl/intel-rapl\:0/energy_uj`
  python3 -c "print(f'{($b - $a) / 1000000 / $t:.2f} W')"
}

power 1
