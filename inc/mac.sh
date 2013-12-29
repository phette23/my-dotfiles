# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# Check if brew is defined, run Homebrew-specific commands
if command -v "brew" &> /dev/null 2>&1; then
    # Git Bash Completion for Homebrew package
    source /usr/local/etc/bash_completion.d/git-completion.bash

    # Z from Homebrew
    source `brew --prefix`/etc/profile.d/z.sh

    # BASH completion for Homebrew
    # See: github.com/mxcl/homebrew/wiki/Tips-N%27-Tricks
    source $(brew --prefix)/Library/Contributions/brew_bash_completion.sh
fi

# Show current dir name (not full path) in iTerm tab title
# but only if PROMPT_COMMAND doesn't already do so
# prevents login-shell-with-a-login-shell problems (e.g. tmux)
if [ $ITERM_SESSION_ID ] && [ ! "$(echo $PROMPT_COMMAND | egrep 'echo -ne "\\033\];')" ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi

# OS X Aliases

# Source-Highlight (requires Homebrew package)
alias ccat='src-hilite-lesspipe.sh'

# Update OS X software, Ruby gems, Homebrew, global NPM packages
alias update='npm update npm -g; npm update -g; sudo softwareupdate -i -a; gem update --system; gem update; brew update; brew upgrade;'

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# OS X Functions

# Add reminder to Reminders.app (OS X 10.8)
# Usage: `remind 'foo'` or `echo 'foo' | remind`
function remind() {
  local text
  if [ -t 0 ]; then
    text="$1" # argument
  else
    text=$(cat) # pipe
  fi
  osascript >/dev/null <<EOF
tell application "Reminders"
  tell the default list
    make new reminder with properties {name:"$text"}
  end tell
end tell
EOF
}

# Add note to Notes.app (OS X 10.8)
# Usage: `note 'title' 'body'` or `echo 'body' | note`
# Title is optional
function note() {
  local title
  local body
  if [ -t 0 ]; then
    title="$1"
    body="$2"
  else
    title=$(cat)
  fi
  osascript >/dev/null <<EOF
tell application "Notes"
  tell account "iCloud"
    tell folder "Notes"
      make new note with properties {name:"$title", body:"$title" & "<br><br>" & "$body"}
    end tell
  end tell
end tell
EOF
}
