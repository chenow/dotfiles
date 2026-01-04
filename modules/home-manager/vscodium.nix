{
  lib,
  pkgs,
  config,
  ...
}: {
  options.vscodium.enable = lib.mkEnableOption "VSCodium";

  config = lib.mkIf config.vscodium.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        extensions = with pkgs.vscode-extensions;
          [
            # Nix
            jnoortheen.nix-ide

            # Git
            eamodio.gitlens

            # Python
            ms-python.python
            charliermarsh.ruff

            # Typescript
            biomejs.biome

            # Web
            bradlc.vscode-tailwindcss
            yoavbls.pretty-ts-errors

            # Config files
            redhat.vscode-yaml
            redhat.vscode-xml
            tamasfe.even-better-toml

            # Utilities
            usernamehw.errorlens
            pkief.material-icon-theme
            yzhang.markdown-all-in-one
            ms-azuretools.vscode-containers
          ]
          ++ (with pkgs.vscode-marketplace; [
            # AI/Code Assistance
            google.geminicodeassist
            astral-sh.ty
            tomoyukim.vscode-mermaid-editor
          ]);
        userSettings = {
          # Nix
          # https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
          "nix.serverSettings".nixd = {
            formatting.command = ["alejandra"];
            completion.enable = true;
          };

          # Editor
          "editor.defaultFormatter" = null;
          "editor.accessibilitySupport" = "off";
          "editor.formatOnSave" = true;
          "editor.formatOnPaste" = true;
          "editor.inlineSuggest.enabled" = true;
          "editor.linkedEditing" = true;
          "editor.minimap.enabled" = false;
          "editor.unicodeHighlight.invisibleCharacters" = false;
          "editor.unicodeHighlight.ambiguousCharacters" = false;
          "editor.quickSuggestions".strings = "on";

          # Python
          "[python]" = {
            "editor.defaultFormatter" = "charliermarsh.ruff";
            "editor.codeActionsOnSave" = {
              "source.fixAll" = "always";
              "source.organizeImports" = "always";
            };
          };
          "python.languageServer" = "None";
          "ruff.fixAll" = true;
          "ruff.configurationPreference" = "filesystemFirst";

          # TypeScript/JavaScript
          "[javascript][typescript][javascriptreact][typescriptreact]" = {
            "editor.defaultFormatter" = "biomejs.biome";
            "editor.codeActionsOnSave" = {
              "source.organizeImports.biome" = "always";
              "source.fixAll.ts" = "always";
              "source.fixAll.biome" = "always";
            };
          };
          "javascript.updateImportsOnFileMove.enabled" = "always";

          # CSS/Tailwind
          "files.associations"."*.css" = "tailwindcss";
          "tailwindCSS.lint.suggestCanonicalClasses" = "ignore";

          # Docker
          "[dockerfile]"."editor.defaultFormatter" = "ms-azuretools.vscode-containers";
          "[dockercompose]" = {
            "editor.insertSpaces" = true;
            "editor.tabSize" = 2;
            "editor.autoIndent" = "advanced";
            "editor.defaultFormatter" = "redhat.vscode-yaml";
          };

          # YAML/JSON/Markdown
          "[yaml]"."editor.defaultFormatter" = "redhat.vscode-yaml";
          "[github-actions-workflow]"."editor.defaultFormatter" = "redhat.vscode-yaml";
          "[json]"."editor.defaultFormatter" = "vscode.json-language-features";
          "[jsonc]"."editor.defaultFormatter" = "vscode.json-language-features";
          "[markdown]"."editor.defaultFormatter" = "yzhang.markdown-all-in-one";

          # Explorer/Workbench
          "workbench.iconTheme" = "material-icon-theme";
          "explorer.compactFolders" = false;
          "explorer.confirmDragAndDrop" = false;
          "explorer.fileNesting.enabled" = true;
          "diffEditor.renderSideBySide" = true;

          # Files
          "files.exclude" = {
            "**/.pytest_cache" = true;
            "**/.mypy_cache" = true;
            "**/.ruff_cache" = true;
            "**/__pycache__" = true;
            "**/.direnv" = true;
          };

          # Terminal
          "terminal.integrated.defaultProfile.osx" = "zsh";
          "terminal.integrated.defaultProfile.linux" = "zsh";
          "terminal.integrated.enableMultiLinePasteWarning" = "never";

          # Git
          "git.openRepositoryInParentFolders" = "never";
          "gitlens.views.scm.grouped.views" = {
            commits = true;
            branches = true;
            remotes = true;
            stashes = true;
            tags = true;
            worktrees = true;
            contributors = true;
            fileHistory = true;
            repositories = true;
            searchAndCompare = true;
            launchpad = false;
          };

          # Security/Telemetry
          "security.workspace.trust.untrustedFiles" = "open";
          "redhat.telemetry.enabled" = false;
          "telemetry.telemetryLevel" = "off";

          # Gemini Code Assist
          "geminicodeassist.enableTelemetry" = false;
          "http.systemCertificatesNode" = true;
          "geminicodeassist.project" = "trendy-spots";
        };
      };
    };
  };
}
