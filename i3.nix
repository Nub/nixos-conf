{ inputs, pkgs, lib, ... }:
{

  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix.enable = true;
  stylix.polarity = "dark";
  stylix.image = ./wallpaper.jpg;
  stylix.fonts = {
    sizes = {
      applications = 12;
      desktop = 12;
      popups = 12;
      terminal = 14;
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.nerd-fonts.fira-code;
      name = "DejaVu Sans Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
  stylix.targets = {
    chromium.enable = true;
    fish.enable = true;
    gtk.enable = true;
    qt.enable = true;
  };

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    dpi = 138;
#    config = lib.mkAfter (builtins.readFile ./dotfiles/xorg.conf);
    xkb.layout = "us";
    xkb.variant = "";
    desktopManager.xterm.enable = true;
    windowManager.i3 = {
      package = pkgs.i3-rounded;
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3lock
        rofi
        dmenu
        polybar
      ];
    };
  };

  environment.variables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  services.displayManager = {
    defaultSession = "none+i3";
    # Enable automatic login for the user.
    autoLogin.enable = true;
    autoLogin.user = "zach";
  };

  environment.systemPackages = with pkgs; [
    alacritty
    chromium
    pavucontrol
  ];

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
