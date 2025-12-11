{ lib, config, pkgs,unstable, ... }:
{
    options = {
        gaming.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable gaming related packages and configurations.";
        };
    };
    config = lib.mkIf config.gaming.enable {
        nixpkgs.config.permittedInsecurePackages = [
                "mbedtls-2.28.10" # needed for dolphin-emu
          ];
        home.packages = with pkgs; [
### CLI Apps
            helix # Text editor command `hx`
                nettools # ithink for ip a
                eza # ls fork
                ascii # show ascii table
                dolphin-emu
                zeroad # 0ad
                unstable.legendary-gl # CLI tool for epic games 
                heroic # Epic games launcher
                superTux
                superTuxKart
                ddnet
                lutris # games launcher
                gamepad-tool # Testing gamepad
                dolphin-emu
                mesa
                vulkan-loader
                vulkan-tools
                # driversi686Linux.mesa
        ];
        programs.mangohud = {
            enable = true;
            settings = {
                fps = true;
                cpu_stats = true;
                cpu_load_change = true;
                ram = true;
                text_outline = true;
                position = "top-left";
            };
        };
    };
}
