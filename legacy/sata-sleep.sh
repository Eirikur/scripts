#!/bin/bash

sudo hdparm -B $1
sudo hdparm -B127 $1
sudo hdparm -S120 $1

  
