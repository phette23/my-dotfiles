# internal functions for use in cheat sheets below
function colorcheat() {
    echo -n "$ORANGE$1$RESET"
    echo -e "$2"
}
function cheattitle() {
    echo -e "$PURPLE\t\t$1\n$RESET"
}

# Misc tips from above link
function cheatmoar() {
    cheattitle "more bash tricks"
    colorcheat '^+R' "\t\t-> reverse search through history"
    colorcheat 'Quick Copy' "\t-> cp /home/foo/realllylongname.cpp{,-old}\n\t\tExpands to:\n\t\tcp /home/foo/realllylongname.cpp /home/foo/realllylongname.cpp-old"
    colorcheat '^str^str2' "\t-> replaces str in the last cmd with str2 & executes it"
    echo -en "$ORANGE" && echo -en '! tricks ' && echo -en "$RESET\t-> the " && echo -e '!$, !^ & !* expandos return, from the most recent line:\n\t\tthe last item, first non-cmd item, & all non-cmd items'
    echo -en "$ORANGE" && echo -en 'cmd !!:* ' && echo -e "$RESET\t-> run cmd with the previous ones' arguments"
    colorcheat 'ESC .' "\t\t-> insert last arguments from last cmd"
    colorcheat 'Alt-$N, Alt-Ctrl-Y' " -> insert Nth argument from last cmd"
    colorcheat '\cmd' "\t\t-> do not use the alias for 'cmd'"
    echo -en "$ORANGE" && echo -en '!?foo?:p ' && echo -en "$RESET\t-> search for last cmd containing 'foo,' " && echo -e '!?foo executes'
    echo
}

# Print cheat sheet of dotfiles functions/aliases
function cheat() {
    cheattitle "bash cheatsheet"
    colorcheat 'c' "\t\t-> trim new lines & copy to clipboard"
    colorcheat '^+A' "\t\t-> jump to beginning of line"
    colorcheat '^+E' "\t\t-> jump to end of line"
    colorcheat '^+K' "\t\t-> delete to end of line"
    colorcheat '^+U' "\t\t-> delete to beginning of line"
    colorcheat '^+W' "\t\t-> delete word next to cursor"
    colorcheat 'dataurl' "\t\t-> make data URL from file"
    colorcheat 'gi' "\t\t-> install Grunt plugin, e.g. 'gi contrib-uglify'"
    colorcheat 'gurl' "\t\t-> Gzip-enabled curl"
    colorcheat 'oo' "\t\t-> open current directory"
    colorcheat 'spot(off|on)' "\t-> turn Spotlight off & on"
    colorcheat 'tar -zxvf $FILE' "\t-> unzip tar ball"
    colorcheat 'urlencode' "\t-> URL encode string"
    echo
}

function gcheat() {
    # template: echo -e "$ORANGE cmd \t\t\t$RESET— description"
    cheattitle "git cheatsheet"
    colorcheat 'g d' "\t\t\t-> diff between latest commit & current state"
    colorcheat 'g di $N' "\t\t\t-> diff betw N commits ago & current state"
    colorcheat 'g go X' "\t\t\t-> goto branch X, create if doesn't exist"
    colorcheat 'g reset $HASH' "\t\t-> revert to commit HASH but keep changes in working dir\n\t\t\tadd --hard flag to erase changes"
    colorcheat 'g checkout -- <file>' "\t-> unstage changes to <file>"
    colorcheat 'g push origin $BRANCH' "\t-> push BRANCH to GitHub (remote)"
    echo
}
