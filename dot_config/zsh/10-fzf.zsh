# --- FZF Configuration ---
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"

if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Load keybindings & completion
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# Map Cmd+E (sending \x1be from Ghostty) to fuzzy-find files
bindkey '\ee' fzf-file-widget

# Map Cmd+R (sending \x1br from Ghostty) to fuzzy-search command history
bindkey '\er' fzf-history-widget

# FZF Aliases
alias fe='micro $(fzf)'
