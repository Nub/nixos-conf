{
  description = "Nub's nixery";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    wfb-ng = {
      url = "github:Nub/wfb-ng/zbt/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, ... }@inputs:
    let
      inherit (nixpkgs.lib) nixosSystem;
      # utils.lib.eachDefaultSystem (system: {
    in {
      nixosConfigurations = {
        wfb-qemu = nixosSystem rec {
          # inherit system;
          system = "aarch64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            inputs.wfb-ng.nixosModules.${system}.wfb
            (import ./wfb-dev.nix)
            (import ./qemu-hw-cgf.nix)
          ];
        };
        wfb-wsl = nixosSystem rec {
          # inherit system;
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            inputs.wfb-ng.nixosModules.${system}.wfb
            (import ./wsl-hw-cfg.nix)
            (import ./wfb-dev.nix)
            (import ./i3.nix)
            (import ./wireless.nix)
          ];
        };
      };
      # });
    };
}
