fpath=($HOME/.zsh/completions $fpath)

autoload -U compinit && compinit
autoload -U colors && colors

setopt prompt_subst
setopt no_case_glob

export CLICOLOR=1
export EDITOR=/usr/bin/vim
export PYTHONSTARTUP=~/.pythonrc.py
export VIRTUAL_ENV_DISABLE_PROMPT=1

bindkey '^R' history-incremental-search-backward

PATH="$PATH:$HOME/.bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/local/heroku/bin"
PATH="$PATH:/usr/local/share/npm/bin"

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

typeset -ga precmd_functions

function parse_git_branch {
    if which git > /dev/null; then
        git_branch=$(git branch 2> /dev/null \
            | grep "*" \
            | sed -e 's/* \(.*\)/ \1/g' \
            | { read branch; [[ -n $branch ]] && echo " %{$fg[white]%}on %{$fg[red]%}$branch"; })
    fi
}

function parse_virtual_env {
    virtual_env=$(echo $VIRTUAL_ENV \
        | grep -Eo '[^/]+/?$' \
        | cut -d / -f1 \
        | { read env; [[ -n $env ]] && echo " %{$fg[white]%}using %{$fg[blue]%}$env" ; })
}

precmd_functions+=parse_git_branch
precmd_functions+=parse_virtual_env

PS1='%{$fg[green]%}%~${git_branch}${virtual_env} %{$fg[white]%}→ '
