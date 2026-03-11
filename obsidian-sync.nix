{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.services.obsidian-sync;
  nodejs = pkgs.nodejs_22;
in {
  options.services.obsidian-sync = {
    enable = lib.mkEnableOption "Obsidian headless sync";

    user = lib.mkOption {
      type = lib.types.str;
      default = "zach";
      description = "User to run the sync service as";
    };

    vaultDir = lib.mkOption {
      type = lib.types.str;
      default = "/home/${cfg.user}";
      description = "Root directory containing vault subdirectories";
    };

    vaults = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of vault directory names under vaultDir to sync";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services = lib.listToAttrs (map (vault:
      lib.nameValuePair "obsidian-sync-${vault}" {
        description = "Obsidian Headless Sync - ${vault}";
        after = ["network-online.target"];
        wants = ["network-online.target"];
        wantedBy = ["multi-user.target"];

        path = [nodejs pkgs.bash];
        environment = {
          HOME = "/home/${cfg.user}";
        };

        serviceConfig = {
          Type = "simple";
          User = cfg.user;
          ExecStart = "${nodejs}/bin/npx --yes --package=obsidian-headless ob sync --continuous --path ${cfg.vaultDir}/${vault}";
          Restart = "on-failure";
          RestartSec = 30;
        };
      })
    cfg.vaults);
  };
}
