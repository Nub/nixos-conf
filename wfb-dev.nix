{ config, lib, pkgs, ... }: {
  imports = [ ];

  networking.useDHCP = false;

  services.wfb.enable = true;
  services.wfb.working_dir = "/home/zacht";

  services.avahi.enable = true;
  services.openssh.enable = true;
  services.openssh.ports = [ 22 2222 ];
  services.tailscale.enable = true;

  users.users.zacht = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIngpCTE3a8QDHarFnqa9O08MbmOlPNzptmfQ233yGzn zachthayer@F915Q2RDFY"
    ];
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "2819";
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    nixfmt
    iperf
    cachix
    iw
    git
    neovim
    python3
    lunarvim
    tailscale
    nixfmt
    fzf
    ripgrep
    zellij
    usbutils
    fishPlugins.bass
    home-manager
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    openssl
    libelf
    glib
    bzip2
    nspr
    nss
    cups
    libcap
    libusb1
    dbus-glib
    libudev0-shim
    libcaca
    libcanberra
    libgcrypt
    libvpx
    librsvg
    libvdpau
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "23.11"; # Did you read the comment?
}

