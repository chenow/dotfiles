{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    amazon-q-cli
    raycast
    slack
    rectangle
    telegram-desktop
    zoom-us
    obsidian
  ];
}
