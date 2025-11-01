{config, lib, pkgs, ...}:

{
  imports = 
    [
      ./hardware-configuration.nix
      ./services/display-manager.nix
      ./services/window-manager.nix
      ./services/networking.nix
      ./services/firewall.nix
      ./services/ssh.nix
      ./services/docker.nix
      ./services/fonts.nix
      ./users/users.nix
      ./system/packages.nix
      ./system/locale.nix
      ./system/timezone.nix
      ./system/virtualization.nix
    ];

  boot.loader.grub.device = "/dev/sda"; # Adjust as necessary

  networking.hostName = "Ahmed-PC"; 

  services.openssh.enable = true;

  users.users.ahmed = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    password = lib.mkPassword "yourpassword"; 
  };

  system.stateVersion = "25.05"; 
}
