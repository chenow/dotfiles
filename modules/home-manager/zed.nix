{
  lib,
  config,
  ...
}: {
  options.zed.enable = lib.mkEnableOption "Zed editor";

  config = lib.mkIf config.zed.enable {
    programs.zsh.shellAliases.z = "zeditor";

    programs.zed-editor = {
      enable = true;

      extensions = [
        "nix"
        "python-lsp"
        "ruff"
        "biome"
        "html"
        "toml"
        "dockerfile"
        "docker-compose"
        "make"
        "tailwind-color-hint"
        "csv"
        "rainbow-csv"
        "env"
        "git-firefly"
        "mermaid"
        "vscode-dark-modern"
        "context7-mcp-server"
      ];

      userSettings = {
        language_models.ollama = {
          api_url = "http://localhost:11434";
          available_models = [
            {
              name = "qwen2.5-coder:7b";
              display_name = "Qwen 2.5 Coder 7B (32K)";
              max_tokens = 32768;
            }
            {
              name = "qwen3-coder:30b";
              display_name = "Qwen3 Coder 30B MoE (256K)";
              max_tokens = 65536;
            }
            {
              name = "devstral";
              display_name = "Devstral 24B (128K)";
              max_tokens = 65536;
            }
          ];
        };
        agent.default_model = {
          provider = "ollama";
          model = "devstral";
        };
        edit_predictions.mode = "eager";
        edit_predictions.default_model = {
          provider = "ollama";
          model = "qwen2.5-coder:0.5b";
        };
        agent_servers = {
          kiro = {
            type = "custom";
            command = "kiro-cli";
            args = ["acp"];
            env = {};
          };
          gemini.ignore_system_version = false;
        };

        # Editor
        vim_mode = false;
        theme = {
          mode = "dark";
          dark = "VS Code Dark Modern";
          light = "VS Code Light Modern";
        };
        ui_font_size = 16;
        buffer_font_size = 14;
        buffer_font_family = "JetBrainsMono Nerd Font";
        tab_size = 2;
        format_on_save = "on";
        autosave.after_delay.milliseconds = 1000;
        minimap.enabled = false;
        inlay_hints.enabled = true;
        inline_diagnostics.enabled = true;
        linked_edits = true;

        # Terminal
        terminal = {
          font_family = "JetBrainsMono Nerd Font";
          shell.program = "zsh";
        };

        # Telemetry
        telemetry = {
          diagnostics = false;
          metrics = false;
        };

        # File exclusions
        file_scan_exclusions = [
          "**/.pytest_cache"
          "**/.mypy_cache"
          "**/.ruff_cache"
          "**/__pycache__"
          "**/.direnv"
          "**/.git"
          "**/node_modules"
        ];

        # Languages
        languages = {
          Nix = {
            formatter.external = {
              command = "alejandra";
              arguments = [];
            };
            tab_size = 2;
          };
          Python = {
            formatter.external = {
              command = "ruff";
              arguments = ["format" "-"];
            };
            tab_size = 4;
            code_actions_on_format = {
              "source.fixAll.ruff" = true;
              "source.organizeImports.ruff" = true;
            };
          };
          JavaScript = {
            formatter.language_server.name = "biome";
            code_actions_on_format."source.organizeImports.biome" = true;
          };
          TypeScript = {
            formatter.language_server.name = "biome";
            code_actions_on_format."source.organizeImports.biome" = true;
          };
          TSX = {
            formatter.language_server.name = "biome";
            code_actions_on_format."source.organizeImports.biome" = true;
          };
          YAML.tab_size = 2;
          Markdown.format_on_save = "off";
        };
      };
    };
  };
}
