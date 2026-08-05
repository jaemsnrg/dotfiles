
## 🧩 tmux

All bindings below use the `P` = `Ctrl+A` prefix unless marked `-n` (no prefix needed).

### Sessions & Windows

| Shortcut | Action |
| --- | --- |
| `P c` | New window in current directory |
| `P &` | Kill current window (default) |
| `P x` | Kill current pane (default) |
| `P d` | Detach from session (default) |

### Navigation

| Shortcut | Action |
| --- | --- |
| `M-Left` | Select pane on the left (no prefix) |
| `M-Right` | Select pane on the right (no prefix) |
| `M-Up` | Select pane above (no prefix) |
| `M-Down` | Select pane below (no prefix) |
| `M-1`…`M-9` | Switch to window 1–9 |
| `P 1`…`P 9` | Switch to window 1–9 (default) |

### Reload

| Shortcut | Action |
| --- | --- |
| `P r` | Reload `tmux.conf` and show "Config reloaded!" |

---

## 🔌 tmux Plugins

### TPM (`tmux-plugins/tpm`)

| Shortcut | Action |
| --- | --- |
| `P I` | **I**nstall plugins |
| `P U` | **U**ninstall (remove) plugins not in config |
| `P Alt+U` | **U**pdate plugins |

### tmux-resurrect

| Shortcut | Action |
| --- | --- |
| `P Ctrl+S` | **S**ave session manually |
| `P Ctrl+R` | **R**estore last saved session |

### tmux-continuum

| Setting | Value |
| --- | --- |
| Auto-restore on server start | `on` |
| Auto-save interval | every **15 minutes** |

> No hotkey — runs automatically in the background.

### tmux-thumbs

| Shortcut | Action |
| --- | --- |
| `P Space` | Open thumbs picker; selected hint is copied to clipboard via `pbcopy` |

> Use the alphabetic hints shown on screen, then `Enter` to copy.

---

## 🐚 Zsh / FZF

FZF keybindings are loaded via `fzf --zsh` in `.zshrc`. FZF runs as a reverse-layout picker with a border.

| Shortcut | Action |
| --- | --- |
| `Ctrl+T` | Fuzzy-find a file and paste the path onto the command line |
| `Ctrl+R` | Fuzzy-search command history and paste the selection |
| `Alt+C` | Fuzzy-find a directory and `cd` into it |
| `↑ / ↓` | Move selection (in picker) |
| `Tab` / `Shift+Tab` | Mark / unmark multiple items |
| `Enter` | Accept selection |
| `Esc` / `Ctrl+C` / `Ctrl+G` | Cancel |

### fzf-backed aliases

| Alias | Action |
| --- | --- |
| `fe` | Open selected file in `micro` |
| `gcb` | Fuzzy-pick a branch and `git checkout` it |

### Shell reload

| Alias | Action |
| --- | --- |
| `reload` | Re-source `~/.zshrc` and reload active tmux config (shows confirmation) |

---

## ✏️ micro (default editor)

Custom config only sets the Catppuccin Macchiato colorscheme — the bindings below are micro's defaults.

| Shortcut | Action |
| --- | --- |
| `Ctrl+Z` / `Ctrl+Y` | Undo / Redo |
| `Ctrl+A` | Select all |
| `Ctrl+C` / `Ctrl+X` / `Ctrl+V` | Copy / Cut / Paste |
| `Ctrl+F` | Find |
| `Ctrl+H` | Find & replace |
| `Ctrl+G` | Go to line |
| `Ctrl+N` | New empty buffer |
| `Alt+,` / `Alt+.` | Previous / next buffer |
| `Ctrl+W` | Toggle to terminal pane |

---

## 🧰 Shell Aliases (commands, not hotkeys)

Handy commands set up in `.aliases`.

# 🛠️ Command Line Aliases Cheatsheet

## 🏡 chezmoi (Dotfile Management)

| Alias | Command / Action | Description |
| :--- | :--- | :--- |
| `cz` | `chezmoi` | Base chezmoi command |
| `czl` | `chezmoi list` | List managed files |
| `cza` | `chezmoi apply` | Apply changes to home directory |
| `cze <file>` | `chezmoi edit <file>` | Edit managed source file |
| `czd` | `chezmoi diff` | Show diff between home and source |
| `czs` | `chezmoi status` | Show status of changes |
| `czu` | `chezmoi update` | Pull changes and apply |
| `czcd` | `cd $(chezmoi source-path)` | Navigate into chezmoi source directory |
| `czcat` | `cat ~/.aliases` | Print live `~/.aliases` file |

---

## 🌿 Git Basics & Branching

| Alias | Command / Action | Description |
| :--- | :--- | :--- |
| `g` | `git` | Base git command |
| `gs` | `git status` | Show working tree status |
| `ga` | `git add` | Stage specific changes |
| `gaa` | `git add --all` | Stage all changes |
| `gc` | `git commit` | Commit staged changes |
| `gca` | `git commit --amend` | Amend last commit |
| `gb` | `git branch` | List local branches |
| `gcb` | `git checkout -b` | Create and switch to new branch |
| `gco` | `git checkout` | Switch branch or restore file |
| `gbc` | `git branch --merged` | Show merged branches |
| `gbd` | `git branch -d` | Delete branch |

---

## 🔄 Git Syncing & History

| Alias | Command / Action | Description |
| :--- | :--- | :--- |
| `gp` | `git push` | Push commits to remote |
| `gpf` | `git push --force-with-lease` | Safe force push |
| `gl` | `git pull` | Pull changes from remote |
| `gf` | `git fetch --prune` | Fetch and prune deleted remote branches |
| `gd` | `git diff` | Show uncommitted changes |
| `gds` | `git diff --staged` | Show staged changes |
| `glg` | `git log --graph --oneline` | Display pretty commit log graph |

---

## 🖥️ tmux (Terminal Multiplexer)

| Alias | Command / Action | Description |
| :--- | :--- | :--- |
| `t` | `tmux` | Launch tmux |
| `ta` | `tmux attach` | Attach to last active session |
| `tat <name>` | `tmux attach -t <name>` | Attach to a specific session |
| `tn <name>` | `tmux new -s <name>` | Create a new named session |
| `tls` | `tmux ls` | List active sessions |
| `tk <name>` | `tmux kill-session -t <name>` | Kill a specific session |
| `tka` | `tmux kill-session -a` | Kill all other sessions except current |
| `tkall` | `tmux kill-server` | Kill tmux server (all sessions) |
| `tapp` | `tmux source-file ~/.tmux.conf` | Reload tmux config in running server |

---
