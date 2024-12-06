{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Set up the development environment with dependencies

  buildInputs = [
    # Python interpreter and modules
    pkgs.python312
    pkgs.python312Packages.numpy  # Add any required Python modules
    pkgs.python312Packages.sympy  # Add any required Python modules

    # C++ development tools and libraries
    pkgs.gcc
    pkgs.cmake
    pkgs.boost

    # Shell
    pkgs.zsh
  ];
    # Set the shell to zsh
  # SHELL = "${pkgs.zsh}/bin/zsh";

  # Optional: set environment variables
  PYTHONPATH = "${pkgs.python312}/lib/python3.12/site-packages";

  # automatically started commands after entering the shell
  shellHook = ''
    echo ""
    echo "########################################################################"
    echo "########################################################################"
    echo ""
    echo "              Entering the development environment"
    echo "                         Hi handsome :)"
    echo ""
    echo "########################################################################"
    echo "########################################################################"
    echo ""
    # Change the shell to zsh
    export PS1="[\[\033[1;32m\]\u\[\033[0m\]@\[\033[1;34m\]\h\[\033[0m\] \[\033[1;36m\]\w\[\033[0m\]]\[\033[1;31m\]\$\[\033[0m\] "
  '';
}