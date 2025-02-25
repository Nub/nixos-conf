{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
    audio.enable = true;
  };
}
