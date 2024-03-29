#!/bin/bash

./clean.sh

apt source base-files/stable

apt download base-files/stable
oldversion=$(dpkg-deb -f ./*.deb version)
rm ./*.deb

source_dir="./base-files-${oldversion}/"
cd $source_dir

export DEBEMAIL=penelope@pogmom.me
debchange -D touko --stable --force-distribution -p --no-auto-nmu -U "system build"

let os_version=$(cat ./etc/debian_version | sed "s/\..*//")-11
os_name="PRETTY_NAME=\"Sapphic #OSNAME# v$os_version\""
home_url="HOME_URL=\"https://www.github.com/pogmommy/Sapphic-Linux/\""
sed -i "s,PRETTY_NAME=.*,$os_name,;s,HOME_URL=.*,$home_url," ./etc/os-release

sed -i "s/Debian/Sapphic/" ./etc/issue
sed -i "s/Debian/Sapphic/" ./etc/issue.net

sed -i "s/Debian/Sapphic/" ./share/motd
cp ../origins/debian ./origins/debian

maintainer="Maintainer: Penelope Gwen <penelope@pogmom.me>"
sed -i "s/Maintainer:.*/$maintainer/" ./debian/control
#provides="$(grep 'Provides' ./debian/control), base-files (= ${oldversion})"

#replaces="$(grep 'Replaces' ./debian/control), base-files (= ${oldversion})"

#replaces="$(grep \"Replaces:.*\" debian/control)"
#sed -i "s/Replaces:.*/$replaces)/" ./debian/control

#package="Package: base-files-sapphic"
#sed -i "s/Package:.*/$package/" ./debian/control
#;s/Provides:.*/$provides/;s/Replaces:.*/$replaces/;s/Package:.*/Package: base-files-sapphic/" ./debian/control
#sed -i "s,debian/base-files,debian/base-files-sapphic," ./debian/rules

dh binary

cd ..

mkdir -p ./builds/
cp ./*.deb ./builds/

rm -rf $source_dir
rm ./*.tar.xz ./*.dsc

ls
