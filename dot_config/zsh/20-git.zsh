# --- Git helpers (most use fzf, see 10-fzf.zsh) ---

alias gcb='git branch -a | fzf | xargs git checkout'

# Reset soft: defaults to 1 commit back (HEAD~1) if no argument is passed
grs() {
  local count="${1:-1}"
  git reset --soft "HEAD~${count}"
}

# Reset hard: defaults to HEAD if no target is passed (or accepts origin/main, commit hashes, etc.)
grh() {
  git reset --hard "${1:-HEAD}"
}

# Interactive Git Checkout
gcoi() {
  local branch
  branch=$(git branch --all --sort=-committerdate | grep -v HEAD | fzf --height 50% --ansi --preview 'git log -n 20 --color=always --oneline $(echo {} | tr -d "* " | cut -d" " -f1)') &&
  git checkout $(echo "$branch" | tr -d "* " | cut -d" " -f1 | sed "s/remotes\/origin\///")
}

# Interactive Git Merge
gmi() {
  local branch
  branch=$(git branch --all --sort=-committerdate | grep -v HEAD | fzf --height 50% --ansi --preview 'git log -n 20 --color=always --oneline $(echo {} | tr -d "* " | cut -d" " -f1)') &&
  git merge $(echo "$branch" | tr -d "* " | cut -d" " -f1 | sed "s/remotes\/origin\///")
}

# Interactive Git Branch Delete
gbdi() {
  local branches
  branches=$(git branch | grep -v '^\*' | fzf --multi --height 50% --preview 'git log -n 20 --color=always --oneline {1}') &&
  echo "$branches" | xargs git branch -D
}

# Interactive Git Local + Remote Branch Delete
gbddi() {
  local branches
  branches=$(git branch --format='%(refname:short)' |
    grep -v "^$(git branch --show-current)$" |
    fzf --multi --height 50% --reverse \
        --preview 'git log -n 20 --color=always --oneline {}')

  if [ -n "$branches" ]; then
    echo "$branches" | xargs git branch -D
    # Optional: Delete remote branches on origin
    # echo "$branches" | xargs git push origin --delete
  fi
}

# Interactive Git Worktree Add (create & checkout new worktree)
gwai() {
  local branch_name dir_path
  read -r "branch_name?Enter new branch name: "
  [ -z "$branch_name" ] && return 1

  dir_path="../$branch_name"
  git worktree add -b "$branch_name" "$dir_path" && cd "$dir_path"
}

# Interactive Git Worktree Switch (cd into existing worktree)
gwsi() {
  local selected target_path
  selected=$(git worktree list | fzf --height 50% --reverse --preview 'git log -n 15 --color=always --oneline {1}')

  if [ -n "$selected" ]; then
    target_path=$(echo "$selected" | awk '{print $1}')
    cd "$target_path" || return
  fi
}

# Interactive Git Worktree Delete (optionally delete its branch too)
gwdi() {
  local selected target_path branch current_branch
  current_branch=$(git branch --show-current)

  # Transform the path column to only display the folder name (basename)
  selected=$(git worktree list | grep -v "\[${current_branch}\]" | awk '{
    full_path = $1;
    n = split(full_path, a, "/");
    $1 = a[n];
    print $0 "\t" full_path
  }' | fzf --height 50% --reverse \
    --delimiter='\t' \
    --with-nth=1 \
    --preview 'path=$(echo {2} | awk "{print \$1}"); git log -n 15 --color=always --oneline "$path"')

  if [ -n "$selected" ]; then
    # Extract the full original path attached after the tab delimiter
    target_path=$(echo "$selected" | awk -F'\t' '{print $2}' | awk '{print $1}')
    branch=$(echo "$selected" | awk -F'\t' '{print $2}' | awk '{print $3}' | tr -d '[]')

    git worktree remove "$target_path"

    if [ -n "$branch" ]; then
      read -r "reply?Delete associated branch '$branch' as well? (y/N): "
      case "$reply" in
        [Yy]*) git branch -D "$branch" ;;
      esac
    fi
  fi
}

# Interactive Git Stash Apply (apply chosen stash, keep in list)
gsai() {
  local stash
  stash=$(git stash list | fzf --height 50% --reverse \
    --preview 'git stash show -p --color=always {1}')

  if [ -n "$stash" ]; then
    local stash_id
    stash_id=$(echo "$stash" | awk -F: '{print $1}')
    git stash apply "$stash_id"
  fi
}

# Interactive Git Stash Pop (apply and remove chosen stash)
gspi() {
  local stash
  stash=$(git stash list | fzf --height 50% --reverse \
    --preview 'git stash show -p --color=always {1}')

  if [ -n "$stash" ]; then
    local stash_id
    stash_id=$(echo "$stash" | awk -F: '{print $1}')
    git stash pop "$stash_id"
  fi
}

# Interactive Git Stash Drop (delete single or multiple stashes)
gsdi() {
  local stashes
  stashes=$(git stash list | fzf --multi --height 50% --reverse \
    --preview 'git stash show -p --color=always {1}')

  if [ -n "$stashes" ]; then
    echo "$stashes" | awk -F: '{print $1}' | while read -r stash_id; do
      git stash drop "$stash_id"
    done
  fi
}

# Interactive Git Stash Save (prompt for custom message)
gssi() {
  local stash_msg
  read -r "stash_msg?Enter stash message (leave blank for default): "
  if [ -n "$stash_msg" ]; then
    git stash save "$stash_msg"
  else
    git stash
  fi
}
