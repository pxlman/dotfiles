{
    description = "My packages";

    inputs.nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.05";
    inputs.oldnixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/5be55538137a57aa946e56a04c2795668dbdbe21.tar.gz";

    outputs = { self, nixpkgs, oldnixpkgs }: let
        system = "x86_64-linux";
    in {
        packages.${system} =
            let 
            pkgs = import nixpkgs { inherit system; };
            oldpkgs = import oldnixpkgs { inherit system; };
        in {
            quran = pkgs.callPackage ./quran.nix {inherit pkgs oldpkgs; };   
            xfox = pkgs.callPackage ./xfox.nix {inherit pkgs; };
            bongocat = pkgs.callPackage ./bongocat.nix {inherit pkgs; };
            nsalah = pkgs.callPackage ./nsalah.nix {inherit pkgs; };
        };
    };
}

