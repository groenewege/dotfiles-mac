#!/usr/bin/env bash
# Link this Mac's configuration. Safe to run again at any time.
#
#   ./install.sh          every step
#   ./install.sh link     one step: ai, link or check
#
# This script never installs or upgrades anything (no brew, PHP, Valet or
# MySQL): the Mac is a working dev machine. Setting up a new Mac from scratch
# is a guide, docs/new-mac.md, not a script.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
export DOTFILES
# shellcheck source=lib/common.sh
source "$DOTFILES/lib/common.sh"

# Agent instructions, skills and commands, shared with Omarchy.
step_ai() {
  log "dotfiles-ai"
  if [[ -d $AI_DIR/.git ]]; then
    ok "dotfiles-ai found at $(pretty "$AI_DIR")"
  else
    git clone https://github.com/groenewege/dotfiles-ai.git "$AI_DIR"
  fi
  "$AI_DIR/install.sh"
}

# Config files: stow/ for files we own, one hook line for files we share.
step_link() {
  log "Linking config files"
  have stow || die "stow not found: HOMEBREW_NO_AUTO_UPDATE=1 brew install stow (it has no dependencies)"

  # The old aliases lived in Oh My Zsh's custom folder; they are now
  # ~/.config/zsh/aliases.zsh and functions.zsh.
  if [[ -f $HOME/.oh-my-zsh/custom/alias.zsh ]]; then
    backup "$HOME/.oh-my-zsh/custom/alias.zsh"
  fi

  for pkg in "$DOTFILES"/stow/*/; do
    stow_package "$(basename "$pkg")"
  done

  # ~/.zshrc stays the Oh My Zsh file; it only sources ours at the end.
  ensure_line "$HOME/.zshrc" 'source ~/.config/zsh/init.zsh'

  # ~/.gitconfig keeps the machine's own settings (gh credential helper);
  # an include at the end adds ours.
  if git config --global --get-all include.path | grep -qxF '~/.config/git/dotfiles.gitconfig'; then
    ok "~/.gitconfig already includes dotfiles.gitconfig"
  else
    git config --global --add include.path '~/.config/git/dotfiles.gitconfig'
    ok "~/.gitconfig now includes ~/.config/git/dotfiles.gitconfig"
  fi
}

step_check() {
  log "Checking links"
  check_links
}

steps=(ai link check)
if (($#)); then
  steps=("$@")
fi
for step in "${steps[@]}"; do
  case $step in
    ai | link | check) "step_$step" ;;
    *) die "unknown step: $step (ai, link, check)" ;;
  esac
done
