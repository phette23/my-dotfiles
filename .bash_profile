# load all the other shell customizations
for file in ~/.inc/{path,bash_prompt,exports,aliases,functions,extra}.sh; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# source OS-specific stuff
[[ $(uname) == "Darwin" ]] && [ -f ~/.inc/mac.sh ] && source ~/.inc/mac.sh
[[ $(uname) == "Linux" ]] && [ -f ~/.inc/linux.sh ] &&  source ~/.inc/linux.sh

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

# load Node Version Manager
[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh && nvm use default > /dev/null
