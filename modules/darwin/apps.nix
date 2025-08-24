{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    amazon-q-cli
    ssm-session-manager-plugin
    raycast
    slack
    rectangle
    telegram-desktop
    zoom-us
    obsidian
  ];
}
