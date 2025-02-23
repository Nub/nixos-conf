{pkgs, ...}:
{
  environment.systemPackages = with pkgs;[
    pavucontrol
  ];
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
