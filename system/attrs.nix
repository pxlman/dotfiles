{ config, lib, pkgs, ... }:

with lib;

let
  username = "pxlman";
in {
  options.cfg = {
    username = mkOption {
      type = types.str;
      default = username;
      description = "Primary user account name";
    };
    home = mkOption {
      type = types.str;
      default = "/home/${username}";
      description = "Primary user home directory";
    };
    hostname = mkOption {
      type = types.str;
      default = "Ahmed";
      description = "System hostname";
    };
    userExtraGroups = mkOption {
      type = types.listOf types.str;
      default = [ "wheel" "uinput" "networkmanager" "video" "audio" "input" "vboxusers" ];
      description = "Extra groups for the primary user";
    };

    timeZone = mkOption {
      type = types.str;
      default = "Africa/Cairo";
      description = "System time zone";
    };
    locale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      description = "System default locale";
    };
    extraLocale = mkOption {
      type = types.attrsOf types.str;
      default = { LC_PAPER = "ar_EG.utf8"; };
      description = "Extra locale settings";
    };

    xkb = {
      layout = mkOption {
        type = types.str;
        default = "us,ara";
        description = "X11 keyboard layout";
      };
      options = mkOption {
        type = types.str;
        default = "grp:alt_space_toggle";
        description = "X11 keyboard options";
      };
    };

    firewall = {
      tcpPorts = mkOption {
        type = types.listOf types.port;
        default = [
          22000 8384 7777 7778 9999 8888 8080 8081 8000
          80 443 12345 21 53317 69 2049 111 20048 55435
        ];
        description = "Allowed TCP ports";
      };
      udpPorts = mkOption {
        type = types.listOf types.port;
        default = [
          22000 21027 69 2049 111 20048 55435
        ];
        description = "Allowed UDP ports";
      };
    };

    userPackages = mkOption {
      type = types.attrsOf (types.listOf types.package);
      default = {
        terminal = with pkgs; [
          zsh neovim stow pamixer tree fribidi helix eza
        ];
        wm = with pkgs; [
          bspwm sxhkd polybarFull dmenu picom
          networkmanagerapplet catppuccin-gtk
        ];
        apps = with pkgs; [
          alacritty
        ];
        drivers = with pkgs; [
          mesa
          vulkan-headers vulkan-tools vulkan-loader vulkan-utility-libraries
          xorg.xf86videoamdgpu xorg.xf86inputjoystick xorg.xf86videosisusb
          linuxKernel.packages.linux_6_6.v4l2loopback
          glib glibc libinput
        ];
        dev = with pkgs; [
          man-pages man-pages-posix
          bat-extras.batman bat-extras.batpipe
          nlohmann_json fuse fusePackages.fuse_2 ffmpeg
          gtk2 gtk3 gtk4 yaml-cpp
        ];
        gaming = with pkgs; [
          (wineWowPackages.stable.override {
            vulkanSupport = true;
            waylandSupport = true;
          })
          winetricks vkd3d
        ];
        x11 = with pkgs; [
          xorg.libX11 xorg.xorgproto xorg.libxcb xorg.libXinerama
          xorg.xinit xorg.xinput xorg.xev xorg.xcursorthemes xorg.xhost
          usbutils woeusb
          libsForQt5.qt5.qtbase libsForQt5.qt5.qtx11extras
          kdePackages.xdg-desktop-portal-kde
          xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland
          usbrelay ntfs3g libelf elfutils
          adi1090x-plymouth-themes
        ];
        hacking = with pkgs; [
          httpx
        ];
      };
      description = "User package sets organized by category";
    };

    systemPackages = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        swayosd tldr clinfo fusuma lsof base16-schemes
        home-manager dust gnutls file neovim fuse3 wget
        hyprpaper waybar rofi grub2 git inetutils mpc
        gcc gcc_debug go syncthing
        p7zip unzip unrar exiv2 bc
      ];
      description = "System-wide packages";
    };
  };
}
