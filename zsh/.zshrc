autoload -Uz compinit colors vcs_info
colors  # Enable colors
compinit  # Enable completion

setopt no_case_glob  # Ignore case when globbing
setopt appendhistory  # dont clobber history files

export CLICOLOR=1  # Enable colors when using `ls`
export EDITOR=/usr/bin/vim  # Duh
export PYTHONSTARTUP=~/.pythonrc.py
export VIRTUAL_ENV_DISABLE_PROMPT=yes

# Reverse search history
bindkey "^R" history-incremental-search-backward

# Enable pyenv and pyenv-virtualenvwrapper
if command -v pyenv > /dev/null; then
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
fi

if command -v pyenv virtualenvwrapper > /dev/null; then
    export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
    pyenv virtualenvwrapper_lazy
fi

# Enable docker via dinghy
eval $(dinghy env)

# Reroute zsh history and expand the capacity
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

# Setup path
PATH="$PATH:$HOME/bin"

# Enable vcs info in prompt
zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:git*" formats "on $fg[red]%b$reset_color"
precmd() {
    vcs_info
    print ""  # Extra newline before each prompt
}

# Format prompt
setopt prompt_subst  # Enable command substitution within the prompt
PS1="%F{yellow}%n%f @ %F{magenta}%m%f in %F{green}%~%f \$vcs_info_msg_0_
$ "

# Setup some aliases
alias d="docker"
alias dc="docker-compose"
alias dcr="docker-compose run --rm"
alias dcu="docker-compose up -d --no-recreate"
alias g="git"
alias k="kubectl"

# Enable kubernetes tab completion
source <(kubectl completion zsh | sed s/kubectl/kwrapper/g)

# Source my private/work configuration if mounted on this machine
if [ -s "$HOME/Dropbox/.zshrc" ]; then
    source "$HOME/Dropbox/.zshrc"
fi
