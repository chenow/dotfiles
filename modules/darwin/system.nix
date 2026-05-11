{
  self,
  user,
  ...
}: {
  # Load configuration that is shared across systems
  environment.variables = {
    BROWSER = "arc";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

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
          "/Applications/Nix Apps/Obsidian.app"
          "/Users/${user}/Applications/Home Manager Apps/WezTerm.app"
          "/Users/${user}/Applications/Home Manager Apps/VSCodium.app"
          "/Users/${user}/Applications/Home Manager Apps/Zed.app"
          "/Applications/WhatsApp.app"
          "/Applications/Nix Apps/Slack.app"
          "/Applications/Nix Apps/Raycast.app"
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
