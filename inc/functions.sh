# Simple calculator
function calc() {
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
function mkd() {
	mkdir -p "$@" && cd "$@"
}

# Determine size of a file or total size of a directory
function fs() {
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
	function diff() {
		git diff --no-index --color-words "$@"
	}
fi

# Create a data URL from a file
function dataurl() {
	local mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Create a git.io short URL
function gitio() {
	if [ -z "${1}" -o -z "${2}" ]; then
		echo "Usage: \`gitio slug url\`"
		return 1
	fi
	curl -i http://git.io/ -F "url=${2}" -F "code=${1}"
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}"
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
	local port="${1:-4000}"
	local ip=$(ipconfig getifaddr en0)
	sleep 1 && open "http://${ip}:${port}/" &
	php -S "${ip}:${port}"
}

# Install Grunt plugins and add them as `devDependencies` to `package.json`
# Usage: `gi contrib-watch contrib-uglify zopfli`
function gi() {
	local IFS=,
	eval npm install --save-dev grunt-{"$*"}
}

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
function s() {
  if [ $# -eq 0 ]; then
    subl .
  else
    subl "$@"
  fi
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v() {
  if [ $# -eq 0 ]; then
    vim .
  else
    vim "$@"
  fi
}

# `o` with no arguments opens current directory, otherwise opens the given
# location
function o() {
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
function tre() {
        tree -aC -I '.git|node_modules|bower_components|.sass-cache' --dirsfirst "$@" | less -FRNX
}

# Top 10 BASH commands used
# from stackoverflow.com/questions/68372/what-is-your-single-most-favorite-command-line-trick-using-bash#answer-68390
function top10() {
    history | awk 'BEGIN {FS="[ \t]+|\\|"} {print $3}' | sort | uniq -c | sort -nr | head
}

# sass --watch syntax is too verbose
function sw() {
    sass --watch $1:$2 --style compressed
}

function backup() {
    if [ -d /Volumes/share ]; then
        # flags:
        # a = archive mode, makes recursive & a host of other options
        # v = verbose
        # u = if destination file is more recent, keep it
        # z = use compression
        rsync -avuz --progress \
        	--exclude "iTunes/iTunes Music/Podcasts/" \
          --exclude "iTunes/iTunes Media/Podcasts/" \
        	--exclude "iTunes/Album Artwork/" \
        	--exclude "iTunes/iTunes Media/Mobile Applications/" \
        	~/Music /Volumes/share/
        rsync -avuz --progress ~/Movies/ /Volumes/share/Video/
        rsync -avuz --progress ~/Documents/zzzArc /Volumes/share/
        # b = create backups
        rsync -avuzb --progress ~/Documents/OvalII.sparsebundle /Volumes/share/OvalII.sparsebundle
        rsync -avuzb --progress ~/Documents/nsn.dmg /Volumes/share/nsn.dmg
        # run Spideroak backups w/o the GUI
        /Applications/SpiderOak.app/Contents/MacOS/SpiderOak --batchmode
    else
        echo "Connect to backup drive first."
    fi
}

source cheat-sheets.sh
