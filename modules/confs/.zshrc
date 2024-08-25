# Alias
alias shell="docker compose run --rm shell"
alias gck="git checkout"

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
