{config, lib, pkgs, ...}:
{

# Set your time zone.
    time.timeZone = "Africa/Cairo";
# Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_PAPER = "ar_EG.utf8";
    };
# Fonts
    fonts.packages = with pkgs;[
#jetbrains-mono
# nerdfonts
        nerd-fonts.jetbrains-mono
            nerd-fonts.caskaydia-cove
            nerd-fonts.caskaydia-cove
            nerd-fonts.ubuntu
            nerd-fonts.ubuntu-mono
            nerd-fonts.hack
            nerd-fonts.fira-code
            source-code-pro # optional for spacemacs
            material-icons
            material-symbols

            font-awesome
# fira-code-nerdfont
#terminus-nerdfont
#hack-font
    ];
}
