# Environment variables. PATH stays in ~/.zshrc (DBngin, Composer, opencode…).

# Location of this dotfiles repo (found through the symlink of this file).
export DOTFILES="${$(readlink -f ~/.config/zsh/exports.zsh)%/stow/zsh/*}"
