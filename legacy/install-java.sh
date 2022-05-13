#!/bin/bash		
# Java 8
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt update
sudo apt-get install -y oracle-java8-installer
sudo apt-get install -y oracle-java8-set-default

Java 11
sudo add-apt-repository ppa:linuxuprising/java
sudo apt update
sudo apt-get install -y oracle-java11-installer

### Oracle JDK 11 ###
sudo apt-get install -y oracle-java11-set-default

### Oracle JDK 8 ###
#sudo apt-get install -y oracle-java8-set-default
