# Personal MacBook. Everything this machine gets is declared here; nothing is
# enabled anywhere else. `my.macos.*` is nix-darwin level, the rest is Home
# Manager level (aliased, see ../../modules/home.nix).
{
  pkgs,
  config,
  user,
  ...
}: {
  my.macos = {
    nix.enable = true;

    defaults = {
      enable = true;
      browser = "arc";
      dock.persistentApps = [
        "/Applications/Arc.app"
        "/Applications/Microsoft Outlook.app"
        "/Applications/Obsidian.app"
        "/Users/${user}/Applications/Home Manager Apps/WezTerm.app"
        "/Users/${user}/Applications/Home Manager Apps/VSCodium.app"
        "/Users/${user}/Applications/Home Manager Apps/Zed.app"
        "/Applications/WhatsApp.app"
        "/Applications/Slack.app"
        "/Applications/Raycast.app"
      ];
      dock.persistentOthers = [
        "/Users/${user}/Desktop"
        "/Users/${user}/Downloads"
      ];
    };

    homebrew = {
      enable = true;
      casks = [
        # Communication
        "whatsapp"
        "telegram-desktop"
        "slack"
        "zoom"
        # Productivity
        "raycast"
        "rectangle"
        "obsidian"
      ];
    };

    hammerspoon = {
      enable = true;
      config = ''
        hs.hotkey.bind({ "cmd" }, "@", function()
        local screen = hs.mouse.getCurrentScreen()
        local nextScreen = screen:next()
        local rect = nextScreen:fullFrame()
        local center = hs.geometry.rectMidPoint(rect)

        -- Move mouse and click to change focus
        hs.mouse.setAbsolutePosition(center)
        hs.eventtap.leftClick(center)
        end)
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    ssm-session-manager-plugin
  ];

  my.shell = {
    zsh = {
      enable = true;
      completions = ["bun" "terraform" "python" "aws" "uv"];
      shellAliases.shell = "docker compose run --rm shell";
    };
    direnv.enable = true;
    tools.enable = true;
    television.enable = true;
    wezterm.enable = true;
  };

  my.dev = {
    git = {
      enable = true;
      profile = {
        name = "Antoine Chéneau";
        email = "antoine.cheneau@outlook.com";
      };
    };
    github.enable = true;
    ssh.enable = true;
    docker.enable = true;

    dotfiles = {
      enable = true;
      git-url = "git@github.com:chenow/dotfiles.git";
      dir-path = "${config.home.homeDirectory}/git/dotfiles";
    };

    aws = {
      enable = true;
      extraConfig = {
        "profile galipet" = {
          region = "eu-west-3";
          output = "json";
          login_session = "arn:aws:iam::437064342433:user/antoine.cheneau@outlook.com";
        };
      };
      accounts = [
        {
          name = "galipet-personal";
          accountId = "318361291054";
          region = "eu-west-1";
        }
        {
          name = "personal-management";
          accountId = "901512092184";
          region = "eu-west-1";
        }
      ];
    };
  };

  my.editors.vscodium = {
    enable = true;
    extraSettings."geminicodeassist.project" = "trendy-spots";
  };

  my.ai = {
    agents.enable = true;
    kiro = {
      enable = true;
      resourcesDir = ./assets/kiro/resources;
      agents = {
        coding-agent = {
          description = "Full-stack development with React, TypeScript, Django, and Stripe integration.";
          prompt = ''
            You are a senior full-stack engineer. Before writing code:
            1. Fetch latest docs from Context7 for any library you use
            2. Search GitHub for real-world patterns in popular repos
            3. Use Shadcn MCP for UI components

            Stack: React 19, TypeScript, TanStack Query/Router, Tailwind, Django REST Framework.
            Write minimal, type-safe code. Prefer composition over abstraction.
          '';
          mcpServers = {
            github = true;
            context7 = true;
            stripe = true;
            shadcn = true;
          };
          extraAllowedCommands = [
            "cd .* && bunx shadcn@latest .*"
          ];
        };

        nix-agent = {
          description = "Nix, nix-darwin, and Home Manager configuration expert.";
          prompt = ''
            You are a Nix expert specializing in nix-darwin and Home Manager.
            Always consult nix-mcp for option lookups before suggesting configurations.
            Use Context7 for Nix language docs and GitHub for real config examples.

            Prefer declarative patterns. Keep configs minimal and composable.
            Explain trade-offs between overlays, flakes, and channels when relevant.
          '';
          mcpServers = {
            github = true;
            context7 = true;
            nix-mcp = true;
          };
          extraAllowedCommands = ["cd .* && nix eval .*"];
        };

        cdk-agent = {
          description = "AWS CDK infrastructure with TypeScript and best practices.";
          prompt = ''
            You are an AWS Solutions Architect specializing in CDK with TypeScript.
            Use the CDK MCP for construct lookups and AWS Knowledge MCP for service guidance.

            Priorities: security (least privilege IAM), cost optimization, operational excellence.
            Prefer L2/L3 constructs. Use cdk-nag for compliance. Structure stacks for CI/CD.
          '';
          mcpServers = {
            github = true;
            context7 = true;
            cdk = true;
            aws-knowledge = true;
          };
          extraAllowedCommands = ["cd .* && bun run format" "cd .* && bun run ts-check"];
          hooks = {
            "postToolUse" = [
              {
                "matcher" = "fs_write";
                "command" = "if [ -f package.json ]; then bun run format 2>/dev/null || true; fi";
              }
            ];
          };
        };

        latex-agent = {
          description = "LaTeX for academic papers, theses, and technical documents.";
          prompt = ''
            You are a LaTeX expert for academic writing.
            Search GitHub for document class examples and package usage patterns.

            Focus on: clean document structure, proper bibliography (biblatex), figures/tables, cross-references.
            Suggest packages only when needed. Keep preambles minimal.
          '';
          mcpServers = {
            github = true;
            context7 = true;
          };
        };
      };
    };
  };

  home.packages = with pkgs; [
    python3
    stripe-cli
    marp-cli
    bun
    uv
  ];

  home.sessionVariables = {
    DRIVE = "/Users/${user}/Library/Mobile Documents/com~apple~CloudDocs";
  };
}
