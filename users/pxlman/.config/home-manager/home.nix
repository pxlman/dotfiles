{ config,lib, pkgs, ... }: {
nixpkgs.config = {allowUnFree = true;};
home.stateVersion = "24.11";
home.username = "pxlman";
home.homeDirectory = "/home/pxlman";
home.packages = with pkgs; [
### THEMES and Styles
  dconf # I Don't know but gtk needs it
  lxappearance # Themes and Fonts manager
  font-manager # Font Manager
  #copyq # Clipboard manager
  bibata-cursors # My cursor theme
  mint-themes # Temporary theme
  rose-pine-gtk-theme
  # ayu-theme-gtk
  catppuccin-gtk
  catppuccin
  libnotify # For the notify-send command
  nitrogen # Wallpapers
  flameshot # Screenshots
  conky # Desktop Widgets
  rofi
  rofi-power-menu
  rofi-emoji
  htop
### Services
  xclip # Copy and Paste service
  xdotool # make me able to use shortcuts with commmands
  bat
  kalker
  pulseaudio # audio driver
  pamixer # Modifing audio from terminal
  dunst # For notifications
  pavucontrol # modifying audio in GUI
  brightnessctl # For brightness
  redshift # Eye comfort
  miniserve # Sharing between local devices
  syncthing # Syncing folders between phone and laptop
  #mconnect
  yt-dlp
### Applications
  nemo-with-extensions
  brave
  firefox # for burp suite
  zoom-us
  audacity
  discord
  openboard
  #hexchat
  gimp
  openshot-qt
  shotcut
  avidemux
  kdePackages.kdenlive
  # ciscoPacketTracer8 # you may need to download the debian package then add it's hash manually using nix-store --add-fixed sha256 <path>.deb with the same official name
  dynamips
  # pkgs.unstable.discord unstable can be put in /etc/nixos/configuration.nix at the user section
  loupe # image viewer
  eog
  xorg.xf86videovboxvideo
  xorg.xkill
  anki-bin
  vlc
  zathura
  obsidian
  cherrytree # NoteTaking app
  vscode
  qtcreator # To make qt gui programs
  libsForQt5.full
  jetbrains.clion
  jetbrains.pycharm-professional
  jetbrains.idea-ultimate
  gparted
  libreoffice
  xournalpp
  weylus
  postman
  rhythmbox
  dpkg
### Gaming
  zeroad # 0ad
  gamepad-tool # Testing gamepad
  legendary-gl # CLI tool for epic games 
  rare # legendary GUI client
  heroic # Epic games launcher
  # retroarch
  superTux
  superTuxKart
  lutris # games launcher
  ### CLI Apps
  helix # Text editor command `hx`
  nettools # ithink for ip a
  eza # ls fork
  tmux
  docker
  ascii # show ascii table

### Hacking
  ## Python interpreter and modules
  python312
  python312Packages.requests  # Add any required Python modules
  ## C++ development tools and libraries
  gcc
  cmake
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
  nuclei
  ## General
  cvemap
  wireshark
  hash-identifier
  ## Fuzzing
  ffuf
  john
  wordlists
  ## Packets
  # tshark
  tcpdump
  # termshark
  ];
home.pointerCursor = {
  x11.enable = true;
  name = "Bibata-Modern-Ice";
  size = 10;
  package = pkgs.bibata-cursors;
};
gtk = {
  enable = true;
  # cursorTheme = {
  #   name = "Bibata-Modern-Classic";
  #   package = pkgs.bibata-cursors;
  # };
  iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };
  theme = {
    name = "rose-pine-moon"; # WhiteSur-dark
    package = pkgs.rose-pine-gtk-theme; # pkgs.whitesur-gtk-theme
  };
  font = {
    # name = "Hack";
    name = "Ubuntu Nerd Font";
    package = pkgs.hack-font;
    size = 12;
  };
  gtk3.extraConfig = {
    gtk-application-prefer-dark-theme=1;
    gtk-menu-images = 1;
    gtk-button-images = 1;
    gtk-xft-antialias = 1;
    gtk-xft-hinting = 1;
    gtk-xft-hintstyle = "hintfull";
#gtk-xft-rgba = "rgb";
  };
  gtk3.bookmarks = [
    "file:///home/pxlman/Documents Documents"
    "file:///home/pxlman/Downloads Downloads"
    "file:///home/pxlman/Music Music"
    "file:///home/pxlman/Videos Videos"
    "file:///home/pxlman/Pictures Pictures"
    "file:///mnt/Files Files"
    "file:///mnt/Files/%D8%A7%D9%84%D8%A7%D9%83%D8%A7%D8%AF%D9%8A%D9%85%D9%8A%D8%A9 الاكاديمية"
    "file:///mnt/Files/Resources/University University"
    "file:///mnt/Files/Learn/Cyber%20Security Cyber Security"
    "file:///mnt/myssd myssd"
  ];
};
qt = {
  enable = true;
  platformTheme.name = "gtk3";
};
# Fusuma is for touchpad gestures
services.fusuma = {
  enable = true;
  package = pkgs.fusuma;
  settings = {
    threshold = {
      swipe = 0.1;
    };
    interval = {
      swipe = 0.7;
    };
    swipe = {
      "3" = {
        left = {
          # command = "xdotool key super+bracketleft";
          command = "notify-send hi";
        };
        right = {
          command = "xdotool key super+bracketright";
        };
        up = {
          command = "xdotool key alt+Tab";
        };
        down = {
          command = "xdotool key alt+Tab";
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
  };
  initExtra = ''
    export _JAVA_AWT_WM_NONREPARENTING=1
    # This is to solve vulkan error in steam
    # U must make sure to install the needed vulkan drivers (these files r there)
    # packages(i think): vulkan-intel vulkan-headers vulkan-tools 
    export VK_DRIVER_FILES=/usr/share/vulkan/icd.d/intel_icd.i686.json:/usr/share/vulkan/icd.d/intel_icd.x86_64.json
    
  '';
};
xdg.mimeApps = {
  enable = false;
  defaultApplications = {
    "image/png" = "org.gnome.eog.desktop";
    "image/jpeg" = "org.gnome.eog.desktop";
    "video/mp4" = "org.gnome.eog.desktop";
    "video/mkv" = "org.gnome.eog.desktop";
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
home.sessionPath = [
  "$HOME/.myapps"
  "/bin"
  "$HOME/.local/bin"
  "$HOME/dotfiles"
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
  GTK_THEME = "rose-pine"; # WhiteSur-dark
  NIXPKGS_ALLOW_UNFREE=1;
  PYTHONPATH = "${pkgs.python312}/lib/python3.12/site-packages";
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
