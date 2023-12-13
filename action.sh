#!/bin/bash

apt-key adv --recv-keys --keyserver keyserver.ubuntu.com '6ED0E7B82643E131'
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com '0E98404D386FA1D9'
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 'F8D2585B8783D481'
echo "deb-src http://deb.debian.org/debian/ bookworm main non-free-firmware" > /etc/apt/sources.list
echo "deb http://deb.debian.org/debian/ bookworm main non-free-firmware" >> /etc/apt/sources.list
sudo apt update

sudo apt install debhelper devscripts

sudo ./build.sh
