{...}: {
  imports = [
    ./hardware/zgamer.nix
    ./user.nix
    ./home.nix
    ./wireless.nix
    ./gaming.nix
    ./wireless.nix
    ./cooler.nix
    ./ui.nix
    ./audio.nix
    ./hyprland.nix
    ./work.nix
    # ./nordvpn.nix
  ];

  networking.firewall.allowedUDPPorts = [63436];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "zgamer";
  networking.networkmanager.enable = true;

  # services.custom.nordvpn.enable = true;
}
