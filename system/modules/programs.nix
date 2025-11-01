{config, lib, pkgs, ...}:
{
	# programs.hyprland.enable = true;
	programs.obs-studio = {
		enable = true;
		plugins = with pkgs.obs-studio-plugins; [
			wlrobs
			obs-backgroundremoval
			obs-pipewire-audio-capture
		];
		enableVirtualCamera = true; # Enable virtual camera
	};

	programs.hyprland = {
		enable = true;
		package = pkgs.hyprland;
		portalPackage = pkgs.xdg-desktop-portal-hyprland;
		xwayland.enable = true;
	};
	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
	};

	# programs.waybar.enable = true;
	programs.xwayland.enable = true;
	programs.system-config-printer.enable = true;
# Enabling ZSH as a shell
	programs.zsh.enable = true;
# Utils
	programs.localsend.enable = true; # Sharing between other local devices
# Gaming
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
	};
	programs.gamemode = {
		enable = true;
	};
# To make executable ELF files and games work
# "minimum" amount of libraries needed for most games to run without steam-run
	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
# common requirement for several games
			stdenv.cc.cc.lib
# from https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/games/steam/fhsenv.nix#L72-L79
			xorg.libXcomposite
			xorg.libXtst
			xorg.libXrandr
			xorg.libXext
			xorg.libX11
			xorg.libXfixes
			gcc
			libGL
			libva
# from https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/games/steam/fhsenv.nix#L124-L136
			fontconfig
			freetype
			fuse3
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
			gvfs
			];
	documentation = {
		enable = true;
		man.enable = true;
		man.man-db.enable = false;
		man.mandoc.enable = true;
		dev.enable = true;
	};
	virtualisation={
		docker = {
			enable = true;
			enableOnBoot = false;
			daemon.settings = {
				data-root = "/home/docker";
			};
			storageDriver = "overlay2";
		};
		virtualbox= {
			host.enable = true;
			# host.enableExtensionPack = true;
			guest.enable = true;
			guest.clipboard = true;
			guest.dragAndDrop = true;
		};
	};
}
