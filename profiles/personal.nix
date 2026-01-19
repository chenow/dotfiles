{
  lib,
  pkgs,
  config,
  ...
}: {
  options.profiles.personal = {
    enable = lib.mkEnableOption "Personal profile";
  };

  config = lib.mkIf config.profiles.personal.enable {
    home.packages = with pkgs; [
      terraform
      python3
      postgresql
      supabase-cli
      aws-cdk-cli
      stripe-cli
    ];

    kiro = {
      enable = true;
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
            "cd .* && bun run format"
            "cd .* && bun run ts-check"
            "cd .* && bunx shadcn@latest .*"
          ];
          hooks = {
            "postToolUse" = [
              {
                "matcher" = "fs_write";
                "command" = "if [ -f package.json ]; then bun run format 2>/dev/null || true; fi";
              }
              {
                "matcher" = "fs_write";
                "command" = "if [ -f frontend/package.json ]; then cd frontend && bun run format 2>/dev/null || true; fi";
              }
              {
                "matcher" = "fs_write";
                "command" = "if [ -f pyproject.toml ] || [ -f backend/pyproject.toml ]; then ruff format . 2>/dev/null || true; fi";
              }
            ];
          };
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

    additional.enablePersonal = true;
    vscodium.enable = true;

    zsh.completions = ["bun" "terraform" "python" "aws" "uv"];
    home.sessionVariables = {
      DRIVE = "/Users/chenow/Library/Mobile Documents/com~apple~CloudDocs";
    };
  };
}
