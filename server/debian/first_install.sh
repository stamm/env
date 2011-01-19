#!/bin/sh
#Config of locales and time zones
#dpkg-reconfigure locales tzdata

install_progs() {
	apt-get update
	apt-get install aptitude git-core htop ntpdate zip rar unrar bash-completion
	my_cp "/root/.gitconfig"
}

conf_sys() {
	ntpdate -q 0.debian.pool.ntp.org
	update-alternatives --set editor /usr/bin/mcedit
	echo "root: rustam@zagirov.name" >> /etc/aliases
}

conf_php() {
	#apt-get purge -y apache2 apache2-utils apache2.2-bin apache2.2-common

	wget http://snapshot.debian.org/archive/debian/20100801T150833Z/pool/main/p/php5/php5-fpm_5.3.3-1_amd64.deb -O /tmp/php5-fpm_5.3.3-1_amd64.deb
	dpkg -x /tmp/php5-fpm_5.3.3-1_amd64.deb /tmp/fpm
	dpkg -e /tmp/php5-fpm_5.3.3-1_amd64.deb /tmp/fpm/DEBIAN/
	sed -i 's/php5-common (= 5.3.3-1)/php5-common (>= 5.3.3-1)/g' /tmp/fpm/DEBIAN/control
	dpkg -b /tmp/fpm/ /tmp/php5-fpm_5.3.3-1_amd64_patched.deb

	mkdir -p /var/www
	chown www-data.www-data /var/www
	apt-get install -y --no-install-recommends libevent-1.4-2 libonig2 libqdbm14 php5-common php5-cli \
		nginx-full
	dpkg --force-depends -i /tmp/php5-fpm_5.3.3-1_amd64_patched.deb
	mkdir -p /var/www/etalon/{logs,tmp,www}
	chown www-data.www-data /var/www/etalon/{tmp,www}
	chmod 0700 /var/www/etalon/{tmp,www}
}

upgrade_dist() {
	my_cp "/etc/apt/apt.conf.d/99cache"
	my_cp_dir "/etc/apt/sources.list.d/"
	my_cp "/etc/apt/preferences"
	aptitude update
	aptitude install apt dpkg aptitude
	aptitude full-upgrade
	aptitude clean
	aptitude autoclean
	apt-get autoremove
}

my_cp(){
    cp ./files$1 $1
}

my_cp_dir(){
    cp ./files$1* $1
}

#upgrade_dist
#install_progs
#conf_sys
conf_php