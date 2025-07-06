{
  lib,
  config,
  ...
}: {
  options.vscode = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install Visual Studio Code.";
    };
  };

  config.programs.vscode = lib.mkIf config.vscode.enable {
    enable = true;
  };
}
