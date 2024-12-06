# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ config, lib, pkgs,unstable, ... }:
#let
# add unstable channel declaratively
# unstableTarball =
#   fetchTarball
#     https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
#in
{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
#		./home.nix
#(import "${(builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz")}/nixos")
    ];

# Use the GRUB 2 boot loader.
  boot.loader = {
#boot.loader.systemd-boot.enable = true;
#boot.loader.efi.efiSysMountPoint = "/boot";
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };
  boot.tmp.cleanOnBoot = true; # clean /tmp dir on boot
  boot.supportedFilesystems = [ "ntfs" ];
# boot.loader.grub.efiInstallAsRemovable = true;
# Define on which hard drive you want to install Grub.
#boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
# Networking Hostname
  networking.hostName = "Ahmed"; # Define your hostname.
# Wifi enabling
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
# Openning dbus
    services.dbus.enable = true;
# Set your time zone.
  time.timeZone = "Africa/Cairo";
# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
#LC_ADDRESS = "ar_EG.utf8";
#LC_IDENTIFICATION = "ar_EG.utf8";
#LC_MEASUREMENT = "ar_EG.utf8";
#LC_MONETARY = "ar_EG.utf8";
#LC_NAME = "ar_EG.utf8";
#LC_NUMERIC = "ar_EG.utf8";
    LC_PAPER = "ar_EG.utf8";
#LC_TELEPHONE = "ar_EG.utf8";
#LC_TIME = "ar_EG.utf8";
  };
  virtualisation={
    docker = {
      enable = true;
      enableOnBoot = false;
      daemon.settings = {
        data-root = "/home/docker";
      };
    };
    virtualbox= {
      host.enable = true;
      guest.enable = true;
      guest.clipboard = true;
      guest.draganddrop = true;
    };
  };
  users.extraGroups.vboxusers.members = [ "pxlman" ];
#virtualisation.virtualbox.host.enableExtensionPack = true;
# Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.bspwm.enable = true;

# Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ara";
    variant = "";
    options = "grp:alt_space_toggle";
  };
# Enable the GDM display manager
  services.xserver.displayManager.startx.enable = true; # Adding xinitrc to the
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.background = lib.mkForce ./files/lightdm-wallpaper;
# Add xinitrc to the sessions /usr/share/sessions
  services.xserver.displayManager.session = [
  {
    name = "xinitrc";
    manage = "desktop";
    start = "$HOME/.xinitrc";
  }
  ];
  # Repeating rate characters in the Terminal
  # equivelant to: xset r rate 400 40
  services.xserver.autoRepeatDelay = 400;
  services.xserver.autoRepeatInterval = 30;

# Xrandr
  services.xserver.xrandrHeads = [
    "eDP-1"
      "HDMI-0"
      "HDMI-1"
  ];
# Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.libinput.touchpad.naturalScrolling = false;
# Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = with pkgs;[
# samsung-unified-linux-driver
    samsung-unified-linux-driver_1_00_37
# samsung-unified-linux-driver_1_00_36
# splix
  ];
  programs.system-config-printer.enable = true;

# Enable ssh service
#services.sshd.enable = true;
# Hardware
######
## Enable sound.
  hardware.pulseaudio.enable = true; # Enables Audio Throught pulseaudio package
## Or use
# services.pipewire = { # u must disable pulseaudio before use pipewire
#    enable = false;
#    alsa.enable = true;
#    alsa.support32Bit = true;
#    pulse.enable = true;
#    jack.enable = true;

#    wireplumber = {
#      enable = true;
#      package = pkgs.wireplumber;
#    };
#  };
######
    hardware.bluetooth = {
      enable = true; # Enables bluetooth
        package = pkgs.bluez.overrideAttrs (oldAttrs: {
            configureFlags = oldAttrs.configureFlags ++ [ "--enable-sixaxis" ];
            linkInRoot = true; # default = false
            }); # I think it will make controller work
      input = {
        General = {
          UserspaceHID=true;
          ClassicBondedOnly=false;
          LEAutoSecurity=false;
        };
      };
      powerOnBoot = true; # Powers on the bluetooth on boot up
    };
  services.blueman.enable = true;
# services.udev = {
# 	enable = false;
# 	extraRules = ''
# 		KERNEL=="js[0-9]", ENV{ID_BUS}=="bluetooth", 
# 		SUBSYSTEM=="input", MODE="0664", TAG+="uaccess",
# 		SYMLINK+="input/by-id/$env{ID_BUS}-controller-%n-joystick" KERNEL=="event[0-9]*",
# 		ENV{ID_BUS}=="bluetooth", SUBSYSTEM=="input", MODE="0664",
# 		TAG+="uaccess", SYMLINK+="input/by-id/$env{ID_BUS}-controller-%n-event-joystick"

# 		'';
# };
# Fonts
  fonts.packages = with pkgs;[
#jetbrains-mono
    nerdfonts
      font-awesome
#fira-code-nerdfont
#terminus-nerdfont
#hack-font
  ];
# Enabling ZSH as a shell
  programs.zsh.enable = true;
