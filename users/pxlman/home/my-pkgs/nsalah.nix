{pkgs, ...}:
let
  # pkgs = import <nixpkgs> {};
  inherit (pkgs) lib fetchFromGitHub stdenv pkg-config wayland wayland-protocols wayland-scanner;
  python = pkgs.python312;
  pyPkgs = python.pkgs;

  salat = pyPkgs.buildPythonPackage rec {
    pname = "salat";
    version = "1.1.0";
    pyproject = true;
    src = pyPkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-vJxpSDzPGs8TA179TXNyJW3A9CWPfnFub7uU55UjFB8=";
    };

    propagatedBuildInputs = with pyPkgs; [ setuptools ];
  };
in
pkgs.python3Packages.buildPythonApplication {
  pname = "nsalah";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "pxlman";
    repo = "next-salah";
    rev = "c9192553eeac5a892e8543b5ad7196012cb84492"; # or a specific commit hash for reproducibility
    sha256 = "sha256-qiDlHlf7GO8SUjq/n6Px7iu++G5n/5QntgpLKBxpQkU="; # fill this in
  };

  propagatedBuildInputs = with pkgs.python312Packages; [
    setuptools
    salat
  ];
#   installPhase = ''
#   runHook preInstall
#   mkdir -p $out/bin
#   cp main.py $out/bin/nsalah
#   chmod +x $out/bin/nsalah
#   runHook postInstall
# '';


  meta = with pkgs.lib; {
    description = "CLI to get Islamic prayer times";
    homepage = "https://github.com/pxlman/next-salah";
    license = licenses.mit;
    maintainers = [ ];
  };
}
