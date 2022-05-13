#!/bin/bash
swapoff -a; swapon -a
sysctl -w vm.swappiness=10
