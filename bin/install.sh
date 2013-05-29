#!/usr/bin/env bash

echo "[+] Initializing submodules..."
git submodule init
git submodule update

echo "[+] Deleting the old files..."
rm -r ~/bin
rm ~/.vimrc
rm ~/.vim
rm ~/.ackrc
rm ~/.zshrc
rm ~/.tmux.conf
rm ~/.gitconfig
rm ~/.pythonrc.py
rm ~/.editrc
rm ~/.my.cnf

echo "[+] Symlinking files..."
ln -s ~/.dotfiles/bin ~/bin
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/ackrc ~/.ackrc
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/pythonrc.py ~/.pythonrc.py
ln -s ~/.dotfiles/editrc ~/.editrc
ln -s ~/.dotfiles/my.cnf ~/.my.cnf

echo "[+] Updating submodules..."
git submodule foreach git pull origin master --recurse-submodules

echo "[+] Done..."
