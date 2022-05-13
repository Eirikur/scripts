#!/bin/bash
sudo dpkg --configure -a
sudo aptitude update -f -y && sudo aptitude install gtkorphan && sudo aptitude -f -y update && sudo aptitude -f -y upgrade  && sudo aptitude -f -y


