#!/usr/bin/env bash

bootstrap () {
    # sync .bashrc, .bash_profile
    rsync -av --include=.bash* --exclude=* ~
    # includes
    rsync -ac ./inc/ ~/.inc
    # config files, sudoers doesn't need to go
	rsync -av --exclude="sudoers-linux" ./config/ ~
	source ~/.bash_profile
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	bootstrap
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		bootstrap
	fi
fi
unset bootstrap
