{
  description = "Nub's nixery";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-warez.url = "github:edolstra/nix-warez?dir=blender";
    nix-warez.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
      ...
    }@inputs:
    let
      inherit (nixpkgs.lib) nixosSystem;
    in
    {
      nixosConfigurations = {
        zgamer = nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./zgamer.nix
            (
              { ... }:
              {
                nixpkgs.config.allowUnfree = true;
              }
            )
          ];
        };
      };
    };
}
