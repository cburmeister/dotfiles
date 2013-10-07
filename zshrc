ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
PYTHONSTARTUP=~/.pythonrc.py
WORKON_HOME=$HOME/.virtualenvs

plugins=(git pip python brew heroku)

setopt hist_ignore_dups

source $ZSH/oh-my-zsh.sh
eval "$(pyenv init -)"

source /usr/local/opt/autoenv/activate.sh

PATH="/usr/local/share/npm/bin:$PATH"
PATH="/usr/local/heroku/bin:$PATH"
PATH="/usr/local/bin:$PATH"

export PATH

alias ls='ls -GpF'