# Define a user account. Don't forget to set a password with ‘passwd’.
  nixpkgs.config.allowUnfree = true;
  users.users.pxlman = {
    shell = pkgs.zsh;
    isNormalUser = true;
    initialPassword = "1234";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" "vboxusers" "vboxsf" "kvm" ];
    packages = with pkgs; [
# Terminal packages
        zsh
        neovim
        stow
        pamixer
        tree
        fribidi
        helix
        eza
# Window manager and styles
        bspwm
        sxhkd
        polybarFull
        dmenu
        picom
        networkmanagerapplet
        catppuccin-gtk
# Applications
        alacritty
        obs-studio
# Drivers and services
## CPU and GPU
        intel-media-driver
        intel-gpu-tools
        intel-vaapi-driver
        mesa
        vulkan-headers
        vulkan-tools
        vulkan-loader
        vulkan-utility-libraries
        xorg.xf86videointel
        xorg.xf86videosisusb # For usb audio i think
        linuxKernel.packages.linux_6_6.v4l2loopback # make virtual camera work in obs studio
        jdk # java
        glib
        glibc
        # gtk2
        # gtk3
        # gtkmm2
        # gtkmm3
        # gtk4
        # gtkmm4
        ffmpeg
## Wine and gaming
        wineWowPackages.stable
        winetricks
        vkd3d
# X11 essentials
        xorg.libX11
# xorg.libX11.dev
        xorg.libxcb
        xorg.libXinerama
        xorg.xinit
        xorg.xinput
        xorg.xev
        xorg.xcursorthemes
        xorg.xhost
        usbutils # for `lsusb`
        woeusb # make a bootable windows usb from windows iso
        libsForQt5.qt5.qtbase
        libsForQt5.qt5.qtx11extras
        usbrelay # Tool to control USB HID relays
        ntfs3g
        libelf
        elfutils
        # Hacking
        httpx
        ];
  };
# Gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  services.xserver.desktopManager.retroarch.enable = true;
  programs.gamemode = {
    enable = true;
  };
  hardware.xpadneo.enable = true;
#hardware.xone.enable = true;
# Stylix For autostyling
  stylix = {
    enable = true;
    image = "/etc/nixos/files/lightdm-wallpaper";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 10;
    };
    polarity = "dark";
    targets = {
      gtk.enable = false; # This will make it only with others like: grub, lightdm, nixos-icons
        nixos-icons.enable = false;
    };
  };

  qt = { 
    enable = false;
    platformTheme = "gtk3";
    style = "gtk3";
  };

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
      tldr # manuals
      fusuma
      lsof # list open files
      base16-schemes
      home-manager
      file
      neovim
      wget
      grub2
      git
      libgcc
      inetutils # contain the `ftp` command
# cmake
      clang
      python312
      python312Packages.yt-dlp
      python312Packages.sympy
      python312Packages.requests
      pkgs.unstable.nodejs_22
      gcc
      gdb
      gcc_debug
      go
      rustup
      syncthing
      p7zip # 7z
      unzip
      exiv2 # metadata for images
      bc # binary calculator
# SDL2_mixer SDL multichannel audio mixer library
# jackmix # Matrix mixer for the jack-audio-connection-kit
# aumix # audio mixer for X and the console
      ];
# To make executable ELF files and games work
# "minimum" amount of libraries needed for most games to run without steam-run
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
# common requirement for several games
      stdenv.cc.cc.lib
      python312Packages.requests
# from https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/games/steam/fhsenv.nix#L72-L79
      xorg.libXcomposite
      xorg.libXtst
      xorg.libXrandr
      xorg.libXext
      xorg.libX11
      xorg.libXfixes
      libGL
      libva
# from https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/games/steam/fhsenv.nix#L124-L136
      fontconfig
      freetype
      xorg.libXt
      xorg.libXmu
      libogg
      libvorbis
      SDL
      SDL2_image
      glew110
      libdrm
      libidn
      tbb
      zlib
      libsForQt5.qt5.qtnetworkauth
      ];
  environment.variables = {
      PYTHONPATH = "${pkgs.python312}/lib/python3.12/site-packages";
  };

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
  services.openssh.enable = true;

# Syncthing
  services.syncthing ={
    enable = false; # just use this till it work with me
#systemctl --user enable --now syncthing.service
      user = "pxlman";
#	settings = {
#		folders = {
#			"/home/pxlman/Sync/Notes" = {
#				enable = true;
#				id = "obsidian-notes";
#				name = "Notes";
#				devices = [ "phone" ];
#			};
#		};
#		devices = {
#			"phone" = {
#				id = "YAGJ4X5-IEBXLL2-O6H6JJU-4Q7U26T-PZVQY6T-YDHJ43B-KSO45I2-MCZWBQO";
#				name = "phone";
#				autoAcceptFolders = true;
#			};
#		};
#	};
#overrideFolders = false;
#overrideDevices = false;
#guiAddress = "127.0.0.1:9191";
  };
# Open ports in the firewall.
# Or disable the firewall altogether.
  services.vsftpd = {
    enable = true;
    localUsers = true;
    writeEnable = true;
    userlist = [ "pxlman" "12345" ];
    userlistEnable = true;
    # userDbPath = /etc/vsftpd/userDB;
  };
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    22000
      8384
      7777
      7778
      9999
      8888
      8080
      80
      12345
      21
  ];
  networking.firewall.allowedUDPPorts = [ 
    22000
    21027
  ];
  # Battery config
    services.tlp = {
    enable = true;
    settings = {
      #TLP_DEFAULT_MODE = "BAT";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 40;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };


# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
# to actually do that.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 2d";
  };
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

#	home-manager.users.pxlman = import ./home.nix;
}


