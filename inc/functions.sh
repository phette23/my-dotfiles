# Simple calculator
calc () {
	local result=""
	result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
	#                       └─ default (when `--mathlib` is used) is 20
	#
	if [[ "$result" == *.* ]]; then
		# improve the output for decimal numbers
		printf "$result" |
		sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
		    -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
		    -e 's/0*$//;s/\.$//'   # remove trailing zeros
	else
		printf "$result"
	fi
	printf "\n"
}

# Create a new directory and enter it
mkd () {
	mkdir -p "$@" && cd "$@"
}

# Determine size of a file or total size of a directory
fs () {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@"
	else
		du $arg .[^.]* *
	fi
}

# Use Git’s colored diff when available
hash git &>/dev/null
if [ $? -eq 0 ]; then
	diff () {
		git diff --no-index --color-words "$@"
	}
fi

# Create data URL from a file
dataurl () {
	local mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Start a Python HTTP server from a directory, optionally specifying the port
server () {
	local port="${1:-8000}"
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items ():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test ();' "$port"
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
phpserver () {
	local port="${1:-4000}"
	local ip=$(ipconfig getifaddr en0)
	sleep 1 && open "http://${ip}:${port}/" &
	php -S "${ip}:${port}"
}

# Install Grunt plugins and add them as `devDependencies` to `package.json`
# Usage: `gi contrib-watch contrib-uglify zopfli`
gi () {
	npm install --save-dev grunt-${1}
}

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
s () {
  if [ $# -eq 0 ]; then
    subl .
  else
    subl "$@"
  fi
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
v () {
  if [ $# -eq 0 ]; then
    vim .
  else
    vim "$@"
  fi
}

# `o` with no arguments opens current directory, otherwise opens the given
# location
o () {
  # must test for xdg-open, because "open" exists on both
  # but is useless on Linux
    if [ $(type -P xdg-open) ]; then
    	local opencmd="xdg-open"
    else
    	local opencmd="open"
    fi

    if [ $# -eq 0 ]; then
        $opencmd .
    else
        $opencmd "$@"
    fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre () {
    tree -aC -I '.git|node_modules|bower_components|.sass-cache' --dirsfirst "$@" | less -FRNX
}

# Top 10 BASH commands used
# from stackoverflow.com/questions/68372/what-is-your-single-most-favorite-command-line-trick-using-bash#answer-68390
top10 () {
    history | awk 'BEGIN {FS="[ \t]+|\\|"} {print $3}' | sort | uniq -c | sort -nr | head
}

# A simple prompt for distraction-free screencasts
simpleprompt () {
    echo 'Simple prompt initiated. Source ~/.bash_profile to get back to complex.'
    export PS1="\[${BOLD}${ORANGE}\]$ \[${RESET}\]"
}

source ~/.inc/cheat-sheets.sh
