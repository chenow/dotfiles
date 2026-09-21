# my.dev.* : developer tooling (VCS, SSH, containers, cloud CLIs, this repo)
{...}: {
  imports = [
    ./git.nix
    ./github.nix
    ./ssh.nix
    ./docker.nix
    ./aws.nix
    ./dotfiles.nix
  ];
}
