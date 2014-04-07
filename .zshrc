fpath=($HOME/zsh/completions $fpath)
autoload -U compinit && compinit
autoload -U colors && colors

setopt prompt_subst

PATH="$HOME/.bin:$PATH"
PATH="$HOME/.rvm/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/local/heroku/bin:$PATH"
PATH="/usr/local/share/npm/bin:$PATH"

typeset -U PATH
export PATH

export CLICOLOR=1
export EDITOR=/usr/bin/vim
export PYTHONSTARTUP=~/.pythonrc.py
export VIRTUAL_ENV_DISABLE_PROMPT=1

if [ -d "$HOME/.teamocil" ]; then
    compctl -g '~/.teamocil/*(:t:r)' teamocil
fi

if which pyenv > /dev/null; then
    eval "$(pyenv init -)";
    pyenv virtualenvwrapper
fi

if [ -s "$HOME/.rvm/scripts/rvm" ]; then
    source "$HOME/.rvm/scripts/rvm"
fi

if [ -s "/usr/local/opt/autoenv/activate.sh" ]; then
    source /usr/local/opt/autoenv/activate.sh
fi

function parse_git_branch {
    if which git > /dev/null; then
        git branch 2> /dev/null \
            | grep "*" \
            | sed -e 's/* \(.*\)/ \1/g' \
            | { read branch; [[ -n $branch ]] && echo " $fg[white]on $fg[red]$branch"; }
    fi
}

function parse_virtual_env {
    echo $VIRTUAL_ENV \
        | grep -Eo '[^/]+/?$' \
        | cut -d / -f1 \
        | { read env; [[ -n $env ]] && echo " $fg[white]using $fg[blue]$env" ; }
}

PROMPT='$fg[green]%~$(parse_git_branch)$(parse_virtual_env) $fg[white]→ '
