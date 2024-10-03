#! /bin/bash

DOTFILES=(.bash_profile .gitconfig .gitignore .vimrc .zshrc)

for dotfile in ${DOTFILES[*]};
do
    cp $dotfile ~/$dotfile
done

