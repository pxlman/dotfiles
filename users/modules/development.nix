{ lib, config,unstable, pkgs, ... }:
let
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
            libevent
            curl.dev
            jsoncpp.dev
            imgui
            freetype
            ffmpeg-full.dev # for video encoding and decoding in some tools like ghidra 
            cmake
            gnumake
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
### Android development
            pkgs.android-studio #.overrideAttrs (old: { unpackPhase = "true"; })  # disable the default unpacking
### Android development tools (without android-studio)
                android.androidsdk
                android.platform-tools
# android.cmdline-tools
# unstable.gradle
                unstable.android-tools
                sqlcmd
                yarn
                nixpkgs-fmt
# jdk17
                unstable.vscode
                docker
                postman
# jetbrains.phpstorm
# jetbrains.clion
# jetbrains.pycharm-professional
# jetbrains.idea-ultimate
                qtcreator # To make qt gui programs
                libsForQt5.full
                php84Packages.composer
                php84Extensions.sqlite3
                php84Extensions.mysqli
                php84Extensions.curl
                php84
                sublime3
## Python interpreter and modules
# python312
                (python312.withPackages (python-pkgs: with python-pkgs; [
                                         ipython
                                         pwntools
                                         requests
                                         sympy
                                         unicurses
                                         evdev
                                         python-uinput
                                         pip
                ]))
                iverilog # Verilog simulator
                nodejs_24
## C++ development tools and libraries
                mycenv
                gdb
                ripgrep # for searching in files in neovim
                ];
        home.sessionVariables = {
            _JAVA_AWT_WM_NONREPARENTING=1;
            PYTHONPATH = "${pkgs.python312}/lib/python3.12/site-packages";
            ANDROID_HOME = "$HOME/Android/Sdk";
            C_INCLUDE_PATH = "${mycenv}/include";
            CPLUS_INCLUDE_PATH = "${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}:${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}/${pkgs.stdenv.hostPlatform.linuxArch}-unknown-linux-gnu:${mycenv}/include";
# C_INCLUDE_PATH = "${pkgs.glibc.dev}/include";
# CPLUS_INCLUDE_PATH = "${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}:${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}/${pkgs.stdenv.hostPlatform.linuxArch}-unknown-linux-gnu:${pkgs.glibc.dev}/include";
        };
        programs.tmux.enable = true;
    };
}
