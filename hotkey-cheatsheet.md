# Hotkey Cheatsheet

Quick reference for all keyboard shortcuts configured in these dotfiles.
**Prefix key for tmux is `Ctrl+A`** (rebound from default `Ctrl+B`).

Legend: `C-` = Ctrl, `M-` = Alt/Option, `S-` = Shift, `Cmd` = ⌘, `P` = tmux prefix.

---

## 🖥️ Ghostty

| Shortcut | Action |
| --- | --- |
| `Cmd+D` | Send literal `Ctrl+A` byte to terminal (used as tmux prefix passthrough) |

> Note: Ghostty's default right-pane split is unbound so `Cmd+D` can be passed to tmux.

---

## 🧩 tmux

All bindings below use the `P` = `Ctrl+A` prefix unless marked `-n` (no prefix needed).

### Sessions & Windows

| Shortcut | Action |
| --- | --- |
| `P -` | Split pane **vertically** (left/right), in current directory |
| `P \` | Split pane **horizontally** (top/bottom), in current directory |
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
| `Ctrl+S` | Save file |
| `Ctrl+Q` | Quit |
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

| Alias | Action |
| --- | --- |
| `t`, `ta`, `tat <name>`, `tls`, `tn <name>`, `tk <name>`, `tka`, `tkall` | tmux: launch, attach, attach-to, list, new, kill, kill-others, kill-server |
| `tapp` | Reload tmux config in the running server |
| `cz`, `czl`, `cza`, `cze`, `czd`, `czs`, `czu` | chezmoi: run, list, apply, edit, diff, status, update |
| `czcd` | `cd` into the chezmoi source repo |
| `czcat` | Print the live `~/.aliases` file |
| `g`, `gs`, `ga`, `gaa`, `gc`, `gca`, `gco`, `gcb`, `gb`, `gbc`, `gbd` | git basics |
| `gp`, `gpf`, `gl`, `gf` | git push / safer force push / pull / fetch all pruned |
| `gd`, `gds`, `glg` | git diff / staged diff / pretty graph log |
| `c`, `lsa` | clear / ls -a |

---

## 🪟 macOS system defaults

Set by `run_onchange_after_configure-macos.sh.tmpl`.

| Setting | Value |
| --- | --- |
| `NSWindowShouldDragOnGesture` | `true` — drag any window with `Ctrl+Cmd+Click` |
| `KeyRepeat` | `2` — fast key repeat rate |
