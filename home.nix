# Neovim configuration (nvf)
# Home-manager user config is now in lib/mkUser.nix
{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.nixosModules.default
  ];

  programs.nvf = {
    enable = true;
    settings = (import ./nvim.nix) {inherit pkgs config inputs;};
  };
}
