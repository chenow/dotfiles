{
  self,
  pkgs,
  config,
  lib,
  user,
  ...
}: {
  # Load configuration that is shared across systems
  environment.variables = {
    BROWSER = "arc";
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  system.stateVersion = 5;
  system.configurationRevision = self.rev or self.dirtyRev or null;

  system = {
    defaults = {
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
        persistent-apps = [
          "/Applications/Arc.app"
          "/Applications/Microsoft Outlook.app"
          "/Applications/Microsoft Teams.app"
          "/Applications/Obsidian.app"
          "/Applications/WezTerm.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/WhatsApp.app"
          "/Applications/Slack.app"
          "/Applications/Telegram.app"
        ];
        persistent-others = [
          "/Users/${user}/Desktop"
          "/Users/${user}/Downloads"
        ];
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
