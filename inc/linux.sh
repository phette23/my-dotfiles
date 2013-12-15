# Linux version of update command
alias update='npm update npm -g; npm udpate -g; sudo gem update; sudo apt-get update -qq; sudo apt-get upgrade -y;'

# Linux version of emptytrash
alias emptytrash='rm -rf ~/.local/share/Trash/files/*'

# Searching for packages is too verbose
alias aptfind='apt-cache search'

# for piping text to clipboard, requires xclip
alias clip='xclip -sel clip'

# Source-Highlight, requires the package in apt
alias ccat='/usr/share/source-highlight/src-hilite-lesspipe.sh'

# source Z from Linux install location
[ -f /usr/local/etc/z/z.sh ] && source /usr/local/etc/z/z.sh

# make title of terminal tab the current directory's name
# pwd, tr replace / for newline, tail take last line
export PS1="\[\e]0;\$(pwd | tr '/' '\n' | tail -n1)\a\]$PS1"

# disable trackpad while typing in Openbox window manager
[[ ${DESKTOP_SESSION} == "openbox" ]] && synclient MaxTapTime=0
