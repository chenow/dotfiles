{
  lib,
  config,
  inputs,
  ...
}: {
  options.agent-skills = {
    enable = lib.mkEnableOption "Declarative agent skills management";
  };

  config = lib.mkIf config.agent-skills.enable {
    programs.agent-skills = {
      enable = true;
      sources.anthropic = {
        path = inputs.anthropic-skills;
        subdir = "skills";
      };
      skills.enableAll = true;
      targets.agents.enable = true;
    };

    programs.obsidian = {
      enable = true;
      vaults.knowledge.enable = true;
    };
    nixpkgs.config.allowUnfreePredicate = pkg: (lib.getName pkg) == "obsidian";
    home.sessionVariables.KNOWLEDGE = "${config.home.homeDirectory}/knowledge";
  };
}
