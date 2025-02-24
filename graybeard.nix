{ ... }:
{
  imports = [
    ./hardware/graybeard.nix
    ./user.nix
    ./wireless.nix
    ./nvim.nix
    ./cooler.nix
    ./ui.nix
    ./home.nix
  ];

  networking.firewall.allowedUDPPorts = [ 63436 ];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "graybeard";
}
