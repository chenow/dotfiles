{ pkgs, config, ... }:

{
  ".config/direnv/direnv.toml".source = ./config/direnv.toml;
}
