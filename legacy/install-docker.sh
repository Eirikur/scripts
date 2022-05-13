#!/bin/bash

#   a. Install the following prerequisites.

sudo apt-get install apt-transport-https ca-certificates software-properties-common -y

#    b. Download and install Docker.

curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh

#   c. Give the pi user the ability to run Docker.

sudo groupadd docker
sudo usermod -aG docker pi

