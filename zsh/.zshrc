fpath=(/usr/local/share/zsh/site-functions $fpath)

autoload -U colors && colors  # Enable colors
autoload -U compinit && compinit  # Enable completion

setopt no_case_glob  # Ignore case when globbing
setopt appendhistory  # dont clobber history files

export CLICOLOR=1  # Enable colors when using `ls`
export EDITOR=/usr/bin/vim  # Duh
export PYTHONSTARTUP=~/.pythonrc.py
export VIRTUAL_ENV_DISABLE_PROMPT=yes

# Reverse search history
bindkey "^R" history-incremental-search-backward

# Enable pyenv and virtualenvwrapper
if which pyenv > /dev/null; then
    eval "$(pyenv init -)" && pyenv virtualenvwrapper
fi

# Enable docker via dinghy
eval $(dinghy env)

# Enable nodeenv
if which nodenv > /dev/null; then
    eval "$(nodenv init -)"
fi

# Reroute zsh history and expand the capacity
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

# Setup path
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$HOME/bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/local/share/npm/bin"

# Enable vcs info in prompt
autoload -U vcs_info
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
