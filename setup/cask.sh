#! /usr/bin/env bash
if [ ! $(command -v brew) ]; then
  echo "You need to install homebrew first, dummy."
  exit 1;
fi

brew tap phinze/homebrew-cask
brew install brew-cask

brew cask install \
  alfred \
  audacity \
  calibre \
  clamxav \
  dropbox \
  firefox \
  firefox-aurora \
  github \
  google-chrome \
  google-chrome-canary \
  google-drive \
  imageoptim \
  inkscape \
  iterm2 \
  lastfm \
  menu-meters \
  pandoc \
  prey \
  quicksilver \
  scribus \
  sublime-text-3 \
  tor-browser \
  zotero \
