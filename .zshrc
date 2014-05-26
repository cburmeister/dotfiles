function configure_zsh {
    fpath=($HOME/.zsh/completions $fpath)

    autoload -U compinit && compinit
    autoload -U colors && colors

    setopt prompt_subst
    setopt no_case_glob

    export CLICOLOR=1
    export EDITOR=/usr/bin/vim
    export PYTHONSTARTUP=~/.pythonrc.py
    export VIRTUAL_ENV_DISABLE_PROMPT=1

    HISTFILE=~/.histfile
    HISTSIZE=1000
    SAVEHIST=1000
    setopt appendhistory  # don't clobber history files

    bindkey '^R' history-incremental-search-backward
}

function setup_path {
    PATH="$PATH:$HOME/.bin"
    PATH="$PATH:/usr/local/bin"
    PATH="$PATH:/usr/local/heroku/bin"
    PATH="$PATH:/usr/local/share/npm/bin"
}

function setup_services {
    if [ -d "$HOME/.teamocil" ]; then
        compctl -g '~/.teamocil/*(:t:r)' teamocil
    fi

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

    if which boot2docker > /dev/null; then
        if boot2docker status | grep running > /dev/null; then
            export DOCKER_HOST=tcp://localhost:4243
        fi
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

    PS1='%{$fg[green]%}%~${git_branch}${virtual_env} %{$fg[white]%}→ '
}

configure_zsh
setup_path
setup_services
setup_prompt
