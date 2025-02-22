{ ... }:
{
  imports = [
    ./zgamer-hw-cfg.nix
    ./i3.nix
    ./user.nix
    ./wireless.nix
    ./gaming.nix
    ./wireless.nix
    ./nvim.nix
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "zgamer";
}
