#!/bin/bash
# more conservative version of bootstrap.sh
for file in .{path,bash_prompt,exports,aliases,functions,extra}; do
    cp "$file" ~/"$file"
done

# concatenate dotfiles .gitconfig w/ user-specific settings in ~/.user-gitconfig
if [ -f .gitconfig ] && [ -f ~/.user-gitconfig ]; then
    cat ~/.user-gitconfig .gitconfig > ~/.gitconfig
fi

source ~/.bash_profile
