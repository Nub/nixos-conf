{ pkgs, ... }:
{
  imports = [ ./home.nix ];

  services.avahi.enable = true;
  services.openssh.enable = true;

  users.users.zach = {
    isNormalUser = true;
    description = "zach";
    hashedPassword = "$y$j9T$LPJ53nJ9NA6ZlffHHiPc1/$LwcNqFHTSWTbc8YeTa0WftmfdkImVPsNSIQiczi3yUC";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    git
    neovim
    zellij
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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "24.11"; # Did you read the comment?
}
