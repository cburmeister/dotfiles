# @bluetickk does dotfiles

## Install

1. Install [homebrew](http://mxcl.github.com/homebrew/)
```bash
$ ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
```
2. Install [Ack](https://github.com/mileszs/ack.vim)
```bash
$ brew install ack
```
3. Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
```bash
$ curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
4. Get the dotfiles
```bash
$ git clone git://github.com/cburmeister/dotfiles.git ./dotfiles
```
5. Link it up
```bash
cd ~/.dotfiles
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
```
