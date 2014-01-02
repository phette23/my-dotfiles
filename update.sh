#!/usr/bin/env bash
# more conservative version of bootstrap.sh
rsync -rtv inc/ ~/.inc/
rsync -rtv .bash_profile ~

source ~/.bash_profile
