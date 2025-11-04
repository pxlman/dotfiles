{ pkgs, unstable, oldpkgs, inputs, ... }: 
  let 
  fakeVar = 0;
    # burpsuitepro = (builtins.getFlake "github:xiv3r/Burpsuite-Professional/9689f4ab41bddc9f7bce0f95ecf68e2c2a1e065d").packages.${pkgs.system}.default;
    # pwndbg = (builtins.getFlake "github:pwndbg/pwndbg/2b928632dd437c668dea11a93190dd55a9ddd822").packages.${pkgs.system}.default;
  in

{
    imports = [
      ../../modules/default.nix
    ]; 
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
  evtest
  conky # Desktop Widgets
  # rofi
  rofi-wayland
  # unstable.wayland-bongocat
  bongocat # For the cute cat
  nsalah # For the prayer times
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
  quran
  surf
  telegram-desktop
  hexchat
  firefox # for burp suite
  zathura # pdf reader
  # okular # pdf reader
  kdePackages.okular
  pdfmixtool # pdf editor (merging splitting generating booklets)
  qbittorrent # torrent
  # zoom-us
  audacity
  unstable.discord
  openboard
  zeal
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
  # clickup
  # code-cursor
  # netbeans
  gparted
  libreoffice
  xournalpp
  weylus
  # beekeeper-studio
  # rhythmbox
  dpkg
  pkg-config
### Gaming
  zeroad # 0ad
  gamepad-tool # Testing gamepad
  unstable.legendary-gl # CLI tool for epic games 
  # rare # legendary GUI client
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
  ascii # show ascii table
  ];

# xresources.extraConfig = ''
#   Xft.antialias: true
#   Xft.hinting: true
#   Xft.hintstyle: hintfull
#   Xft.rgba: rgb
#   Xft.lcdfilter: lcddefault
#   Xft.dpi: 130
# '';
home.file = {
    ".config" = {
        enable = true;
        source = ../dotfiles/.config;
        recursive = true; # Link all the file leaves inside dotfiles/.config in ~/.config
        force = true; # Overwrite existing files
    };
    ".config/home-manager" = {
        enable = true;
        source = ../home;
        recursive = true;
        force = true;
    };
    ".conky" = {
        enable = true;
        source = ../dotfiles/.conky;
        recursive = true;
    };
    ".xinitrc" = {
        enable = true;
        source = ../dotfiles/.xinitrc;
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
  EDITOR = "nvim";
  VISUAL = "nvim";
};
xdg.userDirs = {
  enable = true;
  createDirectories = true;
};
# programs.nixvim = {
#   enable = false;
#
#   plugins = {
#     telescope.enable = true;
#     treesitter.enable = true;
#     web-devicons.enable = false;
#     cmp.enable = true;
#     lsp = {
#       enable = true;
#       servers = {
#         pyright.enable = true;
#         gopls.enable = true;
#         nil_ls.enable = true;
#       };
#     };
#   };
#
#   colorscheme = "tokyonight";
#   opts = {
#     number = true;
#     relativenumber = true;
#     tabstop = 4;
#   };
# };
}
