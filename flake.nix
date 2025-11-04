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
        burpsuitepro.url ="github:xiv3r/Burpsuite-Professional/9689f4ab41bddc9f7bce0f95ecf68e2c2a1e065d";
        pwndbg.url = "github:pwndbg/pwndbg/2b928632dd437c668dea11a93190dd55a9ddd822";
        nixvim.url = "github:nix-community/nixvim";
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
        (final: prev: 
            {
                burpsuitepro = (inputs.burpsuitepro.packages.${system}.default);
                pwndbg = (inputs.pwndbg.packages.${system}.default);
            }
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
                modules = [ ./users/pxlman/home/home.nix inputs.nixvim.homeModules.nixvim ];
                extraSpecialArgs = { 
                    inherit unstable inputs;
                    oldpkgs = import inputs.oldnixpkgs { inherit system;};
                };
            };
        };

    };
}
