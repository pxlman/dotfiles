let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) stdenv cmake git makeWrapper lib fetchgit mesa imagemagick;
  oldpkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/5be55538137a57aa946e56a04c2795668dbdbe21.tar.gz";
    # Example: url = "https://github.com/NixOS/nixpkgs/archive/73e050c2ecac08b33f7ea0e2ec8992bd938f0197.tar.gz";
    # (That's a commit from 2024-04)
  }) {};
  inherit (oldpkgs) kdePackages;
in
stdenv.mkDerivation {
  pname = "quran-companion";
  version = "1.3.3";

  # The source (fetch from git)
  src = fetchgit {
    url = "https://github.com/0xzer0x/quran-companion.git";
    rev = "18077b3091e55a8a58ed331e949a5e576819a9eb"; # Lock to this commit
    sha256 =
      "sha256-8Oo/mBZV+fXe6Gw7eb4jX3i7aGksvglA8WoG0HCBEd8="; # Locked sha256 for this commit
    fetchSubmodules = true;
    deepClone = false;
  };

  nativeBuildInputs = [ cmake git makeWrapper kdePackages.wrapQtAppsHook imagemagick ];

  buildInputs = [
    mesa
    kdePackages.qtbase
    kdePackages.qtimageformats
    kdePackages.qtsvg
    kdePackages.qtmultimedia
    kdePackages.qttools
    pkgs.glib
    pkgs.gsettings-desktop-schemas
  ];

  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];

  # We define a build directory to persist the CMake cache
  buildPhase = ''
    mkdir -p $out/build

    # Only re-run CMake configuration if the source or dependencies change
    cmake $src -B$out/build -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_BUILD_TYPE=Release
    cmake --build $out/build --target install
  '';

  installPhase = ''
        runHook preInstall

        # Install desktop entry
        mkdir -p $out/share/applications
        cat > $out/share/applications/quran-companion.desktop <<EOF
    [Desktop Entry]
    Version=1.0
    Name=Quran Companion
    Comment=A modern Quran reading and research tool
    Exec=$out/bin/quran-companion
    Icon=quran-companion
    Terminal=false
    Type=Application
    Categories=Education;Utility;
    EOF

        # Convert .ico icon if available
        if [ -f "$src/resources/logo.ico" ]; then
          mkdir -p $out/share/icons/hicolor/128x128/apps
          convert "$src/resources/logo.ico[2]" "$out/share/icons/hicolor/128x128/apps/quran-companion.png"
        fi

        runHook postInstall
  '';

  meta = with lib; {
    description = "Quran Companion - A modern Quran reading and research tool";
    homepage = "https://github.com/0xzer0x/quran-companion  ";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
