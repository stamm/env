#!/bin/sh
#Config of locales and time zones
dpkg-reconfigure locales tzdata


apt-get update
apt-get install aptitude git-core


