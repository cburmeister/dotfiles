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
