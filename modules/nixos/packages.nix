{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    google-chrome
    teams-for-linux
    thunderbird
    obsidian
  ];
}
