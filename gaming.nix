{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  # Star citizen
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs:
        with pkgs; [
          xorg.xkeyboardconfig
          libxkbcommon
          dotnet-sdk
          webkitgtk_4_1
        ];
    };
  };

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    lutris
    mangohud
    protonup-qt
    lutris
    bottles
    heroic
    corectrl
    vulkan-tools
    mesa-demos
    inputs.hytale-launcher.packages.${system}.default
  ];
}
