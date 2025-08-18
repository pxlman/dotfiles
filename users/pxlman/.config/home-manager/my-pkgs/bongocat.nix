let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) lib fetchFromGitHub stdenv pkg-config wayland wayland-protocols wayland-scanner;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "wayland-bongocat";
  version = "1.2.4";
  src = fetchFromGitHub rec {
    owner = "saatvik333";
    repo = "wayland-bongocat";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-ek9sVzofW0sWJBCeudykdirDkF04YdR1gAcpeWqgQAQ="; # Replace with actual hash
  };

  # Build toolchain and dependencies
  strictDeps = true;
  nativeBuildInputs = [pkg-config wayland-scanner];
  buildInputs = [
    wayland
    wayland-protocols
    wayland-scanner
  ];

  # Build phases
  # Ensure that the Makefile has the correct directory with the Wayland protocols
  preBuild = ''
    export WAYLAND_PROTOCOLS_DIR="${wayland-protocols}/share/wayland-protocols"
  '';

  makeFlags = ["release"];
  installPhase = ''
    runHook preInstall

    # Install binaries
    install -Dm755 build/bongocat $out/bin/${finalAttrs.meta.mainProgram}
    install -Dm755 scripts/find_input_devices.sh $out/bin/bongocat-find-devices

    runHook postInstall
  '';

  # Package information
  meta = {
    description = "Delightful Wayland overlay that displays an animated bongo cat reacting to your keyboard input!";
    homepage = "https://github.com/saatvik333/wayland-bongocat";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [voxi0];
    mainProgram = "bongocat";
    platforms = lib.platforms.linux;
  };
})
