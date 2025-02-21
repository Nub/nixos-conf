{ ... }:
{
  imports = [
    ./zgamer-hw-cfg.nix
    ./i3.nix
    ./user.nix
    ./wireless.nix
    ./gaming.nix
  ];

  networking.hostName = "zgamer";
}
