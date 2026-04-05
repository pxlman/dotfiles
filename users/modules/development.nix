{ lib, config,unstable, pkgs, ... }:
let
withDev = pkg: [ pkg pkg.dev ];
mycenv = pkgs.buildEnv {
    name = "my-c-env";
    paths = with pkgs; [
        gdb
            glib.dev
            glibc.dev
            gtk3.dev
            gtk4.dev
            zlib.dev
            ncurses.dev
            libgcrypt.dev
            libevent.dev
            curl.dev
            jsoncpp.dev
            imgui
            freetype
            ffmpeg-full # for video encoding and decoding in some tools like ghidra 
            ffmpeg-full.dev
            cmake
            gnumake
            pkg-config
            hwloc
            numactl
            # mpi.dev
            boost.dev
            boost.dev
            # gmp.dev
            # gmpxx.dev
    ];
};
android = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "33" ]; # Choose platform version you need
        buildToolsVersions = [ "33.0.2" ];
    abiVersions = [ "x86_64" ]; # For emulator
};
in
{
    options = {
        development = {
            enable = lib.mkEnableOption "Enable development environment configuration.";
        };
    };
    config = lib.mkIf config.development.enable {
        nixpkgs.config.android_sdk.accept_license = true; # Accept android sdk license

            home.packages = with pkgs; [
### Formatting and Nix Tools
            jsonfmt
                nixpkgs-fmt
                ripgrep # for searching in files in neovim

### Android development
                android-studio #.overrideAttrs (old: { unpackPhase = "true"; })  # disable the default unpacking
                android.androidsdk
                android.platform-tools
# android.cmdline-tools
# unstable.gradle
                unstable.android-tools

### Database Tools
                sqlcmd

### Web Development and JS Ecosystem
                yarn
                nodejs_24
                postman

### Editors and IDEs
                unstable.vscode
                sublime3
# jetbrains.phpstorm
# jetbrains.clion
# jetbrains.pycharm-professional
# jetbrains.idea-ultimate

### Virtualization and Containers
                docker

### Qt Development
                qtcreator # To make qt gui programs
# libsForQt5.full deprecated
                libsForQt5.qtutilities
                libsForQt5.qtmultimedia
                libsForQt5.qtx11extras
# libsForQt5.qtwebsockets
# libsForQt5.qtwebchannel
                libsForQt5.qtstyleplugins
                libsForQt5.qt5ct
                libsForQt5.qt5.qtxmlpatterns
# libsForQt5.qt5.qtwebview
                libsForQt5.qt5.qtwayland
                libsForQt5.qt5.qttools

### PHP Development
                php84Packages.composer
                php84Extensions.sqlite3
                php84Extensions.mysqli
                php84Extensions.curl
                php84

### Systems, Networking, and HPC
                tftp-hpa # for tftp server and client (adv-os)
                mpi # for parallel computing in c++ (hpc)
                mpi.dev
                hwloc
                numactl

### Logic Programming and AI
# swi-prolog # Prolog interpreter (ai)
                swi-prolog-gui # Prolog interpreter (ai)

### C++ Development Tools and Libraries
                # mycenv
                gdb
                cmake
                gnumake
                pkg-config
                boost
                boost.dev
                glib.dev
                glibc.dev
                gtk3.dev
                gtk4.dev
                zlib.dev
                ncurses.dev
                libgcrypt.dev
                libevent.dev
                curl.dev
                jsoncpp.dev
                gtk3.dev
                gtk-layer-shell
                gtk-layer-shell.dev
                imgui
                freetype
                ffmpeg-full # for video encoding and decoding in some tools like ghidra 
                ffmpeg-full.dev

# GMP Bundle
                (buildEnv {
                 name = "gmp-with-cxx";
                 paths = with pkgs; [
                 gmp # C++ library for arbitrary precision arithmetic
                 gmp.dev
                 gmpxx # C++ library for arbitrary precision arithmetic (C++ interface)
                 gmpxx.dev 
                 ];
                 })

### Hardware Description Languages
        iverilog # Verilog simulator (arch)

### Python Interpreter and Modules
            (python312.withPackages (python-pkgs: with python-pkgs; [
                                     ipython
                                     pwntools
                                     requests
                                     sympy
                                     unicurses
                                     evdev
                                     python-uinput
                                     pip
                                     tkinter
                                     pillow
                                     ttkbootstrap
            ]))
            ];
        home.sessionVariables = {
            _JAVA_AWT_WM_NONREPARENTING=1;
            PYTHONPATH = "${pkgs.python312}/lib/python3.12/site-packages";
            ANDROID_HOME = "$HOME/Android/Sdk";
            C_INCLUDE_PATH = "${mycenv}/include:$HOME/.nix-profile/include";
            # CPLUS_INCLUDE_PATH = "${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}:${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}/${pkgs.stdenv.hostPlatform.linuxArch}-unknown-linux-gnu:${mycenv}/include:$HOME/.nix-profile/include";
            CPLUS_INCLUDE_PATH = "$HOME/.nix-profile/include";
            NIX_LD_LIBRARY_PATH = "$NIX_LD_LIBRARY_PATH:$HOME/.nix-profile/lib:/run/current-system/sw/lib";
# C_INCLUDE_PATH = "${pkgs.glibc.dev}/include";
# CPLUS_INCLUDE_PATH = "${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}:${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}/${pkgs.stdenv.hostPlatform.linuxArch}-unknown-linux-gnu:${pkgs.glibc.dev}/include";
        };
        programs.tmux.enable = true;
    };
}
