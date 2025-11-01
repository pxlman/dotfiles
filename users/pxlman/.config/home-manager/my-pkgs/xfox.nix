{pkgs, ...}:
let
  # pkgs = import <nixpkgs> {};
inherit (pkgs) fetchFromGitHub;
lib = pkgs.lib;
in
pkgs.python3Packages.buildPythonApplication rec {
  pname = "xfox";
  version = "1.0.0";
  pyproject = true;
  src = fetchFromGitHub rec {
    owner = "pxlman";
    repo = "xfox";
    rev = "v1.0.0";
    sha256 = "sha256-gbcJ02ZaPqiCo0VHnVOYzrWR00dQXgKavFTgP+6rS34=";
  };
  propagatedBuildInputs = with pkgs.python3Packages; [
    evdev
    setuptools
  ];
  postPatch = ''
    substituteInPlace setup.py --replace "evdev-binary" "evdev"
  '';
  meta = {
    description = "A tool to remap gamepads to act as a virtual xbox gamepad.";
    homepage = "https://github.com/pxlman/xfox";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      pxlman
    ];
  };

}
