eval "$(/opt/homebrew/bin/brew shellenv)"

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

################################################################################
# Modules
################################################################################

autoload -Uz compinit colors vcs_info
colors  # Enable colors
compinit  # Enable completion

################################################################################
# Configuration
################################################################################

unsetopt correct_all  # Disable spell check for command line arguments
setopt NO_CASE_GLOB  # Ignore case when globbing

################################################################################
# Key bindings
################################################################################

source <(fzf --zsh)  # Fuzzy history search (Ctrl-R), file finding (Ctrl-T), cd (Alt-C)

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

# Catppuccin Mocha Palette:
# %b (Branch)   -> #f38ba8 (Red/Pink)
# %n (User)     -> #89b4fa (Blue)
# %m (Machine)  -> #cba6f7 (Mauve/Purple)
# %~ (Path)     -> #a6e3a1 (Green)
# Arrow symbol  -> #f5c2e7 (Pink)

# Enable vcs info in prompt
autoload -Uz vcs_info
zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:git*" formats "on %F{#f38ba8}%b%f"

precmd() {
    vcs_info
    print ""  # Extra newline
}

setopt prompt_subst

PS1='%F{#89b4fa}%n%f @ %F{#cba6f7}%m%f in %F{#a6e3a1}%~%f ${vcs_info_msg_0_}
%F{#f5c2e7}❯%f '

################################################################################
# Environment
################################################################################

export CLICOLOR=1  # Enable colors
export EDITOR=vim  # Duh

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

if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi
