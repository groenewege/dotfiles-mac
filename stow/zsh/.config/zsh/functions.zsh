# Functions. Formerly ~/.oh-my-zsh/custom/alias.zsh, plus a few from
# dotfiles-omarchy's functions.sh.

# Run the test suite with Pest when present, PHPUnit otherwise.
p() {
  if [[ -f vendor/bin/pest ]]; then
    valet php vendor/bin/pest --compact "$@"
  else
    valet php vendor/bin/phpunit "$@"
  fi
}

# Same, filtered: pf "user can log in"
pf() {
  if [[ -f vendor/bin/pest ]]; then
    valet php vendor/bin/pest --compact --filter "$@"
  else
    valet php vendor/bin/phpunit --filter "$@"
  fi
}

# List routes, optionally filtered: routes admin
routes() {
  if [[ $# -eq 0 ]]; then
    php artisan route:list
  else
    php artisan route:list | grep -i -- "$1"
  fi
}

# Symfony 1: generate and run migrations, rebuild the classes.
sfmigrate() {
  valet php symfony doctrine:generate-migrations-diff
  valet php symfony doctrine:migrate
  valet php symfony doctrine:build --all-classes
}

# Commit everything. Without a message, Claude writes one from the diff
# (falls back to "wip").
commit() {
  local message="$*" diff_input spinner_pid

  git add -A

  if [[ -z $message ]] && command -v claude &>/dev/null && ! git diff --cached --quiet; then
    diff_input=$(
      echo "=== Summary ==="
      git diff --cached --stat
      printf '\n=== Diff (truncated if large) ===\n'
      git diff --cached | head -c 50000
    )

    # Spinner in a detached subshell, so the shell prints no job messages.
    spinner_pid=$(
      (
        frames="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
        while :; do
          for ((i = 0; i < ${#frames}; i++)); do
            printf '\r%s Generating commit message...' "${frames[i + 1]}"
            sleep 0.1
          done
        done
      ) >/dev/tty 2>&1 &
      echo $!
    )
    trap 'kill "$spinner_pid" 2>/dev/null; printf "\r\033[K"; trap - INT' INT

    message=$(claude -p --no-session-persistence \
      "Write a single-line commit message for this diff. Output ONLY the message, no quotes, no explanation, no markdown." \
      <<<"$diff_input")

    kill "$spinner_pid" 2>/dev/null
    printf '\r\033[K'
    trap - INT
  fi

  git commit -m "${message:-wip}"
}

# Delete local branches whose remote branch is gone.
git-prune-local() {
  git fetch -p && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}

# Clone a GitHub repo: clone owner/repo [dir]
clone() {
  gh repo clone "$1" "${@:2}"
}

# Databases on the local MySQL (DBngin listens on TCP, not /tmp/mysql.sock).
db() {
  case "$1" in
    refresh) mysql -uroot -h127.0.0.1 -e "drop database if exists \`$2\`; create database \`$2\`" ;;
    create)  mysql -uroot -h127.0.0.1 -e "create database \`$2\`" ;;
    drop)    mysql -uroot -h127.0.0.1 -e "drop database \`$2\`" ;;
    list)    mysql -uroot -h127.0.0.1 -N -e "show databases" ;;
    *)
      echo "Usage: db {refresh|create|drop|list} [database_name]"
      return 1
      ;;
  esac
}

# Open the project's database (from .env) in the default database app.
opendb() {
  [[ -f .env ]] || { echo "No .env file found."; return 1; }
  local key
  for key in DB_CONNECTION DB_HOST DB_PORT DB_DATABASE DB_USERNAME DB_PASSWORD; do
    local "$key=$(grep "^$key=" .env | cut -d '=' -f 2-)"
  done
  local url="${DB_CONNECTION}://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"
  echo "Opening ${url}"
  open "$url"
}

# Terminal.app: switch the window's theme while on a server, so a remote shell
# is easy to tell apart. Does nothing in other terminals (Ghostty, Zed, herdr).
tabc() {
  [[ $TERM_PROGRAM == Apple_Terminal ]] || return 0
  osascript -e "tell application \"Terminal\" to set current settings of front window to settings set \"${1:-Default}\""
}

ssh() {
  tabc "Tomorrow Night"
  command ssh "$@"
  tabc "Basic"
}
