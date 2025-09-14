{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ssm-session-manager-plugin
    raycast
    slack
    rectangle
    telegram-desktop
    zoom-us
    obsidian
  ];
}
