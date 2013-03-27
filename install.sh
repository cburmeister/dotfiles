#!/usr/bin/env bash

echo "Initializing submodules..."
git submodule init
git submodule update

echo "Deleting the old files..."
rm ~/.vimrc
rm ~/.vim
rm ~/.ackrc
rm ~/.zshrc

echo "Symlinking files..."
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/ackrc ~/.ackrc
ln -s ~/.dotfiles/zshrc ~/.zshrc

echo "Updating submodules..."
git submodule foreach git pull origin master --recurse-submodules

echo "All done..."
