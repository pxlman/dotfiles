{ lib, config, pkgs, ... }:
{
    options = {
        wm.cursor-theme= { 
            name = lib.mkOption {
                type = lib.types.str;
                default = "Bibata-Modern-Ice";
                description = "Cursor theme for the window manager.";
            };
            package = lib.mkOption {
                type = lib.types.package;
                default = pkgs.bibata-cursors;
                description = "Package providing the cursor theme.";
            };
        };
        wm.iconTheme = {
            name = lib.mkOption {
                type = lib.types.str;
                default = "Papirus-Dark";
                description = "Icon theme for the window manager.";
            };
            package = lib.mkOption {
                type = lib.types.package;
                default = pkgs.papirus-icon-theme;
                description = "Package providing the icon theme.";
            };
        };
        wm.gtkTheme = {
            name = lib.mkOption {
                type = lib.types.str;
                default = "Materia-dark";
                description = "GTK theme for the window manager.";
            };
            package = lib.mkOption {
                type = lib.types.package;
                default = pkgs.materia-theme;
                description = "Package providing the GTK theme.";
            };
        };
        wm.font = {
            name = lib.mkOption {
                type = lib.types.str;
                default = "Ubuntu Nerd Font Mono";
                description = "Font for the window manager.";
            };
            package = lib.mkOption {
                type = lib.types.package;
                default = pkgs.nerd-fonts.ubuntu-mono;
                description = "Package providing the font.";
            };
            size = lib.mkOption {
                type = lib.types.int;
                default = 12;
                description = "Font size for the window manager.";
            };
        };
    };
    config = {
        home.pointerCursor = {
            x11.enable = true;
# name = "Bibata-Modern-Ice";
            name = config.wm.cursor-theme.name;
            size = 20;
            package = config.wm.cursor-theme.package;
        };
        gtk = {
            enable = true;
            iconTheme = {
                name = config.wm.iconTheme.name;
                package = config.wm.iconTheme.package;
            };
# fav rose-pine whitesur-gtk-theme materia-theme
            theme = config.wm.gtkTheme;
            # name = "Hack";
            font = config.wm.font;
            gtk3.extraConfig = {
                gtk-application-prefer-dark-theme=1;
                gtk-menu-images = 1;
                gtk-button-images = 1;
                gtk-xft-antialias = 1;
                gtk-xft-hinting = 1;
                gtk-xft-hintstyle = "hintfull";
                gtk-xft-rgba = "rgb";
            };
            gtk4.extraConfig = {
                gtk-application-prefer-dark-theme=true;
                gtk-xft-antialias = 1;
                gtk-xft-hinting = 1;
                gtk-xft-hintstyle = "hintfull";
                gtk-xft-rgba = "rgb";
            };
            gtk3.bookmarks = [
                "file:///home/pxlman/Documents Documents"
                    "file:///home/pxlman/Downloads Downloads"
                    "file:///home/pxlman/Music Music"
                    "file:///home/pxlman/Videos Videos"
                    "file:///home/pxlman/Pictures Pictures"
                    "file:///mnt/files Files"
                    "file:///mnt/files/Resources/الاكاديمية الاكاديمية"
                    "file:///mnt/files/Resources/University University"
            ];
        };
        qt = {
            enable = true;
            platformTheme.name = "gtk3";
        };
    };
}
