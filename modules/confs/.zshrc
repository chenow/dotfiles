# Alias
alias brew_up="brew update && brew upgrade && brew cleanup && brew autoremove && brew cleanup"
alias shell="docker compose run --rm shell"
alias gf="git fetch --all --prune"
alias gp="git pull --all --prune"
alias gck="git checkout"
function gdm() {
    echo "Switching to the dev branch..."
    git checkout dev || return
    echo "Pulling latest branches info..."
    git pull --all --prune
    echo
    echo
    echo "The following local branches are merged into dev and can be deleted:"
    echo
    git branch --merged | egrep -v "(^\*|main|master|dev|production)"

    # Ask for confirmation
    echo
    echo -n "Do you want to delete these branches? (y/n) "
    read delete_branches
    echo    # Move to a new line
    if [[ $delete_branches =~ ^[Yy]$ ]]
    then
        git branch --merged | egrep -v "(^\*|main|master|dev|production)" | xargs -r git branch -d
        echo "Merged branches deleted."
    else
        echo "Operation cancelled."
    fi
}

# FZF
source <(fzf --zsh)

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# ZSH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="oh-my-viarezo/viarezo"
plugins=(git kubectl zsh-autosuggestions direnv)
source $ZSH/oh-my-zsh.sh
