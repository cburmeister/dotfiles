fpath=(/usr/local/share/zsh/site-functions $fpath)

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -U compinit && compinit
autoload -U colors && colors

setopt prompt_subst
setopt no_case_glob
setopt appendhistory  # don't clobber history files

export CLICOLOR=1
export EDITOR=/usr/bin/vim
export PYTHONSTARTUP=~/.pythonrc.py

bindkey '^R' history-incremental-search-backward

PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$HOME/.bin"
PATH="$PATH:$HOME/Dropbox/bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/local/share/npm/bin"

if [ -s "/usr/local/opt/autoenv/activate.sh" ]; then
    source /usr/local/opt/autoenv/activate.sh
fi

typeset -ga precmd_functions

function parse_git_branch {
    if $(git rev-parse --is-inside-work-tree > /dev/null 2>&1); then
        git_branch=$(echo " %{$fg[white]%}on %{$fg[red]%}$(git rev-parse --abbrev-ref HEAD)")
    else
        git_branch=""
    fi
}

function parse_virtual_env {
    if [ -n "${VIRTUAL_ENV}" ]; then
        virtual_env=$(echo " %{$fg[white]%}using %{$fg[blue]%}${VIRTUAL_ENV##*/}")
    else
        virtual_env=""
    fi
}

precmd_functions+=parse_git_branch
precmd_functions+=parse_virtual_env

precmd() { print "" }

newline=$'\n'
PS1='%{$fg[yellow]%}%n%{$fg[white]%} @ %{$fg[magenta]%}%m '
PS1+='%{$fg[white]%}in %{$fg[green]%}%~'
PS1+='${git_branch}${virtual_env} %{$fg[white]%}${newline}$ '

alias dm='docker-machine'
alias dc='docker-compose'
alias dcr='docker-compose run --rm'
alias dcu='docker-compose up -d --no-recreate'

function dme {
    eval "$(docker-machine env $1)" && docker-machine ls
}
