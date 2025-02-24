{
  inputs,
  pkgs,
  config,
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

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
    dolphin
    wofi
    firefox-wayland
    (chromium.override {
      commandLineArgs = [
        "--ozone-platform-hint=auto"
      ];
    })
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    })
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = ["v4l2loopback"];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  #  xdg.portal = {
  #    enable = true;
  #    wlr.enable = true;
  #    extraPortals = [
  #      pkgs.xdg-desktop-portal-gtk
  #      pkgs.xdg-desktop-portal
  #    ];
  #    configPackages = [
  #      pkgs.xdg-desktop-portal-gtk
  #      pkgs.xdg-desktop-portal-hyprland
  #      pkgs.xdg-desktop-portal
  #    ];
  #  };

  # xdg = {
  #   portal = {
  #     enable = true;
  #     wlr.enable = true;
  #     xdgOpenUsePortal = true;
  #     config = {
  #       common.default = [ "gtk" ];
  #       hyprland.default = [
  #         "gtk"
  #         "hyprland"
  #       ];
  #     };
  #     extraPortals = [
  #       pkgs.xdg-desktop-portal-gtk
  #       pkgs.xdg-desktop-portal-hyprland
  #     ];
  #   };
  # };

  security.polkit.enable = true;
  security.rtkit.enable = true;

  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
    xwayland.enable = true;
  };
  programs.waybar.enable = true;
}
