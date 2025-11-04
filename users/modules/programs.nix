{config, lib, pkgs, ... }:
{
    options ={
        userSettings = {
            user = {
                name = lib.mkOption {
                    type = lib.types.str;
                    default = "fakeuser";
                    description = "Username for git config.";
                };
                email = lib.mkOption {
                    type = lib.types.str;
                    default = "fakeemail@m.m";
                    description = "Email for git config.";
                };
                username = lib.mkOption {
                    type = lib.types.str;
                    default = "fakeusername";
                    description = "Username for various programs.";
                };
            };
            github.username = lib.mkOption {
                type = lib.types.str;
                default = "fakegithubuser";
                description = "GitHub username for various programs.";
            };
            github.email = lib.mkOption {
                type = lib.types.str;
                default = "fakegithubemail@m.m";
                description = "GitHub email for various programs.";
            };
            mimeApps = lib.mkOption {
                type = lib.types.attrsOf (lib.types.submodule {
                    options = {
                        package = lib.mkOption {
                            type = lib.types.package;
                            default = null;
                            description = "Optional package that contains the .desktop file.";
                        };

                        entry = lib.mkOption {
                            type = lib.types.nullOr lib.types.str;
                            default = null;
                            description = "Optional desktop entry file name, e.g. 'org.gnome.eog.desktop'.";
                        };
                    };
                });

                default = {
                    imageViewer.package = pkgs.eog;
                    videoPlayer.package = pkgs.vlc;
                    docViewer.package = pkgs.zathura;
                    textEditor.package = pkgs.gedit;
                    fileManager.package = pkgs.nemo-with-extensions;
                    browser.package = pkgs.firefox;
                };
                description = "Default applications for MIME types.";
            };
            terminal.package = lib.mkOption {
                type = lib.types.package;
                default = pkgs.gnome-terminal;
                description = "Default terminal emulator.";
            };
            terminal.name = lib.mkOption {
                type = lib.types.str;
                default = "gnome-terminal";
                description = "Default terminal emulator name.";
            };
        };
    };
    config = {
        userSettings.github.username = "pxlman";
        userSettings.github.email = "agxgv7573@gmail.com";
        userSettings.terminal = {
            package = pkgs.alacritty;
            name = "alacritty";
        };
        userSettings.mimeApps = {
            imageViewer = {
                package = pkgs.eog;
            };
            videoPlayer = {
                package = pkgs.vlc;
            };
            docViewer = {
                package = pkgs.kdePackages.okular;
                entry = "okularApplication_pdf.dekstop";
            };
            textEditor = {
                package = pkgs.gedit;
            };
            fileManager = {
                package = pkgs.nemo-with-extensions;
            };
            browser = {
                package = pkgs.brave;
            };
            terminal = {
                package = pkgs.alacritty;
                name = "alacritty";
            };
        };
        programs.freetube = {
            enable = true;
            package = pkgs.freetube;
            settings = {
                allowDashAv1Formats = true;
                checkForUpdates     = false;
                defaultQuality      = "480";
                baseTheme           = "catppuccinMocha";
            };
        };
# Git config
        programs.git = {
            enable = true;
            userName = config.userSettings.github.username;
            userEmail = config.userSettings.github.email;
        };
        programs.direnv.enable = true;
        programs.direnv.nix-direnv.enable = true;
        xdg.mimeApps = {
            enable = true;
            defaultApplications = let
                files = package: builtins.attrNames (builtins.readDir "${package}/share/applications");
                getFirstDesktopFile = package:
                    let names = builtins.filter (name: builtins.match ".*\\.desktop$" name != null) (files package);
                    in if names != [] then builtins.head names else null;
                getEntry = package:
                    let name = getFirstDesktopFile package;
                    in if name != null then name else throw "No .desktop files found in ${package}";
                useEntry = app: if app.entry != null then app.entry else getEntry app.package;
            in {
                "image/png" =           useEntry config.userSettings.mimeApps.imageViewer;
                "image/jpeg" =          useEntry config.userSettings.mimeApps.imageViewer;
                "video/mp4" =           useEntry config.userSettings.mimeApps.videoPlayer;
                "video/mkv" =           useEntry config.userSettings.mimeApps.videoPlayer;
                "audio/mp3" =           useEntry config.userSettings.mimeApps.videoPlayer;
                "application/pdf" =     useEntry config.userSettings.mimeApps.docViewer;
                "application/pptx" =    useEntry config.userSettings.mimeApps.docViewer;
                "application/ppt" =     useEntry config.userSettings.mimeApps.docViewer;
                "text/plain" =          useEntry config.userSettings.mimeApps.textEditor;
                "inode/directory" =     useEntry config.userSettings.mimeApps.fileManager;
            };
        };
        home.packages = [
            config.userSettings.mimeApps.imageViewer.package
            config.userSettings.mimeApps.videoPlayer.package
            config.userSettings.mimeApps.docViewer.package
            config.userSettings.mimeApps.textEditor.package
            config.userSettings.mimeApps.fileManager.package
            config.userSettings.mimeApps.browser.package
            config.userSettings.terminal.package
        ];
        programs.mangohud = {
            enable = true;
            settings = {
                fps = true;
                cpu_stats = true;
                cpu_load_change = true;
                text_outline = true;
                position = "top-left";
            };
        };
        xdg.desktopEntries = {
            tlauncher = {
                name = "TLauncher";
                genericName = "Minecraft Launcher";
                exec = "steam-run java -jar /home/pxlman/Downloads/Tlauncher/TLauncher.jar";
                terminal = false;
                categories = [ "Application" "Game" ];
                icon = "minecraft-launcher";
# mimeType = [ "text/html" "text/xml" ];
            };
            neovim = {
                name = "neovim";
                genericName = "Neovim";
                exec = "${config.userSettings.terminal.package} nvim";
                terminal = true;
                categories = [ "TextEditor" "Utility" ];
                icon = "vim";
                mimeType = [ "text/plain" ];
            };
        };

    };
}
