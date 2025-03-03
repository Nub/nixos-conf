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

  networking.firewall.allowedUDPPorts = [63436];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "graybeard";
}
