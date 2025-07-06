{
  lib,
  config,
  ...
}: {
  options.ssh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ssh.";
    };
  };

  config.programs.ssh = lib.mkIf config.ssh.enable {
    enable = true;
  };
}
