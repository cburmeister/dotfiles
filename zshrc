ZSH=$HOME/.oh-my-zsh

ZSH_THEME="leftovers"

plugins=(git pip python brew)

setopt hist_ignore_dups  # dont record immediate dupes in history

source $ZSH/oh-my-zsh.sh

export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin
[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc

PATH=/usr/local/share/npm/bin:$PATH

export PYTHONSTARTUP=~/.pythonrc.py

alias ls='ls -GpF'
