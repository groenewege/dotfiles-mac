#!/usr/bin/env bash
# Shared helpers for install.sh. Source this file, don't run it.
# Adapted from dotfiles-omarchy's lib/common.sh; runs under macOS bash 3.2.

DOTFILES="${DOTFILES:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)}"
# The dotfiles-ai repo (agent instructions, skills, commands), next to this one.
AI_DIR="${AI_DIR:-$(dirname "$DOTFILES")/dotfiles-ai}"
export DOTFILES BACKUP_DIR AI_DIR

log()  { printf '\n\033[1;34m==>\033[0m \033[1m%s\033[0m\n' "$*"; }
ok()   { printf '  \033[32m✓\033[0m %s\n' "$*"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$*" >&2; }
die()  { printf '  \033[31m✗\033[0m %s\n' "$*" >&2; exit 1; }

have() { command -v "$1" >/dev/null 2>&1; }

# Show a path with ~ instead of $HOME.
pretty() { local tilde='~'; printf '%s' "${1/#$HOME/$tilde}"; }

# Append a line to a file unless it is already present.
ensure_line() {
  local file=$1 line=$2
  mkdir -p "$(dirname "$file")"
  touch "$file"
  if grep -qxF -- "$line" "$file"; then
    ok "$(pretty "$file") already contains: $line"
  else
    printf '%s\n' "$line" >>"$file"
    ok "added to $(pretty "$file"): $line"
  fi
}

# A free path in the backup dir for <rel>; a name that is already taken gets a
# .1, .2... suffix, so a backup never overwrites an earlier one.
backup_dest() {
  local dest="$BACKUP_DIR/$1" n=1
  while [[ -e $dest || -L $dest ]]; do dest="$BACKUP_DIR/$1.$((n++))"; done
  mkdir -p "$(dirname "$dest")"
  printf '%s' "$dest"
}

# Move a file out of the way into the backup dir (keeps its path under $HOME).
backup() {
  local target=$1 dest
  dest=$(backup_dest "${1#"$HOME"/}")
  mv -n "$target" "$dest"
  [[ -e $target || -L $target ]] && die "could not back up $(pretty "$target")"
  warn "backed up $(pretty "$target") to $(pretty "$dest")"
}

# Symlink every file of stow/<pkg> into $HOME. Existing files that are not
# already our symlinks are backed up first, so stow never hits a conflict.
stow_package() {
  local pkg=$1 dir="$DOTFILES/stow/$1" src rel target
  while IFS= read -r -d '' src; do
    rel=${src#"$dir"/}
    target="$HOME/$rel"
    if [[ -e $target || -L $target ]] && [[ $(readlink -f "$target") != "$(readlink -f "$src")" ]]; then
      backup "$target"
    fi
  done < <(find "$dir" \( -type f -o -type l \) ! -name .DS_Store -print0)
  stow --dir "$DOTFILES/stow" --target "$HOME" --no-folding --restow --ignore='\.DS_Store' "$pkg"
  ok "stowed $pkg"
}

# List the files of stow/ that are no longer linked from $HOME: some apps save
# a file by writing a new one over our symlink. Compare, copy what's worth
# keeping into the repo, then run ./install.sh link.
check_links() {
  local src rel broken=0
  while IFS= read -r -d '' src; do
    rel=${src#"$DOTFILES"/stow/*/}
    if [[ $(readlink -f "$HOME/$rel") != "$(readlink -f "$src")" ]]; then
      warn "~/$rel is no longer linked to the repo"
      broken=1
    fi
  done < <(find "$DOTFILES/stow" -mindepth 2 \( -type f -o -type l \) ! -name .DS_Store -print0)
  ((broken)) || ok "every stowed file is linked"
}
