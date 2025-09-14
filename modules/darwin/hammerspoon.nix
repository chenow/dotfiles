{
  lib,
  config,
  ...
}: {
  options.hammerspoon.enable = lib.mkEnableOption "Enable Hammerspoon configuration";
  config = lib.mkIf config.hammerspoon.enable {
    home.file.".hammerspoon/init.lua".text = ''
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
}
