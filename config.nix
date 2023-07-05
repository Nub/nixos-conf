{ config, pkgs, ... }: {
  imports = [ <home-manager/nixos> ];

  time.timeZone = "America/Los_Angeles";

  networking.useDHCP = true;
  networking.firewall.enable = false;
  networking.wireguard.enable = true;

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  users.users.zthayer = {
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout" ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.zthayer = { pkgs, ... }: {
      home.stateVersion = "23.05";
      home.packages = with pkgs; [
        swaylock-effects
        swayidle
        wl-clipboard
        mako
        alacritty
        wofi
        waybar
        firefox
        font-awesome
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      ];
      programs = {
        home-manager.enable = true;
        fish = {
          enable = true;
          interactiveShellInit = "fish_add_path /home/zthayer/.local/bin:$PATH";
        };
        neovim = {
          enable = true;
          vimAlias = true;
        };
        tmux = {
          enable = true;
          terminal = "screen-256color";
          shell = "/etc/profiles/per-user/zthayer/bin/fish";
        };
        git = {
          enable = true;
          package = pkgs.gitAndTools.gitFull;
          userName = "Zachry Thayer";
          userEmail = "zthayer@anduril.com";
          extraConfig = { core.editor = "nvim"; };
        };
        alacritty = {
          enable = true;
          settings = { font = { size = 14.0; }; };
        };

      };
      home.file = {
        wofi = {
          target = ".config/wofi/style.css";
          source = ./dotfiles/wofi/style.css;
        };
        waybar = {
          target = ".config/waybar/config";
          source = ./dotfiles/waybar/config;
        };
        waybar-css = {
          target = ".config/waybar/style.css";
          source = ./dotfiles/waybar/style.css;
        };
      };
      wayland.windowManager.sway = {
        enable = true;
        extraConfig = builtins.readFile ./dotfiles/sway/config;
      };
    };
  };

  fonts.fontconfig.enable = true;
  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    font-awesome
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  security.pam.services.swaylock = { text = "auth include login"; };
  security.polkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    openssh.enable = true;
  };
  sound.enable = true;
  programs.ssh.startAgent = true;

  environment.systemPackages = with pkgs; [
    fd
    unzip
    rustup
    zip
    wget
    git
    fzf
    bat
    jq
    usbutils
    can-utils
    flameshot
    nixfmt
    ripgrep
    htop
    zoom
    tmux
    xfce.thunar
    wayland
    xdg-utils
    glib
    dracula-theme
    gnome3.adwaita-icon-theme
    grim
    slurp
    bemenu
    wdisplays
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.substituters = [
    "https://cache.nixos.org/"
    "https://s3-us-west-2.amazonaws.com/anduril-nix-cache"
    "https://s3-us-west-2.amazonaws.com/anduril-nix-polyrepo-cache"
  ];

  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "anduril-nix-cache:0FYOuMqEzbSX2PmByfePpJAsSV6CW+1YWoq7b21NxHc="
    "anduril-nix-polyrepo-cache:0FYOuMqEzbSX2PmByfePpJAsSV6CW+1YWoq7b21NxHc="
  ];

  nix.package =
    pkgs.nixFlakes; # or versioned attributes like nixVersions.nix_2_8
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "23.05";
}
