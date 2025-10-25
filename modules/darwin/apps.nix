{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ssm-session-manager-plugin
    raycast
    slack
    rectangle
    zoom-us
    obsidian
  ];
}
