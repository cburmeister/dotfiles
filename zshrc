ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ys"

# autocomplete functions directory
fpath=($HOME/zsh/completions $fpath)

# enable autocomplete function
autoload -U compinit
compinit

plugins=(git pip python brew heroku pass rvm)

setopt hist_ignore_dups

source "$ZSH/oh-my-zsh.sh"

PATH="/usr/local/share/npm/bin:$PATH"
PATH="/usr/local/heroku/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="~/bin:$PATH"
PATH="~/.rvm/bin:$PATH"

export PATH

eval "$(pyenv init -)"
pyenv virtualenvwrapper

export PYTHONSTARTUP=~/.pythonrc.py

alias ls='ls -GpF'
