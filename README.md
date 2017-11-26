dotfiles
========

My system configuration.

---

## Usage

Install UNIX and OSX binaries with [brew](https://brew.sh/):
```bash
brew bundle
```

Configure individual packages with [stow](https://www.gnu.org/software/stow/):
```bash
stow -t $HOME zsh
```

## Tools

These are some of the packages in the `Brewfile` which I use daily.

### [asciinema](https://asciinema.org/)

The right way to record and share terminal sessions.

### [ag](https://github.com/ggreer/the_silver_searcher)

This is an `ack` or `grep` replacement that is magnitudes faster.

### [dinghy](https://github.com/codekitchen/dinghy)

This makes running `docker` on OSX via a virtual machine easy.

### [entr](http://entrproject.org/)

Run arbitrary commands when files change. For example; while editing unit tests.

### [grip](https://github.com/joeyespo/grip)

Preview GitHub rendered markdown locally when working on README's or presenting.

### [ngrok](https://github.com/inconshreveable/ngrok)

A reverse proxy useful for exposing a local port to the internet or testing webhooks.

### [pass](https://www.passwordstore.org/)

Maintain secrets encrypted with `gpg` via the command line.

### [pianobar](https://github.com/PromyLOPh/pianobar)

Enjoy Pandora radio from the command line.

### [pyenv](https://github.com/pyenv/pyenv)

Maintain multiple versions of python on your system.

### [ranger](https://github.com/ranger/ranger)

A file manager for the command line.

### [tmux](https://tmux.github.io/)

The terminal multiplexer. Infinite terminal sessions within a single terminal session.

### [vim](https://github.com/vim/vim)

The text editor. There is no substitute in my opinion.

### [zsh](http://zsh.sourceforge.net/)

I would stick with `/bin/bash` if it included the goodies `/bin/zsh` provides.
