#!/bin/sh
#Config of locales and time zones
#dpkg-reconfigure locales tzdata
install_progs() {
	apt-get update
	apt-get install aptitude git-core htop ntpdate zip rar unrar bash-completion
	my_cp "/root/.gitconfig"
}

upgrade_dist() {
	my_cp "/etc/apt/apt.conf.d/99cache"
	my_cp_dir "/etc/apt/sources.list.d/"
	my_cp "/etc/apt/preferences"
	apt-get update
	apt-get -y upgrade
	apt-get -y dist-upgrade
	apt-get clean
	apt-get autoclean
	apt-get autoremove
}

my_cp(){
    cp ./files$1 $1
}

my_cp_dir(){
    cp ./files$1* $1
}

#install_progs
#upgrade_dist