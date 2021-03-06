# My Dotfiles

This started off as a fork of Mathias Bynen's [excellent OS X dotfiles](https://github.com/mathiasbynens/dotfiles), but I need to break it off into a separate project because I want a set of cross-platform dotfiles I can use on both Mac and Linux machines. I'm probably going to keep an eye on the original repository for useful commits, but it's mostly going to branch off. Making a separate project also gives me more control over how the files are organized, as there's a lot in the original I don't use or that's growing too long.

I kept the MIT license as that's what the original was under.

## To Use

You can clone the project and run `bootstrap.sh` to get started. `update.sh` is a subset of `bootstrap.sh` which syncs only the inc directory with the home folder; it's useful because the files in inc tend to be the most frequently edited ones.

For a fresh OS install, the `apt-get.sh` and `brew.sh` scripts in the config directory install packages using apt and homebrew respectively. `cask.sh` will install Mac apps using [homebrew cask](https://github.com/phinze/homebrew-cask). The `osx.sh` script is a set of defaults for OS X.

## Structure

Everything is sourced through `.bash_profile`. The files which `.bash_profile` includes are in the **inc** folder of this project. To keep file sizes down, some of these files are sourced indirectly through other inc files, rather than directly via `.bash_profile`. For instance, `functions.sh` sources a series of "cheat sheet" reminder functions in `cheat-sheet.sh`.

One-time setup scripts meant to be run on a brand new OS reside in **setup**.

Global configuration files reside in the **config** folders. If you're looking for a file which ends in "rc" it's probably in here (other than `.bashrc`).

