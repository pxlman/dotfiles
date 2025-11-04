{ lib, config, pkgs, ... }:
{
# Fusuma is for touchpad gestures
services.fusuma = {
  enable = true;
  package = pkgs.fusuma;
  settings = {
    threshold = {
      swipe = 0.05;
    };
    interval = {
      swipe = 0.7;
    };
    swipe = {
      "3" = {
        left = {
          # command = "xdotool key super+bracketleft";
          command = "xdotool key super+bracketleft";
        };
        right = {
          command = "xdotool key super+bracketright";
        };
        up = {
          command = "xdotool key alt+Tab";
        };
        down = {
          command = "xdotool key alt+shift+Tab";
        };
      };
      "4" = {
        left = {
          # command = "xdotool key super+bracketleft";
          command = "xdotool key XF86MonBrightnessDown";
        };
        right = {
          command = "xdotool key XF86MonBrightnessUp";
        };
        up = {
          command = "xdotool key XF86AudioRaiseVolume";
        };
        down = {
          command = "xdotool key XF86AudioLowerVolume";
        };
      };
    };
  };
};
services.syncthing.enable = true;
services.copyq = {
  enable = false;
};
services.flameshot = {
  enable = false;
  settings.General= {
    disabledTrayIcon = true;
    showStartupLaunchMessage = false;
  };
};
services.activitywatch = {
  enable = true;
};
services.dunst = {
  enable = true;
  iconTheme = {
    name = "Papirus";
    size = "15";
    package = pkgs.papirus-icon-theme;
  };
  settings = {
    global = {
      width = 300;
      height = 300;
      offset = "10x50";
      origin = "bottom-center";
      font = "Monospace 15";
      line_hight = 0;
      format = "%I%s %p\n%b";
      scale = 0;
      notification_limit = 2;
      indicate_hidden = true;
      frame_width = 1;
      frame_color = "#282a36";
      sort = true;
      gap_size = 2;
      transparency = 5;
      background = "#282a36";
      foreground = "#cfc6fc";
      mouse_left_click = "close_current"; # [* |  ]
      mouse_right_click = "do_action,close_current"; # [  | *]
    };
  };
};
}
