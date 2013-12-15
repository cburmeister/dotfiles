ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git pip python brew heroku)

setopt hist_ignore_dups

source "$ZSH/oh-my-zsh.sh"

PATH="/usr/local/share/npm/bin:$PATH"
PATH="/usr/local/heroku/bin:$PATH"
PATH="/usr/local/bin:$PATH"

export PATH

eval "$(pyenv init -)"

alias ls='ls -GpF'
