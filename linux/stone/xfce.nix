{
  # Power Manager - disable screen saver / power saving
  "xfce4-power-manager" = {
    "/xfce4-power-manager/blank-on-ac" = 0;
    "/xfce4-power-manager/blank-on-battery" = 0;
    "/xfce4-power-manager/dpms-enabled" = false;
    "/xfce4-power-manager/dpms-on-ac-off" = 0;
    "/xfce4-power-manager/dpms-on-ac-sleep" = 0;
    "/xfce4-power-manager/dpms-on-battery-off" = 0;
    "/xfce4-power-manager/dpms-on-battery-sleep" = 0;
  };

  # Screensaver - disable
  "xfce4-screensaver" = {
    "/saver/enabled" = false;
    "/lock/enabled" = false;
  };

  # Mouse - natural scrolling (reverse)
  "pointers" = { "/ReverseScrolling" = true; };

  # Keyboard shortcuts
  "xfce4-keyboard-shortcuts" = {
    # Workspace switching: Alt+1..4 (wmctrl uses 0-indexed workspaces)
    "/commands/custom/<Alt>1" = "wmctrl -s 0";
    "/commands/custom/<Alt>2" = "wmctrl -s 1";
    "/commands/custom/<Alt>3" = "wmctrl -s 2";
    "/commands/custom/<Alt>4" = "wmctrl -s 3";

    # Move window to workspace: Alt+Shift+1..4
    "/xfwm4/custom/<Alt><Shift>1" = "move_window_workspace_1_key";
    "/xfwm4/custom/<Alt><Shift>2" = "move_window_workspace_2_key";
    "/xfwm4/custom/<Alt><Shift>3" = "move_window_workspace_3_key";
    "/xfwm4/custom/<Alt><Shift>4" = "move_window_workspace_4_key";

    # Clipboard manager: Ctrl+Shift+V
    "/commands/custom/<Primary><Shift>v" = "xfce4-clipman-history";
  };

  # Workspaces - ensure 4 exist
  "xfwm4" = { "/general/workspace_count" = 4; };
}
