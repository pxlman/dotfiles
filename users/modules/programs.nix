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
            settings.user = {
                email = config.userSettings.user.email;
                name = config.userSettings.user.name;
            };
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
        programs.tmux = lib.mkIf config.programs.tmux.enable {
            # shell = "${pkgs.fish}/bin/fish";
            # terminal = "tmux-256color";
            historyLimit = 100000;
            plugins = with pkgs;
            [
                tmuxPlugins.tmux-thumbs
                    tmuxPlugins.sensible
# must be before continuum edits right status bar
                    {
                        plugin = tmuxPlugins.catppuccin;
                        extraConfig = '' 
                            set -g @catppuccin_flavor "mocha"
                            set -g @catppuccin_window_status_style "rounded"
                            set -g @catppuccin_status_background "#1e1e2e"
                            '';
                    }
                    {
                        plugin = tmuxPlugins.vim-tmux-navigator;
                    }
            {
                plugin = tmuxPlugins.resurrect;
                extraConfig = ''
                    set -g @resurrect-strategy-vim 'session'
                    set -g @resurrect-strategy-nvim 'session'
                    set -g @resurrect-capture-pane-contents 'on'
                    '';
            }
            {
                plugin = tmuxPlugins.continuum;
                extraConfig = ''
                    set -g @continuum-restore 'on'
                    set -g @continuum-boot 'on'
                    set -g @continuum-save-interval '10'
                    '';
            }
            tmuxPlugins.better-mouse-mode
                tmuxPlugins.yank
                ];
            extraConfig = ''
                set -g default-terminal "tmux-256color"
                set-option -sa terminal-features ',xterm-256color:RGB'
                # set -ag terminal-overrides ",xterm-256color:RGB"
                # set-option -sa terminal-overrides ",xterm*:Tc"

                set-option -g prefix C-i
                unbind-key C-b
                bind-key C-i send-prefix

                set -g mouse on

# Change splits to match nvim and easier to remember
# Open new split at cwd of current split
                unbind %
                unbind '"'
                bind | split-window -h -c "#{pane_current_path}"
                bind - split-window -v -c "#{pane_current_path}"

# Use vim keybindings in copy mode
                set-window-option -g mode-keys vi

# v in copy mode starts making selection
                bind-key -T copy-mode-vi v send-keys -X begin-selection
                bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
                bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

# Escape turns on copy mode
                bind Escape copy-mode

# Easier reload of config
                bind r source-file ~/.config/tmux/tmux.conf

                set-option -g status-position top
                set -g status-right-length 100
                set -g status-left-length 100
                set -g status-left ""
                set -g status-right "#{E:@catppuccin_status_application}"
                set -ag status-right "#{E:@catppuccin_status_session}"
                set -ag status-right "#{E:@catppuccin_status_uptime}"

# make Prefix p paste the buffer.
                unbind p
                bind p paste-buffer

# Bind Keys
                # bind-key -T prefix C-g split-window \
                # "$SHELL --login -i -c 'navi --print | head -c -1 | tmux load-buffer -b tmp - ; tmux paste-buffer -p -t {last} -b tmp -d'"
                # bind-key -T prefix C-l switch -t notes
                # bind-key -T prefix C-d switch -t dotfiles
                # bind-key e send-keys "tmux capture-pane -p -S - | nvim -c 'set buftype=nofile' +" Enter
                '';

        };


    };
}
