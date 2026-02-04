# Neovim configuration (nvf)
# Home-manager user config is now in lib/mkUser.nix
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.nixosModules.default
  ];

  programs.nvf = {
    enable = true;
    settings = (import ./nvim.nix) {inherit pkgs inputs;};
  };
}
