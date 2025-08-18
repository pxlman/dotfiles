{ config,lib, pkgs, ... }: 
  let 
    # Import unstable nixpkgs manually
    unstable = import <nixpkgs-unstable> {
      config.allowUnfree = true;
    };
    android = pkgs.androidenv.composeAndroidPackages {
      platformVersions = [ "33" ]; # Choose platform version you need
      buildToolsVersions = [ "33.0.2" ];
      abiVersions = [ "x86_64" ]; # For emulator
    };
    xfox = import ./my-pkgs/xfox.nix;
    quran = import ./my-pkgs/quran.nix;
    bongocat = import ./my-pkgs/bongocat.nix;
    terminal = pkgs.alacritty;
  in

{
nixpkgs.config = {
  allowUnFree = true;
  allowUnsupportedSystem = true;
  android_sdk.accept_license = true;
};
home.stateVersion = "25.05";
home.username = "pxlman";
home.homeDirectory = "/home/pxlman";
home.packages = with pkgs; [
### THEMES and Styles
  dconf # I Don't know but gtk needs it
  lxappearance # Themes and Fonts manager
  font-manager # Font Manager
  nwg-displays
  #copyq # Clipboard manager
  bibata-cursors # My cursor theme
  # mint-themes # Temporary theme
  # rose-pine-gtk-theme # errored with pavucontrol and gnome-clocks
  # catppuccin-gtk # hidden
  materia-theme
  # flat-remix-gtk # bad
  # ayu-theme-gtk
  graphite-gtk-theme
  libnotify # For the notify-send command
  nitrogen # Wallpapers
  flameshot # Screenshots
  grim
  slurp
  conky # Desktop Widgets
  # rofi
  rofi-wayland
  # unstable.wayland-bongocat
  bongocat # For the cute cat
  rofi-power-menu
  rofi-emoji
  wofi
  hypridle
  wl-clipboard
  hyprpolkitagent
  hyprswitch
  swww
  mpvpaper
  waybar
  hyprpicker # For picking colors 
  wlogout
  waytrogen
  wallust
  htop
### Services
  activitywatch # For tracking time
  xclip # Copy and Paste service
  xdotool # make me able to use shortcuts with commmands
  udiskie # For mounting and unmounting
  mimeo # open files using mimeopen
  bat # cat like
  lf # ranger like (terminal file manager for quick purposes)
  mpv # video player
  kalker
  pulseaudio # audio driver
  pamixer # Modifing audio from terminal
  dunst # For notifications
  pavucontrol # modifying audio in GUI
  brightnessctl # For brightness
  redshift # Eye comfort
  miniserve # Sharing between local devices
  # localsend # Sharing between local devices
  syncthing # Syncing folders between phone and laptop
  # mconnect
  yt-dlp
  appimage-run
  peaclock
  gnome-clocks
  xfox # Gamepad remapper tool
### Applications
  nemo-with-extensions
  brave
  quran
  surf
  telegram-desktop
  hexchat
  firefox # for burp suite
  zathura # pdf reader
  # okular # pdf reader
  kdePackages.okular
  pdfmixtool # pdf editor
  qbittorrent # torrent
  # zoom-us
  audacity
  unstable.discord
  openboard
  zeal
  php84Packages.composer
  php84Extensions.sqlite3
  php84Extensions.curl
  php84
  #hexchat
  gimp
  openshot-qt # video editor
  shotcut # video editor
  avidemux # video editor
  kdePackages.kdenlive
  plantuml
  emacs
  emacsPackages.doom
  # ciscoPacketTracer8 # you may need to download the debian package then add it's hash manually using nix-store --add-fixed sha256 <path>.deb with the same official name
  dynamips
  # pkgs.unstable.discord unstable can be put in /etc/nixos/configuration.nix at the user section
  loupe # image viewer
  eog
  xorg.xf86videovboxvideo
  xorg.xkill
  wmctrl
  anki-bin
  vlc
  zathura
  unstable.obsidian
  cherrytree # NoteTaking app
  clickup
  unstable.vscode
  code-cursor
  sublime3
  jetbrains.phpstorm
  jetbrains.clion
  jetbrains.pycharm-professional
  jetbrains.idea-ultimate
  qtcreator # To make qt gui programs
  libsForQt5.full
  netbeans
  gparted
  libreoffice
  xournalpp
  weylus
  postman
  dbeaver-bin
  # beekeeper-studio
  rhythmbox
  dpkg
### Android development
  pkgs.android-studio #.overrideAttrs (old: { unpackPhase = "true"; })  # disable the default unpacking
### Android development tools (without android-studio)
  android.androidsdk
  android.platform-tools
  # android.cmdline-tools
  # unstable.gradle
  unstable.android-tools
  sqlcmd
  yarn
  jdk17
### Gaming
  zeroad # 0ad
  gamepad-tool # Testing gamepad
  legendary-gl # CLI tool for epic games 
  rare # legendary GUI client
  heroic # Epic games launcher
  # retroarch
  superTux
  superTuxKart
  ddnet
  lutris # games launcher
  gamepad-tool
  ### CLI Apps
  helix # Text editor command `hx`
  nettools # ithink for ip a
  eza # ls fork
  # tmux
  docker
  ascii # show ascii table
### OSINT
  sherlock
### Hacking
  ## Python interpreter and modules
  python312
  python312Packages.requests  # Add any required Python modules
  unstable.nodejs_23
  ## C++ development tools and libraries
  gcc
  cmake
  arp-scan
  gnumake # for the `make` command
  boost
  gdb
  ## Recon
  nmap
  fping
  # katana
  ## Web
  burpsuite
  zap
  ## Crypto
  xxd
  ## DFIR
  exiftool
  # nuclei
  ## General
  # cvemap
  wireshark
  hash-identifier
  ## Fuzzing
  gobuster
  ffuf
  john
  wordlists
  ## Packets
  # tshark
  # tcpdump
  # termshark
  ];

# xresources.extraConfig = ''
#   Xft.antialias: true
#   Xft.hinting: true
#   Xft.hintstyle: hintfull
#   Xft.rgba: rgb
#   Xft.lcdfilter: lcddefault
#   Xft.dpi: 130
# '';
home.pointerCursor = {
  x11.enable = true;
  # name = "Bibata-Modern-Ice";
  name = "Bibata-Modern-Classic";
  size = 10;
  package = pkgs.bibata-cursors;
};
gtk = {
  enable = true;
  iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };
  theme = {
    # name = "rose-pine";
    name = "Materia-dark";
    package = pkgs.materia-theme; # pkgs.whitesur-gtk-theme
  };
  font = {
    # name = "Hack";
    name = "Ubuntu Nerd Font Mono";
    # package = pkgs.nerdfonts;
    size = 12;
  };
  gtk3.extraConfig = {
    gtk-application-prefer-dark-theme=1;
    gtk-menu-images = 1;
    gtk-button-images = 1;
    gtk-xft-antialias = 1;
    gtk-xft-hinting = 1;
    gtk-xft-hintstyle = "hintfull";
    gtk-xft-rgba = "rgb";
  };
  gtk4.extraConfig = {
    gtk-application-prefer-dark-theme=true;
    gtk-xft-antialias = 1;
    gtk-xft-hinting = 1;
    gtk-xft-hintstyle = "hintfull";
    gtk-xft-rgba = "rgb";
  };
  gtk3.bookmarks = [
    "file:///home/pxlman/Documents Documents"
    "file:///home/pxlman/Downloads Downloads"
    "file:///home/pxlman/Music Music"
    "file:///home/pxlman/Videos Videos"
    "file:///home/pxlman/Pictures Pictures"
    "file:///mnt/files Files"
    "file:///mnt/files/Resources/الاكاديمية الاكاديمية"
    "file:///mnt/files/Resources/University University"
  ];
};
qt = {
  enable = true;
  platformTheme.name = "gtk3";
};
xdg.desktopEntries = {
  tlauncher = {
    name = "TLauncher";
    genericName = "Minecraft Launcher";
    exec = "steam-run java -jar /home/pxlman/Downloads/Tlauncher/TLauncher.jar";
    terminal = false;
    categories = [ "Application" "Game" ];
    icon = "minecraft-launcher";
    # mimeType = [ "text/html" "text/xml" ];
  };
  neovim = {
    name = "neovim";
    genericName = "Neovim";
    exec = "alacritty nvim";
    terminal = true;
    categories = [ "TextEditor" "Utility" ];
    icon = "vim";
    mimeType = [ "text/plain" ];
  };
};

