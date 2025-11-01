{config, lib, pkgs, ...}:

{
    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
            rocmPackages.clr.icd
                amdvlk
        ];
        enable32Bit = true;
    };
### AMD suff
    hardware.amdgpu = {
        initrd.enable = true;
        opencl.enable = true;
        amdvlk.enable = true;
        amdvlk.support32Bit.enable = true;
    };
    hardware.cpu.amd.updateMicrocode = true;
    hardware.bluetooth = {
        enable = true; # Enables bluetooth
            input = {
                General = {
                    UserspaceHID=true;
                    ClassicBondedOnly=false;
                    LEAutoSecurity=false;
                };
            };
        powerOnBoot = true; # Powers on the bluetooth on boot up
    };
    hardware.xpadneo.enable = true;
}
