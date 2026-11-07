# Cheat sheet

Shell commands and keyboard shortcuts for daily use on the Mac. Rows marked ★
are added by this repo (or by my own config); the rest are the app's defaults.

Forgot one? Zed's command palette (**Cmd+Shift+P**) and T3 Code's (**Cmd+K**)
show each command's key, and Ghostty lists its bindings with
`ghostty +list-keybinds`.

- [Our own shortcuts](#our-own-shortcuts)
- [Starting a project](#starting-a-project)
- [Ghostty](#ghostty)
- [T3 Code](#t3-code)
- [Zed](#zed)
- [Claude Code](#claude-code)
- [herdr](#herdr)
- [Shell](#shell)

## Our own shortcuts

Everything this repo adds or changes, in one place.

| Keys | Does | Defined in |
|---|---|---|
| Cmd+Shift+C (Zed) | Copy the file's relative path (replaces the collab panel, now Ctrl+Shift+C) | `stow/zed/.config/zed/keymap.json` |
| Ctrl+Shift+R (Zed, editor) | Run the nearest task (e.g. the test under the cursor) | same |
| Ctrl+Shift+F (Zed, editor) | Run the tests in the current file (`php artisan test`) | same, task in `tasks.json` |
| Cmd+Alt+← / → (Ghostty) | Previous / next tab | `~/Library/Application Support/com.mitchellh.ghostty/config` (not in this repo) |
| Ctrl+G (zsh) | Fuzzy cd into a subfolder | `~/.zshrc` (copy in `templates/zshrc`) |
| Ctrl+B ↑ / ↓ (herdr) | herdr-plus: projects / quick actions | `stow/herdr/.config/herdr/config.toml` |
| `/client-email` (Claude) | French email to a client summarising recent commits | dotfiles-ai |

## Starting a project

`workon` ★ opens a Laravel project in every app at once: Zed, Tower, the site
in Chrome (`APP_URL`), the database in TablePlus, and the project in T3 Code
(it starts T3 Code if needed). It reads `.env` for the URL and database.

| | |
|---|---|
| `workon` | The project in the current folder |
| `workon my-project` | `~/Sites/my-project` |
| `workon ~/Code/thing` | Any path |
| Raycast: **Open Laravel Project** | Same, from Raycast (`open-laravel-project.sh`) |
| `t3 app [path]` | Only open the folder in T3 Code (default: current folder) |
| `zed .` / `opendb` | Only Zed / only the database (from `.env`) |

## Ghostty

| Keys | Does |
|---|---|
| Cmd+T / Cmd+W | New tab / close tab or split |
| Cmd+1…9 | Go to tab |
| Cmd+Shift+[ / ], Ctrl+Shift+Tab / Ctrl+Tab, or Cmd+Alt+← / → ★ | Previous / next tab |
| Cmd+D / Cmd+Shift+D | Split right / split down |
| Cmd+[ / Cmd+] | Previous / next split |
| Cmd+Shift+Enter | Zoom the split |
| Cmd+K | Clear the screen |
| Cmd+= / Cmd+− / Cmd+0 | Bigger / smaller / reset text |
| Cmd+, / Cmd+Shift+, | Open / reload the config |

Our Cmd+Alt+arrows replace Ghostty's "focus the split in that direction" for
left and right; use Cmd+[ / ] to move between splits.

## T3 Code

T3 Code runs Claude Code and Codex threads per project. Keys are the defaults
from `~/.t3/userdata/keybindings.json`; most don't apply while the terminal
panel has focus.

### Threads

| Keys | Does |
|---|---|
| Cmd+N (or Cmd+Shift+O) | New thread |
| Cmd+Shift+N | New thread in the local checkout (no worktree) |
| Cmd+Alt+N | New thread without a project |
| Cmd+1…9 | Go to thread |
| Cmd+Shift+[ / ] | Previous / next thread |
| Cmd+Shift+P | Pin the thread |
| Cmd+Shift+C | Copy a reference to the thread |
| Cmd+F | Find in the thread |
| Cmd+Z | Undo (outside a text field) |

### Composer

| Keys | Does |
|---|---|
| Enter | Send; while the agent works, queue it as a follow-up |
| Cmd+Enter (agent working) | Send it the other way: steer the running turn now |
| Cmd+Shift+Enter | Steer with the queued message |
| Alt+↑ | Edit the queued message |
| Cmd+Alt+Enter | Send and start a new thread |
| Cmd+S | Stash the draft |
| Cmd+Shift+M | Model picker (Cmd+1…9 picks; Cmd+Shift+↑ / ↓ changes provider) |
| Cmd+Shift+E | Reasoning effort |
| Cmd+Shift+A | Mode |
| Cmd+Shift+X | Workspace: local checkout or worktree |
| Cmd+Shift+G | Branch |
| Cmd+Shift+L | Previous worktree |

### Panels

| Keys | Does |
|---|---|
| Cmd+K | Command palette |
| Cmd+P | Open a file |
| Cmd+Shift+F | Search the project |
| Cmd+B | Sidebar |
| Cmd+Alt+B / Cmd+Shift+B | Right panel / thread panel |
| Cmd+D | Diff |
| Cmd+J | Terminal (inside it: Cmd+D / Cmd+Shift+D split, Cmd+N new, Cmd+W close) |
| Cmd+Shift+J | Browser preview (inside it: Cmd+R reload, Cmd+L address bar) |
| Cmd+O | Open in the favourite editor |
| Cmd+Shift+K | Copy the pull request number |
| Cmd+U | Usage (C / T / L: cost, tokens, limits) |
| F6 / Shift+F6 | Focus the next / previous area |

## Zed

| Keys | Does |
|---|---|
| Cmd+P | Open a file |
| Cmd+Shift+P | Command palette |
| Cmd+Alt+O | Recent projects |
| Cmd+Shift+E | Project panel (Cmd+B: hide/show the left dock) |
| Cmd+Alt+B / Cmd+J | Hide/show the right / bottom dock |
| Ctrl+Shift+G | Git panel |
| Ctrl+` | Terminal panel |
| Cmd+? | Agent panel |
| Ctrl+Enter | Inline AI edit |
| Cmd+F / Cmd+Alt+F | Find / replace in the file |
| Cmd+Shift+F | Search the project |
| Cmd+Shift+O | Go to a symbol in the file |
| Cmd+T | Go to a symbol in the project |
| Ctrl+G | Go to line |
| F12 | Go to definition |
| F2 | Rename symbol |
| Cmd+. | Code actions |
| Cmd+D | Select the next match (Cmd+Shift+L: all matches) |
| Alt+↑ / ↓ | Move line up / down |
| Cmd+Shift+K | Delete line |
| Cmd+/ | Toggle comment |
| Cmd+Shift+T | Reopen closed tab |
| Cmd+Shift+C ★ | Copy relative path |
| Ctrl+Shift+R ★ | Run the nearest task |
| Ctrl+Shift+F ★ | Test the current file |

## Claude Code

| Keys | Does |
|---|---|
| Shift+Tab | Cycle permission modes (normal, auto-accept, plan) |
| Esc | Stop Claude |
| Shift+Enter | New line without sending |
| Esc Esc | Go back to an earlier message |
| `!` at the start | Run a shell command; its output lands in the conversation |
| `@` | Mention a file |
| Ctrl+G | Edit the prompt in `$EDITOR` |
| Ctrl+C twice | Quit |

## herdr

Not used much any more. The prefix is **Ctrl+B**: press it, release, then the
key. Prefix ? shows herdr's help.

| Keys | Does |
|---|---|
| prefix ↑ ★ | herdr-plus: projects |
| prefix ↓ ★ | herdr-plus: quick actions |
| prefix d | Detach (herdr keeps running) |
| prefix q | Quit the client |

## Shell

zsh with Oh My Zsh. Its git plugin gives `gst` (status), `gco` / `gcb`
(checkout / new branch), `gsw` (switch), `gaa` (add all), `gcmsg` (commit -m),
`gd` (diff), `gl` (pull), `gp` (push), `glo` (log). zoxide gives `z <folder>`;
fzf gives Ctrl+R (history), Ctrl+T (files) and Alt+C (cd; needs Option set to
act as Alt in the terminal).

Added by this repo (see `stow/zsh/.config/zsh/`). The PHP commands go through
`valet php`, so they use the PHP version Valet isolated for the site.

| | |
|---|---|
| Laravel | `art`, `pam` `pam:fs` `pam:f` `pam:r` `pam:rs` `pam:roll`, `routes [filter]`, `laravel` (installer) |
| Tests | `p` (pest or phpunit), `pf <filter>`, `t` / `tf` (phpunit) |
| Composer / npm | `ci` `cu` `cr` `cda`, `nr` `nrd` `nrb` |
| Git | `commit [msg]` (no message: Claude writes one), `gll`, `nah`, `uncommit`, `push`, `pull`, `gpo`, `git-prune-local`, `clone owner/repo` |
| Databases | `db create\|drop\|refresh\|list <name>` (local MySQL), `opendb` (the project's database in TablePlus) |
| AI | `c` (claude), `ccc` (claude --continue), `cxy` (codex without approvals) |
| Projects | `workon [project]`, `dotfiles` (cd here), Ctrl+G (fuzzy cd) |
| Symfony 1 | `sfcc`, `sfreload`, `sfmigrate` (the legacy DES apps) |
| Other | `ll`, `phpserve` (`php -S` on port 8888), `sshkey` (copy the public key) |
