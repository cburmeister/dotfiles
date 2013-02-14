# @bluetickk does dotfiles

VIM Plugins
===

1. [Pathogen](https://github.com/tpope/vim-pathogen)
2. [NERDTree](https://github.com/scrooloose/nerdtree)
2. [Ack](https://github.com/mileszs/ack.vim)
3. [Solarized](https://github.com/altercation/vim-colors-solarized)
4. [CtrlP](https://github.com/kien/ctrlp.vim)
5. [Fugitive](https://github.com/tpope/vim-fugitive)
6. [NERDCommenter](https://github.com/scrooloose/nerdcommenter)
7. [Jinja Syntax](https://github.com/Glench/Vim-Jinja2-Syntax)

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
  ```

4. Get the dotfiles

  ```bash
    $ git clone git://github.com/cburmeister/dotfiles.git ~/.dotfiles
  ```

5. Link it up

  ```bash
    $ ln -s ~/.dotfiles/vim ~/.vim
    $ ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
    $ ln -s ~/.dotfiles/vim/bundle/jinja/syntax ~/.vimrc
```
