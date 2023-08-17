{ config, pkgs, ... }:
let unstable = import <nixos-unstable> {};
flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
in {
  imports = [ 
    <home-manager/nixos>
  ];

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
      home.sessionVariables = {};
      home.packages = with pkgs; [
        glpaper
        swaylock-effects
        swayidle
        wl-clipboard
        mako
        alacritty
        wofi
        waybar
        unstable.firefox-wayland
        slack
        fd
        unzip
        rustup
        zip
        wget
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
        xfce.thunar-archive-plugin
        xfce.thunar-volman
        wayland
        xdg-utils
        glib
        dracula-theme
        gnome3.adwaita-icon-theme
        grim
        slurp
        bemenu
        wdisplays
        font-awesome
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })

      ];
      programs = {
        firefox = {
          enable = true;
          package = unstable.firefox-wayland;
        };
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
          };
        };
      };

      home.file = {
        i3 = {
          target = ".config/i3/config";
          source = ./dotfiles/i3/config;
        };
      };

    };
  };

  services.xserver.enable = true;
  services.xserver.desktopManager = {
     xterm.enable = false;
  };
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [ rofi dmenu i3status i3lock i3blocks i3lock-fancy ];

  };

  fonts.fontconfig.enable = true;
  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    font-awesome
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    openssh.enable = true;
    postgresql = {
      enable = true;
    };
  };
  sound.enable = true;

  programs.ssh.startAgent = true;

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
