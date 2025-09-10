let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) lib fetchFromGitHub stdenv pkg-config wayland wayland-protocols wayland-scanner;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "pwndbg";
  version = "2025.05.30";
  src = fetchFromGitHub rec {
    owner = "pwndbg";
    repo = "pwndbg";
    rev = "${finalAttrs.version}";
    sha256 = "sha256-Y8tERNTdMrRj07d3vTN2LvEUsZUhJ4lEEqWMzF5QohU="; # Replace with actual hash
  };

  # Build toolchain and dependencies
  strictDeps = true;
  nativeBuildInputs = [pkg-config];
  buildInputs = [
  ];

  # Build phases
  # Ensure that the Makefile has the correct directory with the Wayland protocols
  preBuild = ''
  '';

  # makeFlags = ["release"];
  installPhase = ''
    runHook preInstall

    $src/setup.sh

    runHook postInstall
  '';

  # Package information
  meta = {
    description = "An extensible GDB plugin for exploit development.";
    homepage = "https://pwndbg.re/pwndbg/latest/contributing/setup-pwndbg-dev/#installing-pwndbg-from-source";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [voxi0];
    mainProgram = "pwndbg";
    platforms = lib.platforms.linux;
  };
})
