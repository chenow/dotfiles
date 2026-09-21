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

## Layout

| Directory | Scope | Exported by `lib` |
| ------------------------------ | -------- | ---------------------------------------------------- |
| `modules/darwin` | generic | yes (`my.macos.*`) |
| `modules/home-manager` | generic | yes (`my.shell/dev/editors/ai.*`) |
| `hosts/` | personal | no; only this flake imports it |
| work repo (`ACheneauDotfiles`) | work | consumes `lib`, adds `my.amazon.*` and its own hosts |

Rule of thumb: if the work flake can evaluate it, it is generic.

## Options

Nothing is applied by default and there are no profiles or bundles: **each host
file lists every feature it enables**, so reading `hosts/<host>/default.nix`
tells you exactly what that machine gets. `self.lib.darwin.mkDarwinSystem` and
`self.lib.homeManagerConfiguration` expose the same option paths.

| Group | Options | Level |
| -------------- | --------------------------------------------------- | ---------- |
| `my.macos.*` | `nix`, `defaults`, `homebrew`, `hammerspoon` | nix-darwin |
| `my.shell.*` | `zsh`, `direnv`, `tools`, `television`, `wezterm` | HM |
| `my.dev.*` | `git`, `github`, `ssh`, `docker`, `aws`, `dotfiles` | HM |
| `my.editors.*` | `vscodium`, `zed`, `vim` | HM |
| `my.ai.*` | `kiro`, `agents` | HM |

A consuming flake can add its own groups (the work repo adds `my.amazon.*`) and
have them aliased at the nix-darwin level with
`mkDarwinSystem { extraGroups = ["amazon"]; ... }`.

`my.macos.homebrew` pins the Homebrew installation itself with
[nix-homebrew](https://github.com/zhaofengli/nix-homebrew) (`autoMigrate`
takes over an existing install, keeping formulae and casks) and manages casks
through nix-darwin. Taps are deliberately not pinned so casks keep upgrading.

### What is enabled on a host?

```sh
nix eval --json .#darwinConfigurations.<host>.config.my.enabledFeatures
nix eval --json .#homeConfigurations.<host>.config.my.enabledFeatures
features   # shell alias on the machine, same list for the active generation
```

Example host (see `hosts/MacBook-Pro-de-Antoine/default.nix` for a full one):

```nix
{
  my.macos = {
    nix.enable = true;
    defaults.enable = true;
    homebrew = { enable = true; casks = ["raycast"]; };
  };
  my.dev = {
    docker.enable = true;
    git.profile = { name = "Me"; email = "me@example.com"; };
  };
}
```
