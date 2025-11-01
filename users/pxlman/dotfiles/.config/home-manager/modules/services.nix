{ lib, config, pkgs, ... }:
{
    options.temp.exampleOption = lib.mkOption {
        type = lib.types.str;
        default = "defaultValue";
        description = "An example option for the temp module.";
    };
    
    config = lib.mkIf config.temp.exampleOption != "defaultValue" {
        environment.variables.EXAMPLE_OPTION = config.temp.exampleOption;
    };
}