# Hyprland configuration
wayland.windowManager.hyprland = {
  enable = false;
  # package = pkgs.hyprland;
  settings = {
    # This is the default config, you can change it
    # configFile = ./hyprland.conf;
    theme = "Materia-dark";
    # theme = "Ayu-Dark";
    # bind = {
    #   "Super+Return" = "alacritty";
    #   "Super+e" = "nemo";
    #   "Super+f" = "brave";
    #   "Super+v" = "vlc";
    #   # "Super+g" = "exec gnome-clocks";
    #   "Super+p" = "~/.config/rofi/powermenu/type-1/powermenu.sh";
    #   "Super+d" = "~/.config/rofi/launchers/type-1/run.sh";
    #   "Super+F1" = "nemo";
    #   "Super+F2" = "brave --password-store=basic";
    # };
    bind = [
      "SUPER, RETURN, exec, alacritty"
      "SUPER, F1, exec, nemo"
      "SUPER, F2, exec, brave --password-store=basic"
      "SUPER, d, exec, ~/.config/rofi/launchers/type-1/run.sh"
      "SUPER, p, exec, ~/.config/rofi/powermenu/type-1/powermenu.sh"
      "SUPER_SHIFT, d, exec, ~/.config/rofi/launchers/type-1/drun.sh"
    ];
  };
};

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
programs.freetube = {
  enable = true;
  package = pkgs.freetube;
  settings = {
    allowDashAv1Formats = true;
    checkForUpdates     = false;
    defaultQuality      = "480";
    baseTheme           = "catppuccinMocha";
  };
};
# Git config
programs.git = {
  enable = true;
  userName = "pxlman";
  userEmail = "agxgv7573@gmail.com";
  extraConfig = {
    safe.directory = "/etc/nixos";
  };
};
# ZSH configuration
programs.eza.enableZshIntegration = true;
programs.zsh = {
  enable = true;
  autocd = true; # directly cd to dir if typed
  enableCompletion = true;
  autosuggestion = {
    enable = true;
    #highlight = "fg=#aaaaaa,bg=black,regular,underline";
  };
  syntaxHighlighting = {
    enable = true;
    highlighters = [
      "brackets"
    ];
  };
  oh-my-zsh = {
    enable = true;
    theme = "tjkirch";
    plugins = [
      "sudo" # sudo the previous command by just double ESC
      "eza"
      "git"
    ];
  };
  #enableLsColors = true;
  shellAliases = {
    ls = "exa -g --color=always --group-directories-first --icons --color-scale";
    ll = "exa -lag --color=always --group-directories-first --icons --color-scale";
    t = "tree .";
    grep = "grep --color=always";
    du = "dust -r";
    df = "df -h";
    h = "helix";
    n = "nvim";
    s = "snooze";
    d = "curl -LO";
    docker = "sudo docker";
    #nrc = "nvim ~/.config/nvim";
    copy="xclip -selection clipboard";
    rc = "nvim ~/.config/home-manager/home.nix";
    nrc = "sudo nvim /etc/nixos/configuration.nix";
    gitdone="git add .; git commit -m '[+]'; git push; echo '[*] Files Saved'"; # git done
    home = "home-manager switch -f ~/dotfiles/users/pxlman/.config/home-manager/home.nix";
    switch = "sudo nixos-rebuild switch --verbose";
    hdmi = "xrandr --output HDMI-1 --output eDP-1  --auto";
    juice-shop = "docker run --rm -p 127.0.0.1:3000:3000 bkimminich/juice-shop";
    webgoat = "docker run -it -p 127.0.0.1:8080:8080 -p 127.0.0.1:9090:9090 webgoat/webgoat";
    free-steam = "curl \"https://store.steampowered.com/search/?maxprice=free&supportedlang=english&specials=1&ndl=1\" -s | grep -oP '(?<=class=\"title\">)(?:(?!Add-On).)*(?=<.*)'";
    steam-free = "free-steam";
    clickup = "appimage-run ~/clickup.AppImage";
    ytd = "yt-dlp --format='135+139' --embeded-chapters";
    # pavucontrol = "GTK_THEME= pavucontrol";
  };
  initContent = ''
    export _JAVA_AWT_WM_NONREPARENTING=1
    # This is to solve vulkan error in steam
    # U must make sure to install the needed vulkan drivers (these files r there)
    # packages(i think): vulkan-intel vulkan-headers vulkan-tools 
    export VK_DRIVER_FILES=/usr/share/vulkan/icd.d/intel_icd.i686.json:/usr/share/vulkan/icd.d/intel_icd.x86_64.json
    cat ~/.cache/wallust/sequences
  '';
};
xdg.mimeApps = {
  enable = true;
  defaultApplications = {
    "image/png" = "org.gnome.eog.desktop";
    "image/jpeg" = "org.gnome.eog.desktop";
    "video/mp4" = "vlc.desktop";
    "video/mkv" = "vlc.desktop";
    "audio/mp3" = "vlc.desktop";
    "application/pdf" = "okularApplication_pdf.desktop";
    "application/pptx" = "okularApplication_pdf.desktop";
    "application/ppt" = "okularApplication_pdf.desktop";
    "text/plain" = "sublime_text.desktop";
    "inode/directory" = "nemo.desktop";
  };
};
programs.mangohud = {
  enable = true;
  settings = {
    # full = true;
    fps = true;
    cpu_stats = true;
    cpu_load_change = true;
    #text_outline = true;
    position = "top-left";
  };
};
# programs.distrobox
home.sessionPath = [
  "$HOME/.local/bin"
  "$HOME/.myapps"
  "/bin"
  "$HOME/dotfiles"
  "$HOME/.npm-global/bin"
  "$ANDOID_HOME/emulator"
  "$ANDROID_HOME/platform-tools"
];
home.sessionVariables = {
  # PS1="[\[\033[1;32m\]\u\[\033[0m\]@\[\033[1;34m\]\h\[\033[0m\] \[\033[1;36m\]\w\[\033[0m\]]\[\033[1;31m\]\$\[\033[0m\]";
  _JAVA_AWT_WM_NONREPARENTING=1;
  # this is to solve vulkan error in steam
  # U must make sure to install the needed vulkan drivers (these files r there)
  # packages(i think): vulkan-intel vulkan-headers vulkan-tools 
  LIBVA_DRIVER_NAME = "x86_64 VDPAU_DRIVER=va_gl";
  #LIBVA_DRIVERS_PATH="/usr/lib/dri/iHD_drv_video.so";
  #VK_DRIVER_FILES="/usr/share/vulkan/icd.d/intel_icd.i686.json:/usr/share/vulkan/icd.d/intel_icd.x86_64.json";
  GTK_THEME = "Materia-dark"; # WhiteSur-dark
  # QT_SCALE_FACTOR="1.25";
  # QT_FONT_DPI="125";
  # GDK_DPI_SCALE = "1.25"; # This scales up gtk xwayland apps
  NIXPKGS_ALLOW_UNFREE=1;
  PYTHONPATH = "${pkgs.python312}/lib/python3.12/site-packages";
  EDITOR = "nvim";
  VISUAL = "nvim";
  ANDROID_HOME = "$HOME/Android/Sdk";
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
xdg.userDirs = {
  enable = true;
  createDirectories = true;
};
}
