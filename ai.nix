{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [inputs.claude-code.overlays.default];
  environment.systemPackages = with pkgs; [
    claude-code
    python3Packages.huggingface-hub
    llama-cpp
    qwen-code
  ];

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
}
