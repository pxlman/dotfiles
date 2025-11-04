{pkgs, ...}:
{
# ZSH configuration
programs.eza.enableZshIntegration = true;
programs.zsh = {
  enable = true;
  autocd = true; # directly cd to dir if typed
  enableCompletion = true;
  autosuggestion = {
    enable = true;
    #highlight = "fg=#aaaaaa,bg=black,regular,underline";
  };
  syntaxHighlighting = {
    enable = true;
    highlighters = [
      "brackets"
    ];
  };
  oh-my-zsh = {
    enable = true;
    theme = "tjkirch";
    plugins = [
      "sudo" # sudo the previous command by just double ESC
      "eza"
      "git"
    ];
  };
  #enableLsColors = true;
  shellAliases = {
    ls = "exa -g --color=always --group-directories-first --icons --color-scale";
    ll = "exa -lag --color=always --group-directories-first --icons --color-scale";
    t = "tree .";
    grep = "grep --color=always";
    du = "dust -r";
    df = "df -h";
    h = "helix";
    n = "nvim";
    s = "snooze";
    d = "curl -LO";
    docker = "sudo docker";
    #nrc = "nvim ~/.config/nvim";
    copy="xclip -selection clipboard";
    rc = "nvim ~/dotfiles/users/pxlman/home/home.nix";
    nrc = "nvim ~/dotfiles/system/configuration.nix";
    gitdone="git add .; git commit -m '[+]'; git push; echo '[*] Files Saved'"; # git done
    home = "home-manager switch --flake ~/dotfiles#pxlman --verbose";
    switch = "sudo nixos-rebuild switch --flake ~/dotfiles#Ahmed --verbose";
    hdmi = "xrandr --output HDMI-1 --output eDP-1  --auto";
    juice-shop = "docker run --rm -p 127.0.0.1:3000:3000 bkimminich/juice-shop";
    webgoat = "docker run -it -p 127.0.0.1:8080:8080 -p 127.0.0.1:9090:9090 webgoat/webgoat";
    free-steam = "curl \"https://store.steampowered.com/search/?maxprice=free&supportedlang=english&specials=1&ndl=1\" -s | grep -oP '(?<=class=\"title\">)(?:(?!Add-On).)*(?=<.*)'";
    steam-free = "free-steam";
    clickup = "appimage-run ~/clickup.AppImage";
    ytd = "yt-dlp --format='135+139' --embeded-chapters";
    # pavucontrol = "GTK_THEME= pavucontrol";
  };
  initContent = ''
    export _JAVA_AWT_WM_NONREPARENTING=1
    # This is to solve vulkan error in steam
    # U must make sure to install the needed vulkan drivers (these files r there)
    # packages(i think): vulkan-intel vulkan-headers vulkan-tools 
    export VK_DRIVER_FILES=/usr/share/vulkan/icd.d/intel_icd.i686.json:/usr/share/vulkan/icd.d/intel_icd.x86_64.json
    cat ~/.cache/wallust/sequences
  '';
};
}
