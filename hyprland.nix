{
  inputs,
  config,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  services.xserver.xkb = {
    layout = "us";
  };

  systemd.services.greetd = {
    unitConfig = {
      After = pkgs.lib.mkOverride 0 ["multi-user.target"];
    };
    serviceConfig = {
      Type = "idle";
    };
  };

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
    wofi
    kdePackages.xwaylandvideobridge
    (firefox-wayland.override {nativeMessagingHosts = [inputs.pipewire-screenaudio.packages.${pkgs.system}.default];})
    (chromium.override {
      commandLineArgs = [
        "--ozone-platform-hint=auto"
      ];
    })
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vkcapture
        obs-gstreamer
      ];
    })
    v4l-utils
  ];

  environment.variables = {
    NIXOS_OZONE_WL = 1;
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  security.polkit.enable = true;
  security.rtkit.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
    xwayland.enable = true;
  };
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  programs.xwayland.enable = true;
  programs.waybar.enable = true;
}
