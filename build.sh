#!/bin/bash
#./clean.sh
sudo whoami

cat /etc/apt/sources.list
cat /etc/apt/sources.list.d/*
gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys '6ED0E7B82643E131'
gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys '0E98404D386FA1D9'
gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 'F8D2585B8783D481'
echo "deb-src http://deb.debian.org/debian/ bookworm main non-free-firmware" >> /etc/apt/sources.list
sudo apt update --allow-unauthenticated

sudo apt source base-files/stable

apt download base-files/stable
oldversion=$(dpkg-deb -f ./*.deb version)
rm ./*.deb

source_dir="./base-files-${oldversion}/"
cd $source_dir
let os_version=$(cat ./etc/debian_version | sed "s/\..*//")-11
os_name="PRETTY_NAME=\"Sapphic #OSNAME# v$os_version\""
home_url="HOME_URL=\"https://www.github.com/pogmommy/Sapphic-Linux/\""
sed -i "s,PRETTY_NAME=.*,$os_name,;s,HOME_URL=.*,$home_url," ./etc/os-release

sed -i "s/Debian/Sapphic/" ./etc/issue
sed -i "s/Debian/Sapphic/" ./etc/issue.net

sed -i "s/Debian/Sapphic/" ./share/motd
cp ../origins/debian ./origins/debian

maintainer="Maintainer: Penelope Gwen <penelope@pogmom.me>"
#provides="$(grep 'Provides' ./debian/control), base-files (= ${oldversion})"
#replaces="$(grep 'Replaces' ./debian/control), base-files (= ${oldversion})"
sed -i "s/Maintainer:.*/$maintainer/" ./debian/control
#;s/Provides:.*/$provides/;s/Replaces:.*/$replaces/;s/Package:.*/Package: base-files-sapphic/" ./debian/control
#sed -i "s,debian/base-files,debian/base-files-sapphic," ./debian/rules

fakeroot -- dh binary

cd ..

mkdir -p ./builds/
cp ./*.deb ./builds/

rm -rf $source_dir
rm ./*.tar.xz ./*.dsc

ls
