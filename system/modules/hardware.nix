{config, lib, pkgs, ...}:

{
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
          extraPackages = with pkgs; [
    mesa
  ];

  extraPackages32 = with pkgs.pkgsi686Linux; [
    mesa
  ];

    };
### AMD suff
    hardware.amdgpu = {
        initrd.enable = true;
        opencl.enable = true;
        # amdvlk.enable = true; deprecated
        # amdvlk.support32Bit.enable = true; deprecated
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
