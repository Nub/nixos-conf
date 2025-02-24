{ ... }:
{
  imports = [
    ./zgamer-hw-cfg.nix
    ./user.nix
    ./wireless.nix
    ./gaming.nix
    ./wireless.nix
    ./nvim.nix
    ./cooler.nix
    ./ui.nix
    ./audio.nix
    ./hyprland.nix
  ];

  networking.firewall.allowedUDPPorts = [ 63436 ];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "zgamer";
}
