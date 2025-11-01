{config, lib, pkgs, ...}:
{
    imports = [
        ./boot.nix
        ./programs.nix
        ./services.nix
        ./misc.nix
        ./hardware.nix
        ./networking.nix
    ];
}
