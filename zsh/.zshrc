################################################################################
# Modules
################################################################################

autoload -Uz compinit colors vcs_info
colors  # Enable colors
compinit  # Enable completion

################################################################################
# Configuration
################################################################################

setopt CORRECT_ALL  # Spell check for command line arguments
setopt NO_CASE_GLOB  # Ignore case when globbing

################################################################################
# Key bindings
################################################################################

bindkey "^R" history-incremental-search-backward  # Reverse search history

################################################################################
# Enable pyenv and pyenv-virtualenvwrapper
################################################################################

if command -v pyenv > /dev/null; then
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
fi

if command -v pyenv virtualenvwrapper > /dev/null; then
    export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
    pyenv virtualenvwrapper_lazy
fi

################################################################################
# History
################################################################################

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

setopt EXTENDED_HISTORY  # Track command time/duration
setopt HIST_IGNORE_ALL_DUPS  # Clobber duplicates
setopt HIST_IGNORE_SPACE  # Don't remember commands that start with whitespace
setopt INC_APPEND_HISTORY  # Don't wait for shell to exit

################################################################################
# Prompt
################################################################################

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

################################################################################
# Path
################################################################################

PATH="$PATH:$HOME/bin"

################################################################################
# Environment
################################################################################

export CLICOLOR=1  # Enable colors
export EDITOR=vim  # Duh
export PYTHONSTARTUP=~/.pythonrc.py  # For python REPL history

################################################################################
# Aliases
################################################################################

alias d="docker"
alias dc="docker-compose"
alias dcr="docker-compose run --rm"
alias dcu="docker-compose up -d --no-recreate"
alias g="git"
alias k="kubectl"

################################################################################
# Per host ZSH configuration
################################################################################

if [ -s "$HOME/Dropbox/.zshrc" ]; then
    source "$HOME/Dropbox/.zshrc"
fi
