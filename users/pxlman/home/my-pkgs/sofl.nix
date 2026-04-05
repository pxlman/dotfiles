# { pkgs ? import <nixpkgs> {} }:
{pkgs, ...}:
let
    py-env = pkgs.buildEnv {
    name = "py-env";
    paths = with pkgs; [
        python313 
        python313Packages.pygobject3
    ];
    };
in
pkgs.stdenv.mkDerivation {
  pname = "sofl";
  version = "0.0.3.5a";

  src = pkgs.fetchurl {
    url = "https://github.com/BadKiko/steam-online-fix-launcher/releases/download/v0.0.3.5a/sofl-0.0.3.5a-1-x86_64.pkg.tar.zst";
    sha256 = "sha256-NLg+BMTg2ymi5CxlU/sVGOPp9v3/8mgHzueFFNnrZAc=";
  };

    nativeBuildInputs = [
    pkgs.zstd
    py-env
    pkgs.wrapGAppsHook3
  ];

  buildInputs = [
    py-env
    pkgs.gobject-introspection
    pkgs.gtk3
  ];


  unpackPhase = ''
    # Nix won't auto-detect .zst for tar, so we do it manually
    mkdir source
    cd source
    zstd -d < $src | tar xvf -
  '';

    # Fix the shebangs
  postPatch = ''
    patchShebangs .
  '';


  installPhase = ''
    mkdir -p $out
    cp -r usr/* $out/
    # cp -r * $out/
  '';
}

