{...}: {
  imports = [
    ./hardware/graybeard.nix
    ./user.nix
    ./wireless.nix
    ./cooler.nix
    ./ui.nix
    ./home.nix
    ./ci.nix
  ];

  networking.firewall.allowedUDPPorts = [ 63436 8000 ];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "graybeard";

  services.ddns-updater.enable = true;
}
