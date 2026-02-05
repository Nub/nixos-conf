# mkUser - Creates a NixOS module for a user with home-manager config
#
# Usage in machine config:
#   imports = [
#     (import ./lib/mkUser.nix (import ./users/zach.nix))
#   ];
#
# User config file (users/username.nix):
#   {
#     name = "username";
#     hashedPassword = "...";
#     gitName = "Full Name";
#     gitEmail = "email@example.com";
#     workEmail = "work@company.com";  # optional
#   }
userConfig: {
  pkgs,
  inputs,
  ...
}: let
  inherit (userConfig) name hashedPassword gitName gitEmail;
  workEmail = userConfig.workEmail or null;
  description = userConfig.description or name;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.${name} = {
    isNormalUser = true;
    inherit description hashedPassword;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${name} = {pkgs, ...}: {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      home.stateVersion = "25.11";
      home.sessionVariables = {};
      home.sessionPath = ["$HOME/.cargo/bin"];
      home.packages = with pkgs; [
        blender
        popcorntime
        vlc
        discord
        alacritty
        spotify
        liquidctl
        systemctl-tui
        nix-tree
        udisks
        helix
        fd
        unzip
        zip
        wget
        fzf
        t
        bat
        jq
        usbutils
        can-utils
        flameshot
        nixfmt
        ripgrep
        htop
        tmux
        thunar
        thunar-archive-plugin
        thunar-volman
        xdg-utils
        glib
        dracula-theme
        grim
        slurp
        bemenu
        quickshell
        imagemagick
        wl-clipboard
        satty
        font-awesome
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono
        inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
      programs = {
        noctalia-shell = {
          enable = true;
        };
        home-manager.enable = true;
        fish = {
          enable = true;
          interactiveShellInit = "fish_add_path /home/${name}/.local/bin:$PATH";
          shellAliases = {
            dev = "nix develop --command bash -c \"nvim ./\"";
            jfu = "sudo journalctl -fu";
            ctl = "sudo systemctl";
          };
        };
        tmux = {
          enable = true;
          terminal = "screen-256color";
          shell = "/etc/profiles/per-user/${name}/bin/fish";
        };
        git = {
          enable = true;
          lfs.enable = true;
          settings = {
            user = {
              name = gitName;
              email = gitEmail;
            };
            core.editor = "nvim";
          };
          includes =
            if workEmail != null
            then [
              {
                condition = "gitdir:~/src/merops";
                contents = {
                  user = {
                    name = gitName;
                    email = workEmail;
                  };
                };
              }
            ]
            else [];
        };
        alacritty = {
          enable = true;
          settings = {
            window = {
              resize_increments = true;
              padding = {
                x = 14;
                y = 14;
              };
              opacity = pkgs.lib.mkForce 1.0;
            };
          };
        };
      };

      home.file = {
        i3 = {
          target = ".config/i3/config";
          source = ../dotfiles/i3/config;
        };
        hypr = {
          recursive = true;
          target = ".config/hypr";
          source = ../dotfiles/hypr;
        };
        waybar = {
          recursive = true;
          target = ".config/waybar";
          source = ../dotfiles/waybar;
        };
        hyprquickframe = {
          recursive = true;
          target = ".config/quickshell/HyprQuickFrame";
          source = pkgs.fetchFromGitHub {
            owner = "Ronin-CK";
            repo = "HyprQuickFrame";
            rev = "ccad800c4614f1b4c1736f5723dd1a85406378e8";
            hash = "sha256-/gCWM2SLElyio4SwaFQzkIXxBSTIb7HShYMC+izrHlo=";
          };
        };
      };
    };
  };
}
