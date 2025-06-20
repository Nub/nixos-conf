{
  pkgs,
  inputs,
  ...
}: {
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
    inputs.nix-citizen.packages.${pkgs.system}.star-citizen-umu
    # inputs.nix-gaming.packages.${pkgs.system}.star-citizen
    # (inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.star-citizen.override {
    #   tricks = ["arial" "vcrun2019" "win10" "sound=alsa"];
    # })
  ];
}
