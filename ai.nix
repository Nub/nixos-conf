{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [inputs.claude-code.overlays.default];
  environment.systemPackages = with pkgs; [
    claude-code
  ];
}
