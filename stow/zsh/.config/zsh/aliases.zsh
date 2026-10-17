# Aliases. Formerly ~/.oh-my-zsh/custom/alias.zsh, plus a few from
# dotfiles-omarchy's aliases.sh. Oh My Zsh's git plugin aliases load first;
# these win where the names overlap.

alias ll="ls -hal"

# Laravel / PHP. Through `valet php`, so each site runs on the PHP version
# Valet isolated for it (`valet isolated`).
alias laravel='~/.composer/vendor/bin/laravel'
alias art="valet php artisan"
alias pam="valet php artisan migrate"
alias pam:r="valet php artisan migrate:refresh"
alias pam:roll="valet php artisan migrate:rollback"
alias pam:rs="valet php artisan migrate:refresh --seed"
alias pam:f="valet php artisan migrate:fresh"
alias pam:fs="valet php artisan migrate:fresh --seed"
alias t="valet php vendor/bin/phpunit"
alias tf="valet php vendor/bin/phpunit --filter"
alias phpserve="php -S localhost:8888"
alias cu="composer update"
alias cr="composer require"
alias ci="composer install"
alias cda="composer dump-autoload -o"

# Symfony 1 (the legacy DES apps)
alias sfcc="valet php symfony cc"
alias sfreload="valet php symfony doctrine:build --db --and-migrate --and-load"

# JavaScript
alias nr="npm run"
alias nrd="npm run dev"
alias nrb="npm run build"

# AI agents
alias c="claude"
alias ccc="claude --continue"
alias cxy="codex --dangerously-bypass-approvals-and-sandbox"

# Git
alias gll="git log --oneline --decorate --graph"
alias gpo="git push origin"
alias push="git push"
alias pull="git pull"
alias uncommit="git reset --soft HEAD~1"
alias nah="git reset --hard; git clean -df"

# SSH
alias sshkey="pbcopy < ~/.ssh/id_rsa.pub && echo 'Public key copied to clipboard.'"

# Dotfiles
alias dotfiles='cd "$DOTFILES"'
