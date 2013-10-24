# My Dotfiles

This started off as a fork of Mathias Bynen's [excellent OS X dotfiles](https://github.com/mathiasbynens/dotfiles), but I need to break it off into a separate project because I want a set of cross-platform dotfiles I can use on both Mac and Linux machines. I'm probably going to keep an eye on the original repository for useful commits, but it's mostly going to branch off. Making a separate project also gives me more control over how the files are organized, as there's a lot in the original I don't use or that's growing too long.

I'm keeping the MIT license as that's what the original repo was under.

## To Use

You can clone the whole project and run `bootstrap.sh` to get started. For a fresh install, the `.apt-get` and `.brew` scripts install packages using apt and homebrew respectively. The `.osx` script is a set of defaults for OS X. `update.sh` is meant to be run periodically to sync commonly updated files in the repo with the home directory.

## Structure

Everything is sourced through .bash\_profile. .bashrc just sources .bash\_profile. The filenames explain what's in a given file (e.g. .aliases has, surprise, aliases).

One-time setup scripts meant to be run on a brand new system reside in "setup."

Global configuration files reside in the "config" folders. If you're looking for a file which ends in "rc" it's probably in here (other than .bashrc).

Shell customizations are in the root of the project, so that's where functions, aliases, and Bash settings will be.
