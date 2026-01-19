{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.kiro;
  homeDir = config.home.homeDirectory;

  # MCP Server definitions
  mcpServers = {
    github = {
      command = "docker";
      args = ["run" "-i" "--rm" "--env-file" "${homeDir}/secrets/github-access-token.env" "ghcr.io/github/github-mcp-server"];
    };
    context7 = {
      command = "npx";
      args = ["-y" "@upstash/context7-mcp"];
      env.CONTEXT7_API_KEY = "\${CONTEXT7_API_KEY}";
    };
    stripe = {
      command = "npx";
      args = ["-y" "@stripe/mcp" "--tools=all"];
      env.STRIPE_SECRET_KEY = "\${STRIPE_SECRET_KEY}";
    };
    shadcn = {
      command = "npx";
      args = ["shadcn@latest" "mcp"];
    };
    nix-mcp = {
      command = "uvx";
      args = ["mcp-nixos"];
    };
    cdk = {
      command = "uvx";
      args = ["awslabs.cdk-mcp-server@latest"];
      env.FASTMCP_LOG_LEVEL = "ERROR";
    };
    aws-knowledge = {
      url = "https://knowledge-mcp.global.api.aws";
      type = "http";
    };
  };

  # Default tool configs per MCP server
  mcpToolDefaults = {
    github = {
      tools = ["@github/search_code" "@github/get_file_contents" "@github/search_repositories"];
      allowedTools = ["@github"];
    };
    context7 = {
      tools = ["@context7"];
      allowedTools = ["@context7"];
    };
    stripe = {
      tools = ["@stripe"];
      allowedTools = ["@stripe/search_stripe_documentation"];
    };
    shadcn = {
      tools = ["@shadcn"];
      allowedTools = ["@shadcn"];
    };
    nix-mcp = {
      tools = ["@nix-mcp"];
      allowedTools = ["@nix-mcp"];
    };
    cdk = {
      tools = ["@awslabs.cdk-mcp-server"];
      allowedTools = ["@awslabs.cdk-mcp-server"];
    };
    aws-knowledge = {
      tools = ["@awslabs.knowledge-mcp-server"];
      allowedTools = ["@awslabs.knowledge-mcp-server"];
    };
  };

  # Default toolsSettings for all agents
  defaultToolsSettings = {
    execute_bash = {
      autoAllowReadonly = true;
      allowedCommands = ["make" "nix fmt" "mkdir -p .*" "bun run ts-check .*"];
    };
    use_aws.autoAllowReadonly = true;
    fs_write.allowedPaths = ["~/git/"];
    fs_read.allowedPaths = ["~/git/"];
  };

  jsonFormat = pkgs.formats.json {};

  # Build agent JSON from config
  mkAgent = name: agentCfg: let
    enabledServers = lib.filterAttrs (_: v: v) agentCfg.mcpServers;
    serverNames = lib.attrNames enabledServers;

    selectedMcpServers = lib.listToAttrs (map (s: {
        name =
          if s == "cdk"
          then "awslabs.cdk-mcp-server"
          else if s == "aws-knowledge"
          then "awslabs.knowledge-mcp-server"
          else s;
        value = mcpServers.${s};
      })
      serverNames);

    defaultTools = lib.flatten (map (s: mcpToolDefaults.${s}.tools or []) serverNames);
    defaultAllowed = lib.flatten (map (s: mcpToolDefaults.${s}.allowedTools or []) serverNames);

    # Merge default and extra allowed commands
    mergedToolsSettings = lib.recursiveUpdate defaultToolsSettings {
      execute_bash.allowedCommands = defaultToolsSettings.execute_bash.allowedCommands ++ agentCfg.extraAllowedCommands;
    };

    # Resources: global + agent-specific + local rules
    agentResources =
      [
        "file://~/.kiro/resources/global.md"
        "file://~/.kiro/resources/${name}.md"
        "file://.agent/**/*.md"
        "file://docs/**/*.md"
        "file://docs/**/*.mmd"
      ]
      ++ agentCfg.extraResources;
  in
    {
      "$schema" = "https://raw.githubusercontent.com/aws/amazon-q-developer-cli/refs/heads/main/schemas/agent-v1.json";
      inherit name;
      inherit (agentCfg) description prompt;
      mcpServers = selectedMcpServers;
      tools = ["@builtin"] ++ defaultTools ++ agentCfg.extraTools;
      allowedTools = ["code"] ++ defaultAllowed ++ agentCfg.extraAllowedTools;
      toolsSettings = mergedToolsSettings;
      resources = agentResources;
    }
    // lib.optionalAttrs (agentCfg.hooks != {}) {inherit (agentCfg) hooks;};

  # Agent option type
  agentOpts = lib.types.submodule {
    options = {
      description = lib.mkOption {type = lib.types.str;};
      prompt = lib.mkOption {type = lib.types.str;};
      mcpServers = {
        github = lib.mkEnableOption "GitHub MCP";
        context7 = lib.mkEnableOption "Context7 MCP";
        stripe = lib.mkEnableOption "Stripe MCP";
        shadcn = lib.mkEnableOption "Shadcn MCP";
        nix-mcp = lib.mkEnableOption "Nix MCP";
        cdk = lib.mkEnableOption "CDK MCP";
        aws-knowledge = lib.mkEnableOption "AWS Knowledge MCP";
      };
      extraTools = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      extraAllowedTools = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      extraAllowedCommands = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      extraResources = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      hooks = lib.mkOption {
        type = lib.types.attrs;
        default = {};
      };
    };
  };
in {
  options.kiro = {
    enable = lib.mkEnableOption "Kiro CLI";
    agents = lib.mkOption {
      type = lib.types.attrsOf agentOpts;
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Python
      python3
      uv
      ty
      pyright
      ruff
      # TypeScript
      nodejs
      biome
      typescript-language-server
      typescript
      # Utilities
      docker
      gemini-cli
    ];
    programs.uv.enable = true;
    home.sessionPath = ["$HOME/.local/bin"];

    # Generate agent files and resources
    home.file =
      (lib.mapAttrs' (name: agentCfg: {
          name = ".kiro/agents/${name}.json";
          value.source = jsonFormat.generate "${name}.json" (mkAgent name agentCfg);
        })
        cfg.agents)
      // {
        ".kiro/resources" = {
          source = ./assets/kiro/resources;
          recursive = true;
        };
      };

    zsh.shellAliases =
      {
        k = "kiro-cli";
      }
      // lib.mapAttrs' (name: _: {
        name = "k-${name}";
        value = "k chat --agent ${name}";
      })
      cfg.agents;

    programs.zsh.initContent = ''
      . ${homeDir}/secrets/load-secrets.sh
      . ${homeDir}/secrets/stripe-secret-key.env
      . ${homeDir}/secrets/context7-api-key.env
    '';
  };
}
