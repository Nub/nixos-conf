{pkgs, ...}: {
  imports = [];

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
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    vulkan-loader
    libGL
    libxkbcommon
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://nix-gaming.cachix.org"
    "https://nix-citizen.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}
