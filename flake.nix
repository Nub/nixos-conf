{
  description = "Nub's nixery";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };

    hytale-launcher.url = "github:JPyke3/hytale-launcher-nix";

    claudecode-nvim = {
      url = "github:coder/claudecode.nvim";
      flake = false;
    };

    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs = inputs: let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    mkSystem = system: modules:
      nixosSystem {
        inherit system modules;
        specialArgs = {inherit inputs;};
      };
  in
    # Merge per-system outputs (packages) with system-wide outputs (nixosConfigurations)
    (inputs.utils.lib.eachDefaultSystem (system: let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      packages = {
        nvim =
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [
              {
                config = (import ./nvim.nix) {inherit pkgs inputs;};
              }
            ];
          })
          .neovim;
      };
    }))
    // {
      # Machine configurations (at top level, not per-system)
      nixosConfigurations = {
        zgamer = mkSystem "x86_64-linux" [
          ./machines/zgamer.nix
        ];

        graybeard = mkSystem "x86_64-linux" [
          ./machines/graybeard.nix
        ];
      };
    };
}
