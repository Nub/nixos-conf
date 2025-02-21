{ inputs, config, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.zach =
      { pkgs, ... }:
      {
        home.stateVersion = "24.11";
        home.sessionVariables = { };
        home.packages = with pkgs; [
          inputs.nix-warez.packages.x86_64-linux.blender_4_2
          lunarvim
          alacritty
          chromium
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
          nixfmt-rfc-style
          ripgrep
          htop
          tmux
          xfce.thunar
          xfce.thunar-archive-plugin
          xfce.thunar-volman
          xdg-utils
          glib
          dracula-theme
          grim
          slurp
          bemenu
          font-awesome
          nerd-fonts.fira-code
          nerd-fonts.droid-sans-mono
        ];
        programs = {
          chromium.enable = true;
          home-manager.enable = true;
          fish = {
            enable = true;
            interactiveShellInit = "fish_add_path /home/zach/.local/bin:$PATH";
          };
          tmux = {
            enable = true;
            terminal = "screen-256color";
            shell = "/etc/profiles/per-user/zthayer/bin/fish";
          };
          zellij = {
            enable = true;
          };
          git = {
            enable = true;
            package = pkgs.gitAndTools.gitFull;
            userName = "Zachry Thayer";
            userEmail = "zachthayer@gmail.com";
            extraConfig = {
              core.editor = "nvim";
            };
          };
          alacritty = {
            enable = true;
            settings = {
              font = {
                size = 14.0;
              };

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
}
