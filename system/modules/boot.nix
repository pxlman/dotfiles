{config, lib, pkgs, ...}:

{
# Use the GRUB 2 boot loader.
	boot.loader = {
#boot.loader.systemd-boot.enable = true;
#boot.loader.efi.efiSysMountPoint = "/boot";
# boot.blacklistedKernelModules = [ "kvm" "kvm_amd" ];
# boot.loader.grub.efiInstallAsRemovable = true;
# Define on which hard drive you want to install Grub.
#boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
		efi.canTouchEfiVariables = true;
		grub = {
			enable = true;
			device = "nodev";
			efiSupport = true;
			useOSProber = true;
			extraConfig = "quiet splash";
			theme = pkgs.minimal-grub-theme;
		};
	};
	
	boot.plymouth = { 
		enable = true;
/*
for more themes check this of the adi: https://xdaforums.com/t/bootanimations-collection.3721978/
opimus - cuts - hexagon_dots - liquid - loader_2 - loading - mystic - jellyfish - splash
*/
            theme = lib.mkForce "owl"; 
            themePackages = [ pkgs.adi1090x-plymouth-themes ]; # This package takes 250MB if u wanted to reduce space used
            extraConfig = "
                [Daemon] 
                    ShowDelay=5";
	};
	boot.consoleLogLevel = 0;
	# boot.kernelParams = [ "quiet" "splash" "loglevel=0" "rd.udev.log_level=0" "plymouth.ignore-serial-consoles" ];
	boot.kernelParams = [ "quiet" "splash" "plymouth.ignore-serial-consoles" "kvm.enable_virt_at_load=0" ];
	boot.initrd.verbose = false;
	boot.initrd.kernelModules = [ "amdgpu" ];
	boot.tmp.cleanOnBoot = true; # clean /tmp dir on boot
	boot.supportedFilesystems = [ "ntfs" ];
	# To install the wifi adapter in ASUS vivobook 15
	boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ];
}
