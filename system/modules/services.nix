{config, lib, pkgs, ...}:

{

	services.udisks2.enable = true;
# Openning dbus
		services.dbus.enable = true;
# Enable the X11 windowing system.
	services.xserver.enable = true;
	services.xserver.videoDrivers = [ "amdgpu" ];
	services.xserver.windowManager.bspwm.enable = true;

# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us,ara";
		variant = "";
		options = "grp:alt_space_toggle";
	};
# Changing the dpi to make things bigger
	services.xserver.dpi = 130; # Default is null
# Enable the GDM display manager
	services.xserver.displayManager.startx.enable = true; # Adding xinitrc to the
	services.xserver.displayManager.lightdm.enable = false;
	services.xserver.displayManager.lightdm.background = lib.mkForce ./files/lightdm-wallpaper;
	services.displayManager.ly = {
		enable = true;
		settings = {
			# animation = "doom";
			# bigclock = "en";
			# clock = "%c";
			xinitrc = "~/.xinitrc";
			asterisk = "+";
		};
	};

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
	services.libinput.touchpad.naturalScrolling = true;
# Enable CUPS to print documents.
	services.printing.enable = true;
	services.printing.drivers = with pkgs;[
# samsung-unified-linux-driver
		samsung-unified-linux-driver_1_00_37
# samsung-unified-linux-driver_1_00_36
# splix
	];
	services.logind = {
		lidSwitch = "suspend";
		lidSwitchExternalPower = "suspend";
		extraConfig = ''
			
		'';
	};

# Enable ssh service
#services.sshd.enable = true;
## Enable sound.
	services.pulseaudio.enable = false; # Enables Audio Throught pulseaudio package
## Or use
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;  # provides a PulseAudio server replacement
		wireplumber.enable = true;
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
	services.xserver.desktopManager.retroarch.enable = true;
	services.xserver.desktopManager.retroarch.package = (
        pkgs.retroarch.withCores (cores: with cores; [
              genesis-plus-gx # Sega MS/GG/MD/CD
              snes9x # snes
              snes9x2010 # snes improved
              ppsspp # psp
              pcsx2 # PS 2
              pcsx-rearmed # PS
              play # PS 2
              sameboy # gameboy
              blastem # sega
              swanstation # PS
              beetle-saturn # Sega saturn
              beetle-wswan #
              beetle-psx-hw # PS
              dosbox-pure # DOSBOX with auto mapping
              dolphin # wii
        ]));
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
	services.tlp = {
		enable = true;
		settings = {
			#TLP_DEFAULT_MODE = "BAT";
			CPU_SCALING_GOVERNOR_ON_AC = "performance";
			CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

			CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
			CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

			CPU_BOOST_ON_AC=1;
			CPU_BOOST_ON_BAT=0;

			CPU_MIN_PERF_ON_AC = 0;
			CPU_MAX_PERF_ON_AC = 100;
			CPU_MIN_PERF_ON_BAT = 0;
			CPU_MAX_PERF_ON_BAT = 30;

#Optional helps save long term battery health
			START_CHARGE_THRESH_BAT0 = 60; # 40 and bellow it starts to charge
			STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
		};
	};
}
