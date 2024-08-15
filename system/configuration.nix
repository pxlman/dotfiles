# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs,unstable, ... }:
#let
# add unstable channel declaratively
#  unstableTarball =
#    fetchTarball
#      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
#in
{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
	#		./home.nix
			#(import "${(builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz")}/nixos")
		];

# Use the GRUB 2 boot loader.
	boot.loader.grub.enable = true;
	boot.loader.grub.efiSupport = true;
	boot.loader.grub.device = "nodev";
	boot.supportedFilesystems = [ "ntfs" ];
# boot.loader.grub.efiInstallAsRemovable = true;
# Define on which hard drive you want to install Grub.
	#boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
	#boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	#boot.loader.efi.efiSysMountPoint = "/boot";
# Networking Hostname
	networking.hostName = "Ahmed"; # Define your hostname.
# Pick only one of the below networking options.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
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
#   console = {
#     font = "Lat2-Terminus16";
#     keyMap = "us";
#     useXkbConfig = true; # use xkb.options in tty.
#   };

# Enable the X11 windowing system.
	services.xserver.enable = true;
	services.xserver.windowManager.bspwm.enable = true;

# Configure keymap in X11
	services.xserver.xkb.layout = "us,ara";
	services.xserver.xkb.variant = "";
	services.xserver.xkb.options = "grp:alt_space_toggle";
# Enable the GDM display manager
	services.xserver.displayManager.startx.enable = true; # Adding xinitrc to the
	services.xserver.displayManager.lightdm.enable = true;
	#services.xserver.displayManager.lightdm.greeters.lomiri.enable = true;
# Add xinitrc to the sessions /usr/share/sessions
	services.xserver.displayManager.session = [
		{
			name = "xinitrc";
			manage = "desktop";
			start = "$HOME/.xinitrc";
		}
	];
# Enable touchpad support (enabled default in most desktopManager).
	services.libinput.enable = true;
	services.libinput.touchpad.naturalScrolling = false;
# Enable CUPS to print documents.
	services.printing.enable = true;
# Enable ssh service
	#services.sshd.enable = true;
# Hardware
## Enable sound.
	hardware.pulseaudio.enable = true; # Enables Audio Throught pulseaudio package
	hardware.bluetooth.enable = true; # Enables bluetooth
	hardware.bluetooth.powerOnBoot = true; # Powers on the bluetooth on boot up
	services.blueman.enable = true;
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
#programs.zsh = {
#	enable = true;
#	enableCompletion = true;
#	autosuggestions.enable = true;
#	syntaxHighlighting.enable = true;
#	ohMyZsh = {
#		enable = true;
#		theme = "tjkirch";
#		plugins = [
#			"eza"
#		];
#	};
#	enableLsColors = true;
#	shellAliases = {
#		t = "tree .";
#		docker = "sudo docker";
#		nrc = "nvim ~/.config/nvim";
#	};
#};
# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.pxlman = {
		shell = pkgs.zsh;
		isNormalUser = true;
		initialPassword = "1234";
		extraGroups = [ "wheel" "networkmanager" "video" "audio" ]; # Enable ‘sudo’ for the user.
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
				#discord
				#pkgs.unstable.discord
				#brave
				#cinnamon.nemo
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
                                jdk22
				## Wine and gaming
				wine
				winetricks
# X11 essentials
				xorg.libX11
				xorg.libX11.dev
				xorg.libxcb
				xorg.libXinerama
				xorg.xinit
				xorg.xinput
				xorg.xcursorthemes
				ntfs3g
# Grub themes
				#sleek-grub-theme
				];
	};

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		home-manager
		file
		neovim
		wget
		grub2
		git
		libgcc
		python3
		pipx
		nodejs_22
		gcc
		gcc_debug
		go
		rustup
	];

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

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
networking.firewall.enable = false;

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


