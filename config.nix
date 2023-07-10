{ config, pkgs, ... }:
let unstable = import <nixos-unstable> {};
sway-nvidia = pkgs.callPackage (import ./sway.nix) {};
in {
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
      home.sessionVariables = {
        MOZ_ENABLE_WAYLAND = 1;
        XDG_CURRENT_DESKTOP = "sway";
      };
      home.packages = with pkgs; [
        glpaper
        swaylock-effects
        swayidle
        wl-clipboard
        mako
        alacritty
        wofi
        waybar
        unstable.firefox
        slack
        font-awesome
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      ];
      programs = {
        home-manager.enable = true;
        fish = {
          enable = true;
          interactiveShellInit = "fish_add_path /home/zthayer/.local/bin:$PATH";
        };
        neovim = let
          parsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
            rust
            c
            cpp
            python
            haskell
            dhall
            nix
            json
            toml
            yaml
            html
            css
            java
            javascript
            regex
            proto
            markdown
            make
            go
            ron
            ini
            fish
            glsl
            lua
          ];
        in {
          enable = true;
          vimAlias = true;
          defaultEditor = true;
          plugins = with pkgs.vimPlugins; [
            nvim-treesitter
            telescope-nvim
            telescope-fzf-native-nvim
          ] ++ parsers;
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
          settings = {
            font = { size = 14.0; };

            window = {
              opacity = 0.85;
              padding = {
                x = 16;
                y = 16;
              };
            };

            live_config_reload = true;

            colors = {
              # Default colors
              primary = {
                background = "0x1b182c";
                foreground = "0xcbe3e7";
              };
              # Normal colors
              normal = {
                black = "0x100e23";
                red = "0xff8080";
                green = "0x95ffa4";
                yellow = "0xffe9aa";
                blue = "0x91ddff";
                magenta = "0xc991e1";
                cyan = "0xaaffe4";
                white = "0xcbe3e7";
              };

              # Bright colors
              bright = {
                black = "0x565575";
                red = "0xff5458";
                green = "0x62d196";
                yellow = "0xffb378";
                blue = "0x65b2ff";
                magenta = "0x906cff";
                cyan = "0x63f2f1";
                white = "0xa6b3cc";
              };
            };
          };
        };
      };
      home.file = {
        wofi = {
          target = ".config/wofi/style.css";
          source = ./dotfiles/wofi/style.css;
        };
        mako = {
          target = ".config/mako/config";
          source = ./dotfiles/mako/config;
        };
        waybar = {
          target = ".config/waybar/config";
          source = ./dotfiles/waybar/config;
        };
        waybar-css = {
          target = ".config/waybar/style.css";
          source = ./dotfiles/waybar/style.css;
        };
        wallpaper = {
          target = ".config/wallpaper.png";
          source = ./wallpaper.png;
        };
      };
      wayland.windowManager.sway = {
        enable = true;
        package = sway-nvidia;
        config = {
          modifier = "Mod4";
          terminal = "alacritty";
          menu = "wofi --show run";
          bars = [{ command = "waybar"; }];
        };
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
