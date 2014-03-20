#!/usr/bin/env bash
# more conservative version of bootstrap.sh

# I don't always update my git settings
# but when I do, I run ./update.sh git

if [ "$1" = "git" ]; then
    cp config/.gitconfig ~/.gitconfig
    cp config/.gitattributes ~/.gitattributes
    # if you've forked this repo, PLEASE update this to your details
    # I don't want to take credit for your commits
    git config --global user.name "phette23"
    git config --global user.email "phette23@gmail.com"
    exit 0;
fi

rsync -rtv inc/ ~/.inc/
rsync -rtv .bash_profile ~

source ~/.bash_profile
