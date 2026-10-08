# List top-level git repos under a root (default ~/Documents).
# Skips nested repos, worktrees/submodules, and folders ending in " copy".
git-repos() {
  local root="${1:-$HOME/Documents}"
  find "$root" \( -name node_modules -o -name .next -o -name dist -o -name build -o -name target \
       -o -name .venv -o -name venv -o -name .godot -o -name .cache -o -name .turbo \) -prune -o \
    -type d -name .git -prune -print 2>/dev/null \
    | sed 's|/\.git$||' \
    | grep -v ' copy$' \
    | LC_ALL=C sort \
    | awk '{ for (i = 0; i < n; i++) if (index($0, kept[i] "/") == 1) next
             kept[n++] = $0; print }'
}
