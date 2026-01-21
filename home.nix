{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nvf.nixosModules.default
  ];

  programs.nvf = {
    enable = true;
    settings = (import ./nvim.nix) {inherit pkgs;};
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.zach = {pkgs, ...}: {
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
        nixfmt-rfc-style
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
        font-awesome
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono
        inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      ];
      programs = {
        home-manager.enable = true;
        fish = {
          enable = true;
          interactiveShellInit = "fish_add_path /home/zach/.local/bin:$PATH";
          shellAliases = {
            dev = "nix develop --command bash -c \"nvim ./\"";
            jfu = "sudo journalctl -fu";
            ctl = "sudo systemctl";
          };
        };
        tmux = {
          enable = true;
          terminal = "screen-256color";
          shell = "/etc/profiles/per-user/zthayer/bin/fish";
        };
        git = {
          enable = true;
          lfs.enable = true;
          userName = "Zachry Thayer";
          userEmail = "zachthayer@gmail.com";
          extraConfig = {
            core.editor = "nvim";
          };
          includes = [
            {
              condition = "gitdir:~/src/merops";
              contents = {
                user = {
                  name = "Zachry Thayer";
                  email = "zach@meropsautomation.com";
                };
              };
            }
          ];
        };
        alacritty = {
          enable = true;
          settings = {
            window = {
              padding = {
                x = 16;
                y = 12;
              };
              opacity = pkgs.lib.mkForce 0.95;
            };
          };
        };
      };

      home.file = {
        i3 = {
          target = ".config/i3/config";
          source = ./dotfiles/i3/config;
        };
        hypr = {
          recursive = true;
          target = ".config/hypr";
          source = ./dotfiles/hypr;
        };
        waybar = {
          recursive = true;
          target = ".config/waybar";
          source = ./dotfiles/waybar;
        };
      };
    };
  };
}
