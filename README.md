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

Install `tmux` plugins with [tpack](https://github.com/tmuxpack/tpack). After stowing `tmux`, install them once:
```bash
tpack install
```

## Claude Code

Stow `claude` with `--no-folding` to avoid linking the rest of `~/.claude`:
```bash
stow --no-folding -t $HOME claude
```

Add the status line to `~/.claude/settings.json` (plugins can't set it):
```json
{
  "statusLine": {
    "type": "command",
    "command": "bash ~/.claude/statusline-command.sh"
  }
}
```
