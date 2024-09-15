{ username, ... }:

{
  system.defaults.dock = {
    show-recents = false;
    minimize-to-application = true;
    mineffect = "scale";
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
      "/Users/${username}/Desktop"
      "/Users/${username}/Downloads"
    ];
  };
}
