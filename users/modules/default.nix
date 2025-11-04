{lib, config, pkgs, ... }:
{
    imports = [
        ./wm.nix
        ./services.nix
        ./programs.nix
        ./shell.nix
        # ./packages.nix
        # ./gaming.nix
        ./hacking.nix
        ./development.nix
    ];
}
