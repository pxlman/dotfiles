{
  description = "My First Flake Ever";
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager.url = "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
#nur.url = "github:nix-community/NUR";
  };
  outputs = inputs@{self, nixpkgs,nixpkgs-unstable,home-manager, ...}:
    let 
    system = "x86_64-linux";
  pkgs = import nixpkgs {inherit system;};
  in {
    nixosConfigurations.Ahmed = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
# Overlays-module makes "pkgs.unstable" available in configuration.nix
      {
        nixpkgs.overlays = [
          (final: prev: {
#unstable = nixpkgs-unstable.legacyPackages.${prev.system};
# use this variant if unfree packages are needed:
           unstable = import nixpkgs-unstable {
           inherit system;
           config.allowUnfree = true;
           };
           })
        ];
      }
      ./configuration.nix
        inputs.stylix.nixosModules.stylix
#home-manager.nixosModules.home-manager {
#	home-manager.useGlobalPkgs = true;
#	home-manager.useUserPackages = true;
#	home-manager.users.pxlman = import ./../users/pxlman/.config/home-manager/home.nix ;
#	home-manager.backupFileExtension = "old";
#}
        ];
    };

  };
}
