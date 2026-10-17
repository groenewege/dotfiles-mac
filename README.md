# dotfiles-mac

The configuration of my Mac, my primary development machine (Laravel Valet,
PHP 7.1–8.4, DBngin MySQL). Two jobs:

1. Keep my AI agent setup in sync with my Omarchy laptop, through
   [dotfiles-ai](https://github.com/groenewege/dotfiles-ai).
2. Back up the config I'd want on a new Mac, with a guide to get there:
   [docs/new-mac.md](docs/new-mac.md).

`install.sh` only links files. It never installs or upgrades anything, so it
can't disturb Valet, PHP, MySQL or git.

## Install

```bash
git clone https://github.com/groenewege/dotfiles-mac.git ~/Code/dotfiles-mac
~/Code/dotfiles-mac/install.sh            # every step
~/Code/dotfiles-mac/install.sh link       # one step: ai, link or check
```

Needs GNU stow: `HOMEBREW_NO_AUTO_UPDATE=1 brew install stow` (no dependencies).
Anything a step replaces goes to `~/.dotfiles-backup/<timestamp>/` first.

## Layout

```
install.sh               steps: ai, link, check
lib/common.sh            helpers (same as dotfiles-omarchy's, bash 3.2 safe)
stow/<package>/          files laid out as in $HOME, symlinked with GNU stow
  zsh/                   ~/.config/zsh: aliases, functions, exports
  git/                   ~/.config/git: dotfiles.gitconfig, global ignore
  zed/                   Zed settings, keymap, tasks
  herdr/                 herdr config
  bin/                   ~/.local/bin: workon, the Raycast script for it
  claude/                Claude Code status line
templates/               reference copies, not linked: .zshrc, Claude settings
                         (secrets removed), ssh config (no hosts)
Brewfile                 what Homebrew had installed; a reference, never run here
docs/new-mac.md          setting up a new Mac
```

### Two ways of managing a config file

1. **We own the whole file → stow.** Editing `~/.config/zsh/aliases.zsh` edits
   the repo. Run `git status` here to see what changed.
2. **Shared with the machine → one hook line.** We never replace these:
   - `~/.zshrc` (Oh My Zsh's file, with the PATH lines) gets
     `source ~/.config/zsh/init.zsh` at the end.
   - `~/.gitconfig` (with the gh credential helper) gets
     `[include] path = ~/.config/git/dotfiles.gitconfig`.

`~/.claude/settings.json` holds a token and Mac-only hooks, so it is not linked;
`templates/claude-settings.json` is a copy without the token.

## Everyday use

| To… | Do this |
|---|---|
| Add an alias or function | edit `~/.config/zsh/aliases.zsh` / `functions.zsh`, open a new terminal |
| Add a config file | put it in `stow/<app>/` at its path under `$HOME`, then `./install.sh link` |
| Check nothing replaced a link | `./install.sh check` (Zed and herdr can rewrite their files) |
| Change a skill or AGENTS.md | edit it in `~/.claude/skills/…` (it's dotfiles-ai), commit and push there |
| Get skills from Omarchy | `git -C ~/Code/dotfiles-ai pull && ~/Code/dotfiles-ai/install.sh` |
| Refresh the Brewfile | `HOMEBREW_NO_AUTO_UPDATE=1 brew bundle dump --file=Brewfile --force` (keep the header) |

This repo is public: client names, server hosts and tokens stay out of it.
