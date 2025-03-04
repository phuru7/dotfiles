#! /bin/bash

DOTFILES=(.vimrc .zshrc .tmux.conf)

for dotfile in ${DOTFILES[*]};
do
    cp $dotfile ~/$dotfile
done

