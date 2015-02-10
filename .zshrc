function configure_zsh {
    fpath=(/usr/local/share/zsh/site-functions $fpath)

    autoload -U compinit && compinit
    autoload -U colors && colors

    setopt prompt_subst
    setopt no_case_glob

    export CLICOLOR=1
    export EDITOR=/usr/bin/vim
    export PYTHONSTARTUP=~/.pythonrc.py
    export VIRTUAL_ENV_DISABLE_PROMPT=1

    export GOPATH=$HOME/src/go

    HISTFILE=~/.histfile
    HISTSIZE=1000
    SAVEHIST=1000
    setopt appendhistory  # don't clobber history files

    bindkey '^R' history-incremental-search-backward
}

function setup_path {
    PATH="$PATH:$HOME/.bin"
    PATH="$PATH:/usr/local/bin"
    PATH="$PATH:/usr/local/Cellar/mysql55/5.5.40"
    PATH="$PATH:/usr/local/Cellar/mysql55/5.5.40/bin"
    PATH="$PATH:/usr/local/heroku/bin"
    PATH="$PATH:/usr/local/share/npm/bin"
    PATH="$PATH:$GOPATH/bin"
}

function setup_services {
    if which pyenv > /dev/null; then
        eval "$(pyenv init -)";
        pyenv virtualenvwrapper
    fi

    if which rbenv > /dev/null; then
        eval "$(rbenv init -)";
    fi

    if [ -s "/usr/local/opt/autoenv/activate.sh" ]; then
        source /usr/local/opt/autoenv/activate.sh
    fi
}

function setup_prompt {
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
    PS1+='${git_branch}${virtual_env} %{$fg[white]%}${newline}→ '
}

configure_zsh
setup_path
setup_services
setup_prompt
