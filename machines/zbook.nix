{...}: {
  imports = [
    ../hardware/zbook-hw.nix
    ../user.nix
    ../home.nix
    ../wireless.nix
    ../ui.nix
    ../audio.nix
    ../hyprland.nix
    ../ai.nix
    # Users
    (import ../lib/mkUser.nix (import ../users/zach.nix))
  ];

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "zbook";
  networking.networkmanager.enable = true;
}
