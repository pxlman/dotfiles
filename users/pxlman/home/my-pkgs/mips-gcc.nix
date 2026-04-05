{ pkgs, mipsPkgs }:
pkgs.buildEnv {
  name = "mips-gcc-env";
  paths = [
    pkgs.mars-mips
    mipsPkgs.buildPackages.binutilsNoLibc
    # crossPkgs.bintools-unwrapped
    mipsPkgs.gcc
  ];
  postBuild = ''
    rm -rf $out/share/locale
  '';

}

