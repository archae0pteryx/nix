{
  stateVersion = 4;
  defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSAutomaticWindowAnimationsEnabled = false;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSUseAnimatedFocusRing = false;
      "com.apple.keyboard.fnState" = true;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.feedback" = 1;
      "com.apple.springing.enabled" = false;
    };
    dock = {
      orientation = "left";
      show-recents = false;
      autohide = true;
      autohide-delay = 0.1;
      expose-animation-duration = 0.1;
      expose-group-by-app = false;
      launchanim = false;
      mru-spaces = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
    };
    universalaccess = { reduceMotion = true; };
  };
  startup = { chime = false; };
}
