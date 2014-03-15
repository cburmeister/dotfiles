#!/bin/bash

DOTFILES=$HOME/dotfiles

link() {
    ln -s $DOTFILES/$1 $HOME/$1
    rm -rf $HOME/$1;
}

link .ackrc
link .bin
link .config
link .editrc
link .gitconfig
link .pythonrc.py
link .screenrc
link .teamocil
link .tmux.conf
link .vimrc
link .zsh
link .zshrc
