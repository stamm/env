#!/bin/sh

#Make link to needing dirs or files in home dir

#Where saving data
HOME_PATH="/media/many/ubuntu/home/stamm"

#Creating link for dirs EXCLUDE finish slash!
DIRS="
.config/qutim
.psi
.ssh
git
scripts
web
";

FILES="
.gitconfig
"

create_dir() {
	if [ ! -d "$HOME_PATH/$1" ]; then
		mkdir -p $HOME_PATH/$1
	fi
	if [ ! -L "$HOME/$1" ]; then
		ln -s $HOME_PATH/$1 $HOME/$1
	fi
}
create_file() {
	if [ ! -f "$HOME_PATH/$1" ]; then
		touch $HOME_PATH/$1
	fi
	if [ ! -L "$HOME/$1" ]; then
		ln -s $HOME_PATH/$1 $HOME/$1
	fi
}


for dir in $DIRS; do
	create_dir $dir;
done;

for file in $FILES; do
	create_file $file;
done;
