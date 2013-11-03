#!/usr/bin/env bash
if [ ! $(command -v brew) ]; then
  echo "You need to install homebrew first, dummy."
  exit 1;
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
# Install Bash 4
brew install bash

# Install wget with IRI support
brew install wget --enable-iri

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep
brew tap josegonzalez/homebrew-php
brew install php55

# Install other useful packages
brew install ack \
	closure-compiler \
	drush \
	exiftool \
	git \
	gnupg \
	imagemagick \
	jshon \
	lynx \
	node \
	optipng \
	phantomjs \
	pngcrush \
	rbenv \
	rename \
	"source-highlight" \
	tree \
	webkit2png \
	z

# Remove outdated versions from the cellar
brew cleanup
