fpath=($HOME/zsh/completions $fpath)
autoload -U compinit
compinit

PATH="/usr/local/share/npm/bin:$PATH"
PATH="/usr/local/heroku/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="$HOME/.rvm/bin:$PATH"
PATH="$HOME/.bin:$PATH"

export PATH

export PYTHONSTARTUP=~/.pythonrc.py
export EDITOR=/usr/bin/vim

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
