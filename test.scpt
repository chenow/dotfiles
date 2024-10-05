tell application "System Events"
    tell application "WezTerm" to activate
    delay 1

    -- Open the first app on the left
    tell application "Finder" to set frontmost to true
    delay 0.5
    tell application "WezTerm" to set bounds of window 1 to {0, 23, 720, 820}

    -- Open the second app on the right
    tell application "Visual Studio Code" to activate
    delay 0.5
    tell application "Visual Studio Code" to set bounds of window 1 to {720, 23, 1440, 820}
end tell
