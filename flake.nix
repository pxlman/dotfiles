{
    description = "Nix flake for pxlman";
    inputs = {
        nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "github:NixOs/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix.url = "github:danth/stylix";
        oldnixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/5be55538137a57aa946e56a04c2795668dbdbe21.tar.gz";
        mypkgs.url = "path:./users/pxlman/home/my-pkgs";
    };
    outputs = inputs@{self, nixpkgs,nixpkgs-unstable,home-manager, mypkgs, ...}:
        let 
        system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
        config = {
            android_sdk.accept_license = true;
            allowUnfree = nixpkgs.lib.mkDefault true;
        };
        overlays = pkgsoverlays;
    };
    pkgsoverlays = [
        (final: prev:
            (mypkgs.packages.${system})
        )
    ];
    unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = nixpkgs-unstable.lib.mkDefault true;
    };
    in {
        nixosConfigurations.Ahmed = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit unstable inputs; };
            modules = [
                ./system/configuration.nix
                    ./system/hardware-configuration.nix
                    inputs.stylix.nixosModules.stylix
            ];
        };
# Integrate Home Manager
        homeConfigurations = {
            pxlman = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./users/pxlman/home/home.nix ];
                extraSpecialArgs = { 
                    inherit unstable inputs;
                    oldpkgs = import inputs.oldnixpkgs { inherit system;};
                };
            };
        };

    };
}
