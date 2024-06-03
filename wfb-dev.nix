{ config, lib, pkgs, ... }: {
  imports = [ ];

  networking.useDHCP = false;
  networking.interfaces.enp0s1.useDHCP = true;
  networking.interfaces.enp0s2.useDHCP = true;

  services.wfb.enable = true;
  services.wfb.working_dir = "/home/zacht";

  services.openssh.enable = true;
  services.openssh.ports = [ 22 2222 ];
  services.tailscale.enable = true;
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/cache-priv-key.pem";
  };

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

  nix.sshServe.enable = true;
  nix.sshServe.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxFUJ/qgw2yVAiOXW2O6JWGSWGhOJmlYlCzbSYxXBzQE53YbObQFnu5cu9jXVmHX125dzAMRupd8AUkz17KWocxJF+5Gntnp0ZUYnLFIUYl8nLQmLoTEXZK011PGllEOptWZ/WtFIF+UP8qT7TY1AHx8lVi4DUDxmqD2djDwbNIMY2vWiqv4KqX3oy6Kv4jFMUT350w1L4FAqYO2iOvqo+da3xyYWOQ5xkN8FrA+ylTjuSeR+z4GGjt6u4tZd46gkoUNGXc9B5bDsQq23/E4nVSaaD1ioB5fVZE34lHkbdyybFg2g0GEuBXdCuLPHISrElMdWNSIEEnbjHeBkVf8LbymbEKfHRYH0tIfCm7F0zXsouB9Bpaa02FxRSsucjdjGWtZkHx/EP90+ETqKD++2aKa19nFC/QkQrRdDYyO8BTH/dcts91aOdbTdO/sO4K02tBJfb5iXQNEU0hO5J430zTmF6wURx9PEZnZEKd8JjPiJ77/jMeFZk48UpNc06Cik= merops@gcs-0002"
  ];
  nix.settings.trusted-users = [ "@wheel" "zacht" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "23.11"; # Did you read the comment?
}

