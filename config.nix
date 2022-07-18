{ config, pkgs, ... }:

{
  imports = [];

  time.timeZone = "America/Los_Angeles";

  networking.useDHCP = true;
  services.xserver.enable = true;

  services.xserver.desktopManager = {
     xterm.enable = false;
  };
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [ rofi dmenu i3status i3lock i3blocks i3lock-fancy ];
  };
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;
  services.openssh.enable = true;

  programs.ssh.startAgent = true;
  programs.mosh.enable = true;
  services.globalprotect = {
    enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs.fish.enable = true;
  users.users.zthayer = {
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout" ];
    shell = pkgs.fish;
  };


  environment.systemPackages = with pkgs; [
    neovim
    (vscode-with-extensions.override { vscodeExtensions = with vscode-extensions; [
      vadimcn.vscode-lldb
      matklad.rust-analyzer
      arrterian.nix-env-selector
      bbenoist.nix
      brettm12345.nixfmt-vscode
      zhuangtongfa.material-theme
      pkief.material-icon-theme
      bungcip.better-toml
      serayuzgur.crates
      usernamehw.errorlens
      eamodio.gitlens
      github.github-vscode-theme
    ];})
    unzip
    rustup
    lldb
    zip
    wget
    git
    fzf
    bat
    alacritty
    firefox
    usbutils
    can-utils
    xorg.xrandr
    flameshot
    globalprotect-openconnect
    i3status-rust
    nixfmt
    ripgrep
    htop
  ];

  fonts.fonts = with pkgs; [
    font-awesome
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];


  nixpkgs.config.allowUnfree = true;
  nix.binaryCaches = [
    "https://cache.nixos.org/"
    "https://s3-us-west-2.amazonaws.com/anduril-nix-cache"
    "https://s3-us-west-2.amazonaws.com/anduril-nix-polyrepo-cache"
  ];
  nix.binaryCachePublicKeys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "anduril-nix-cache:0FYOuMqEzbSX2PmByfePpJAsSV6CW+1YWoq7b21NxHc="
    "anduril-nix-polyrepo-cache:0FYOuMqEzbSX2PmByfePpJAsSV6CW+1YWoq7b21NxHc="
  ];


  system.stateVersion = "22.05";
}
