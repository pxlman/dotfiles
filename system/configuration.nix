# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ config, lib, pkgs,unstable, ... }:
{
	imports = [ 
           ./modules/default.nix
        ];

	environment.variables = {
		# PYTHONPATH = "${pkgs.python312}/lib/python3.12/site-packages";
	};
	environment.shellAliases = {
		man = "batman";
	};
	users.extraGroups.vboxusers.members = [ "pxlman" ];
# Define a user account. Don't forget to set a password with ‘passwd’.
	# nixpkgs.config.allowUnfree = true;
 #        nixpkgs.config.android_sdk.accept_license = true;

	users.users.pxlman = {
		shell = pkgs.zsh;
		isNormalUser = true;
		initialPassword = "1234";
		extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" "vboxusers" ]; # "vboxsf" 
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
				# obs-studio
# Drivers and services
## CPU and GPU
# intel-media-driver
# intel-gpu-tools
# intel-vaapi-driver
				mesa
				# amdvlk # AMD driver for vulkan
				vulkan-headers
				vulkan-tools
                                # pkgsi686Linux.vulkan-tools
				vulkan-loader
				vulkan-utility-libraries
				xorg.xf86videoamdgpu
# xorg.xf86inputlibinput
				xorg.xf86inputjoystick
				xorg.xf86videosisusb # For usb audio i think
				linuxKernel.packages.linux_6_6.v4l2loopback # make virtual camera work in obs studio
				# jdk24 # java deprecated
                                javaPackages.compiler.openjdk25
				glib
				glibc
				# libuinputplus # for developing a c++ app to forward gamepad buttons deprecated
                                libinput
				man-pages        # section 2, 3 (system calls, libc functions)
				man-pages-posix  # POSIX standard man pages
				bat-extras.batman
				bat-extras.batpipe
				nlohmann_json
				fuse
				fusePackages.fuse_2
				ffmpeg
				gtk2
				gtk3
				gtk4
				yaml-cpp
## Wine and gaming
                                # wineWowPackages.stable # Support both 32 and 64 bit windows apps
                                # Don't use full or with wayland support cause it makes the games very very slow and don't work well
				# wineWowPackages.waylandFull
                                (wineWowPackages.stable.override {
                                 vulkanSupport = true;
                                 waylandSupport = true; # unless you want wine-wayland
                                 })

				winetricks
				vkd3d
# X11 essentials
				xorg.libX11
				xorg.xorgproto # essential for c++ dev
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
				# kdePackages.xwaylandvideobridge deprecated
                                kdePackages.xdg-desktop-portal-kde
				xdg-desktop-portal
				xdg-desktop-portal-gtk
				xdg-desktop-portal-hyprland
				usbrelay # Tool to control USB HID relays
				ntfs3g
				libelf
				elfutils
				adi1090x-plymouth-themes # plymouth theme
# Hacking
				httpx
				];
	};
# Stylix For autostyling
	stylix = {
		enable = false;
		# image = "/etc/nixos/files/lightdm-wallpaper";
		base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
		# cursor = {
		# 	name = "Bibata-Modern-Classic";
		# 	package = pkgs.bibata-cursors;
		# 	size = 10;
		# };
		# polarity = "dark";
		# targets = {
		# 	gtk.enable = false; # This will make it only with others like: grub, lightdm, nixos-icons
		# 	gnome.enable = false;
		# 	nixos-icons.enable = false;
		# };
	};

	qt = { 
		enable = false;
		# platformTheme = "gtk3";
		# style = "gtk3";
	};

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		tldr # manuals
			clinfo # to make sure opencl is working
			fusuma # For touchpad configurations
			lsof # list open files
			base16-schemes
			home-manager
			dust # du command to get dirs size
			gnutls # some packages needs it in building 
			file
			neovim
			fuse3 # needed by some appimages
			wget
			hyprpaper # wallpapers for wayland
			waybar # bar for wayland
			rofi # App drawer for wayland
			grub2
			git
			inetutils # contain the `ftp` command
			mpc
			# clang
			gcc
			# gdb
			gcc_debug
			go
			rustup
			syncthing
			p7zip # 7z
			unzip
			unrar
			exiv2 # metadata for images
			bc # binary calculator
			];

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
	system.stateVersion = "25.11"; # Did you read the comment?

#	home-manager.users.pxlman = import ./home.nix;
}


