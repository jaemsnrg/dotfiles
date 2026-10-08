# --- List running processes on TCP ports ---
alias lsports="lsof -iTCP -sTCP:LISTEN -P -n"

killport() {
  if [ -z "$1" ]; then
    echo "Usage: killport <port_number> [additional_ports...]"
  else
    lsof -ti:"$@" | xargs kill -9 2>/dev/null && echo "Port(s) $@ cleared." || echo "No process found on port(s) $@."
  fi
}

alias kp="killport"

# --- Tmux session creation ---
function tn() {
  if [ -z "$1" ]; then
    echo "Usage: tn <session-name>"
    return 1
  fi

  if [ -n "$TMUX" ]; then
    # Inside tmux: create session detached (-d) and switch client
    tmux new-session -d -s "$1" && tmux switch-client -t "$1"
  else
    # Outside tmux: launch and attach normally
    tmux new-session -s "$1"
  fi
}

# --- List npm scripts ---
_list_scripts() {
  for f in **/package.json(N); do
    echo "=== ${f%/*} ==="
    jq -r '.scripts | keys[]?' "$f" 2>/dev/null
    echo ""
  done
}
alias nsl="_list_scripts"
