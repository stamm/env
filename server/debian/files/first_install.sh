#!/bin/sh

apt-get install aptitude

#Config of locales and time zones
dpkg-reconfigure locales
dpkg-reconfigure tzdata