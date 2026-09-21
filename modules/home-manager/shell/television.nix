{
  lib,
  config,
  ...
}: let
  cfg = config.my.shell.television;
in {
  options.my.shell.television.enable = lib.mkEnableOption "television fuzzy finder with git channels";

  config = lib.mkIf cfg.enable {
    programs.television = {
      enable = true;
      channels = {
        git-diff = {
          metadata = {
            description = "A channel to select files from git diff commands";
            name = "git-diff";
            requirements = [
              "git"
            ];
          };
          preview = {
            command = "git diff HEAD --color=always -- '{}'";
          };
          source = {
            command = "git diff --name-only HEAD";
          };
        };
        git-log = {
          metadata = {
            description = "A channel to select from git log entries";
            name = "git-log";
            requirements = [
              "git"
            ];
          };
          preview = {
            command = "git show -p --stat --pretty=fuller --color=always '{0}'";
          };
          source = {
            command = "git log --oneline --date=short --pretty=\"format:%h %s %an %cd\" \"$@\"";
            output = "{split: :0}";
          };
        };
      };
    };
  };
}
