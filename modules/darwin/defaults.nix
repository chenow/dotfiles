{
  lib,
  config,
  ...
}: let
  cfg = config.my.macos.defaults;
  # nix-darwin expects `null` (not `[]`) to leave the Dock untouched.
  orNull = list:
    if list == []
    then null
    else list;
in {
  options.my.macos.defaults = {
    enable = lib.mkEnableOption "opinionated macOS defaults (keyboard, Finder, trackpad, Dock behaviour, Touch ID for sudo)";

    browser = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "arc";
      description = "Value exported as the BROWSER environment variable. Unset when null.";
    };

    touchIdSudo = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Allow Touch ID to authenticate sudo.";
    };

    dock = {
      persistentApps = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        example = ["/Applications/Arc.app"];
        description = "Applications pinned to the Dock. Leaves the Dock untouched when empty.";
      };
      persistentOthers = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        example = ["/Users/me/Downloads"];
        description = "Folders/files pinned to the Dock. Leaves the Dock untouched when empty.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.variables = lib.mkIf (cfg.browser != null) {
      BROWSER = cfg.browser;
    };

    security.pam.services.sudo_local.touchIdAuth = cfg.touchIdSudo;

    system.defaults = {
      NSGlobalDomain = {
        NSWindowShouldDragOnGesture = true;
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;
        AppleShowAllFiles = true;

        AppleWindowTabbingMode = "fullscreen";

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = true;
        show-recents = false;
        minimize-to-application = true;
        mineffect = "scale";
        tilesize = 64;
        persistent-apps = orNull cfg.dock.persistentApps;
        persistent-others = orNull cfg.dock.persistentOthers;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = false;
        FXDefaultSearchScope = "SCcf";
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };
}
