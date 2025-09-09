{
  pkgs,
  lib,
  config,
  ...
}: {
  options.ia-chat = {
    enable = lib.mkEnableOption "Enable IA Chat service";
  };

  config = lib.mkIf config.ia-chat.enable {
    home.packages = with pkgs; [
      amazon-q-cli
      nodejs
    ];

    zsh.shellAliases = {
      q = "amazon-q";
      q-read = "amazon-q chat --agent read-only-agent";
      q-full = "amazon-q chat --agent full-agent";
    };

    home.file.".aws/amazonq/cli-agents" = {
      source = ./assets/q-cli-agents;
      recursive = true;
    };
  };
}
