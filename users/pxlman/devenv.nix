{ pkgs, config, ... }: {
  languages.python = {
    enable = true;
    version = "3.11";
    venv.enable = true;
    venv.requirements = ''
      requests
      torch
      yt-dlp
      http
      sympy
      numpy
      pandas
      matplotlib
      tkinter
    '';
    uv.enable = true;
  };
}
