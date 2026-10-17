#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Laravel Project
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🛠
# @raycast.argument1 { "type": "text", "placeholder": "Project" }

export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

exec /bin/zsh "$HOME/.local/bin/workon" "$1"
