fpath=(/usr/local/share/zsh/site-functions $fpath)

autoload -U colors && colors  # Enable colors
autoload -U compinit && compinit  # Enable completion

setopt no_case_glob  # Ignore case when globbing
setopt appendhistory  # don't clobber history files

export CLICOLOR=1  # Enable colors when using `ls`
export EDITOR=/usr/bin/vim  # Duh
export PYTHONSTARTUP=~/.pythonrc.py
export VIRTUAL_ENV_DISABLE_PROMPT=yes
export GRUNT_CLONE_TOKEN=`cat $HOME/.discogs.clone.token`

# Reverse search history
bindkey "^R" history-incremental-search-backward

# Enable autoenv
if [ -s "/usr/local/opt/autoenv/activate.sh" ]; then
    source "/usr/local/opt/autoenv/activate.sh"
fi

# Enable pyenv and virtualenvwrapper
if which pyenv > /dev/null; then
    eval "$(pyenv init -)" && pyenv virtualenvwrapper
fi

# Enable node version manager
export NVM_DIR="$HOME/.nvm"
source "/usr/local/opt/nvm/nvm.sh"

# Enable docker via dinghy
eval $(dinghy env)

# Reroute zsh history and expand the capacity
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Setup path
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/Dropbox/bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/local/share/npm/bin"
PATH="$PATH:$HOME/src/platform/cli-utils"

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
alias dm="docker-machine"
alias g="git"
alias k="kwrapper"

# Get me today's new deep house releases on juno.co.uk
function juno() {
    curl -s http://www.juno.co.uk/deep-house/today/ \
        | pup 'a:contains("Juno Player") attr{href}' \
        | xargs -0  printf 'http://www.juno.co.uk%s' \
        | xargs open
}

# Let me know when some command is finished executing
function lmk() {
    start=$(date +%s)
    eval $@
    duration=$(($(date +%s) - start))
    echo "\"$@\" completed in $duration seconds." | ham
}
