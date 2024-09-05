{ config,lib, pkgs, unstable, ... }: {
nixpkgs.config = {allowUnFree = true;};
home.stateVersion = "24.05";
home.username = "pxlman";
home.homeDirectory = "/home/pxlman";
home.packages = with pkgs; [
### THEMES and Styles
  dconf # I Don't know but gtk needs it
  lxappearance # Themes and Fonts manager
  font-manager # Font Manager
  copyq # Clipboard manager
  bibata-cursors # My cursor theme
  cinnamon.mint-themes # Temporary theme
  rose-pine-gtk-theme
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
  pulseaudio # audio driver
  pamixer # Modifing audio from terminal
  dunst # For notifications
  pavucontrol # modifying audio in GUI
  brightnessctl # For brightness
  redshift # Eye comfort
  miniserve # Sharing between local devices
  syncthing # Syncing folders between phone and laptop
  #mconnect
### Applications
  # cinnamon.nemo
  cinnamon.nemo-with-extensions
  brave
  zoom-us
  audacity
  discord
  #hexchat
  gimp
  # pkgs.unstable.discord unstable can be put in /etc/nixos/configuration.nix at the user section
  loupe # image viewer
  gnome.eog
  xorg.xf86videovboxvideo
  # gimp
  # anki-bin
  vlc
  zathura
  obsidian
  vscode
  gparted
  libreoffice
  xournalpp
  weylus
  postman
  rhythmbox
  obs-studio
### Gaming
  zeroad # 0ad
  #steam
  #mangohud
  #gamemode
  gamepad-tool # Testing gamepad
  legendary-gl # CLI tool for epic games 
  rare # legendary GUI client
  heroic # Epic games launcher
  superTux
  superTuxKart
  lutris # games launcher
  ### CLI Apps
  helix # Text editor command `hx`
  nettools # ithink for ip a
  eza # ls fork
  tmux
  docker
### Hacking
  exiftool
  nmap
  # ida-free
  # burpsuite
  # wireshark
  # tshark
  # tcpdump
  # termshark
  # john
  # wordlists
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
    name = "rose-pine"; # WhiteSur-dark
    package = pkgs.rose-pine-gtk-theme; # pkgs.whitesur-gtk-theme
  };
  font = {
    name = "Hack";
    package = pkgs.hack-font;
    size = 11;
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
services.syncthing.enable = true;
services.copyq = {
  enable = false;
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
    rc = "hx ~/.config/home-manager/home.nix";
    nrc = "sudo hx /etc/nixos/configuration.nix";
    gitdone="git add .; git commit -m '[+]'; git push; echo '[*] Files Saved'"; # git done
    home = "home-manager switch -f ~/dotfiles/users/pxlman/.config/home-manager/home.nix";
    switch = "sudo nixos-rebuild switch --verbose";

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
  "$HOME/.mycmds"
  "$HOME/.local/bin"
  "$HOME/dotfiles"
];
home.sessionVariables = {
  _JAVA_AWT_WM_NONREPARENTING=1;
  # this is to solve vulkan error in steam
  # U must make sure to install the needed vulkan drivers (these files r there)
  # packages(i think): vulkan-intel vulkan-headers vulkan-tools 
  LIBVA_DRIVER_NAME = "x86_64 VDPAU_DRIVER=va_gl";
  #LIBVA_DRIVERS_PATH="/usr/lib/dri/iHD_drv_video.so";
  #VK_DRIVER_FILES="/usr/share/vulkan/icd.d/intel_icd.i686.json:/usr/share/vulkan/icd.d/intel_icd.x86_64.json";
  GTK_THEME = "rose-pine"; # WhiteSur-dark
  NIXPKGS_ALLOW_UNFREE=1;
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
      mouse_left_click = "close_current";
    };
  };
};
xdg.userDirs = {
  enable = true;
  createDirectories = true;
};
}
