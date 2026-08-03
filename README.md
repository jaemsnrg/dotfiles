# 1. Install Chezmoi
/bin/bash -c "$(curl -fsLS get.chezmoi.io)"

# 2. Initialize and apply from remote repository
chezmoi init --apply https://github.com/your-username/dotfiles.git
