{ pkgs, config, ... }:

{
  home.file.".config/direnv/direnv.toml".source = ./config/direnv.toml;
}
