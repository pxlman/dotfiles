with import <nixpkgs> {};

mkShell {
  buildInputs = [
    # Python with packages
    (python3.withPackages (ps: with ps; [
      pwntools
      requests
      yt-dlp
      ipython

    ]))
    
    zsh
    # C++ toolchain + libraries
    gcc
    cmake
    boost
    fmt

    # Extra tools
    gdb
    # Hacking tools

  ];
  shellHook = ''
    echo "Welcome to the CTF development environment!"
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh
    echo hi
    export PS1="(HACKIT) $PS1"
  '';
  initHook = ''
    echo "Setting up the environment..."
  '';
}
