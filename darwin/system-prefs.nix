{ hostname, ... }: {
  stateVersion = 4;
  defaults = {
    # universalaccess = {
    #   reduceMotion = true;
    #   reduceTransparency = true;
    # };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      AppleSpacesSwitchOnActivate = true;
      AppleWindowTabbingMode = "always";
      AppleShowAllFiles = true;
      NSAutomaticWindowAnimationsEnabled = false;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSUseAnimatedFocusRing = false;
      "com.apple.keyboard.fnState" = true;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.feedback" = 0;
      "com.apple.springing.enabled" = false;
    };
    spaces = {
      spans-displays = false;
    };
    dock = {
      orientation = "left";
      show-recents = false;
      autohide = true;
      autohide-delay = 0.0;
      expose-animation-duration = 0.0;
      # expose-group-by-app = false; # GONE...
      # launchanim = false;
      # mru-spaces = false;
      # persistent-apps = {};
      # persistent-others = {};
      tilesize = 40;
      showhidden = true;
      static-only = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      FXRemoveOldTrashItems = true;
      NewWindowTarget = "Home";
      QuitMenuItem = true;
      # NewWindowTargetPath = "file:///Users/foo/long%20cat%20pics";
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = true;
      ShowMountedServersOnDesktop = true;
      ShowPathbar = false;
      ShowRemovableMediaOnDesktop = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = false;
      # _FXSortFoldersFirstOnDesktop = true;
    };
    loginwindow = {
      GuestEnabled = false;
      LoginwindowText = "8===)~";
      SHOWFULLNAME = false;
    };
    menuExtraClock = { ShowDayOfWeek = true; ShowAMPM = false; };
    screencapture = {
      show-thumbnail = false;
      location = "~/Desktop";
      type = "png";
    };
    smb = {
      NetBIOSName = "${hostname}";
      ServerDescription = "${hostname}";
    };

    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };
  };
  startup = { chime = false; };
}
