# --- Cross-Platform Open Command ---
if ! command -v open &> /dev/null; then
  if command -v xdg-open &> /dev/null; then
    alias open='xdg-open'
  elif command -v wslview &> /dev/null; then
    alias open='wslview'
  fi
fi

# --- Fast eza aliases ---
alias ls="eza"
alias l="eza -la --icons"
alias tree="eza --tree"
