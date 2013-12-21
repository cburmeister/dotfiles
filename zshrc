ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

# autocomplete functions directory
fpath=($HOME/zsh/completions $fpath)

# enable autocomplete function
autoload -U compinit
compinit

plugins=(git pip python brew heroku pass)

setopt hist_ignore_dups

source "$ZSH/oh-my-zsh.sh"

PATH="/usr/local/share/npm/bin:$PATH"
PATH="/usr/local/heroku/bin:$PATH"
PATH="/usr/local/bin:$PATH"

export PATH

eval "$(pyenv init -)"

export PYTHONSTARTUP=~/.pythonrc.py

alias ls='ls -GpF'
