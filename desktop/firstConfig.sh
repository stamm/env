#!/usr/bin/env bash

sudo add-apt-repository ppa:chromium-daily/ppa
sudo add-apt-repository ppa:ubuntu-tweak-testing/ppa
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
sudo add-apt-repository "deb http://linux.dropbox.com/ubuntu maverick main"

sudo apt-get update
sudo apt-get install ubuntu-restricted-extras \
keepassx \
chromium-browser chromium-codecs-ffmpeg-nonfree \
nautilus-dropbox \
qutim smplayer \
virtualbox-guest-additions virtualbox-ose \
mc git htop sshfs openssh-server\
php5-cli php5-fpm php5-curl php5-mcrypt php5-memcache php5-mysql php5-xdebug phpunit \
ubuntu-tweak


sudo add-apt-repository ppa:ayatana-scrollbar-team/release
sudo apt-get update
sudo apt-get install liboverlay-scrollbar-0.1-0



sudo update-alternatives --set editor /usr/bin/mcedit








exit;
sudo add-apt-repository ppa:hydr0g3n/qbittorrent-unstable
sudo apt-get update
sudo apt-get install qbittorrent
