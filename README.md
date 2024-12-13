# My machine configuration

This repository holds my computer configuration, fully declared thanks to nix-darwin and home-manager. Requires a MacOS system.

## Usage

- Install dependencies:

```bash
xcode-select --install

```

- Install [nixos](https://nixos.org/download/)

- clone the repository and let nixos do its things:

```bash
mkdir -p ~/Documents/git
cd ~/Documents/git
git clone git@github.com:chenow/dotfiles.git
cd dotfiles
nix run --experimental-features "nix-command flakes" .#build-switch
```

For more information, go to https://github.com/dustinlyons/nixos-config/
