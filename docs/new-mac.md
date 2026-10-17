# Setting up a new Mac

A guide, not a script: run each step by hand and check it before the next.
Versions are what the old Mac ran in October 2026 (`Brewfile`, `valet isolated`).

## 1. Basics

1. Sign in to iCloud and the App Store, then install 1Password and sign in.
2. Xcode command line tools: `xcode-select --install` (this also gives you `git`).
3. [Homebrew](https://brew.sh), then `eval "$(/opt/homebrew/bin/brew shellenv)"`
   in `~/.zprofile` as the installer says.
4. [Oh My Zsh](https://ohmyz.sh) (it writes the `~/.zshrc` that `install.sh` hooks into).

## 2. Command-line tools

```bash
brew install gh jq fzf zoxide stow
gh auth login            # HTTPS; git uses gh as its credential helper
gh auth setup-git
```

Copy the PATH, zoxide and fzf lines from `templates/zshrc` into `~/.zshrc`.

## 3. PHP, Valet, MySQL

```bash
brew tap shivammathur/php
brew install php@8.3 php@8.1 shivammathur/php/php@7.1 composer
brew link --force php@8.3
composer global require laravel/valet laravel/installer laravel/forge-cli
valet install
cd ~/Sites && valet park
```

- Per-site PHP versions: `valet isolate php@7.1` inside the legacy projects
  (the DES apps, moirignot, pediadoc) and `valet isolate php@8.3` where needed.
  The aliases (`art`, `pam:fs`, `t`, `p`) go through `valet php`, so they follow it.
- MySQL: [DBngin](https://dbngin.com) with MySQL 8.0 (its `bin` is on the PATH
  in `~/.zshrc`). TablePlus for browsing.
- Mail: Mailpit (`brew install axllent/apps/mailpit`), meilisearch if a project uses it.

## 4. Node and JavaScript

Node from the [nodejs.org](https://nodejs.org) installer (LTS); it lands in
`/usr/local/bin`.

## 5. AI tools

```bash
curl -fsSL https://claude.ai/install.sh | bash   # Claude Code in ~/.local/bin
npm install -g @openai/codex
```

herdr and herdr-plus (`brew tap cloudmanic/herdr-plus`), then Zed, Ghostty,
Raycast, Ray, Tinkerwell and the Claude app from their websites.

## 6. SSH

`id_rsa` from the old Mac (or a new ed25519 key uploaded with `gh ssh-key add`).
Copy `templates/ssh-config` to `~/.ssh/config` and the private host list to
`~/.ssh/config.d/hosts`.

## 7. These dotfiles

```bash
mkdir -p ~/Code && cd ~/Code
git clone https://github.com/groenewege/dotfiles-mac.git
git clone https://github.com/groenewege/dotfiles-ai.git
dotfiles-mac/install.sh
dotfiles-ai/plugins.sh
```

Then copy `templates/claude-settings.json` to `~/.claude/settings.json` and add
the secrets back by hand (`SHIFT_API_TOKEN` under `env`, from 1Password).
