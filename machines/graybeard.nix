{
  inputs,
  lib,
  ...
}: {
  imports = [
    ../hardware/graybeard.nix
    ../user.nix
    ../wireless.nix
    ../cooler.nix
    ../ui.nix
    ../home.nix
    ../ci.nix
    ../ai.nix
    ../nginx.nix
    ../obsidian-sync.nix
    inputs.obsidian-docsite.nixosModules.default
    # Users
    (import ../lib/mkUser.nix (import ../users/zach.nix))
  ];

  networking.firewall.allowedTCPPorts = [3000 8080];
  networking.firewall.allowedUDPPorts = [63436 8000];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "graybeard";

  services.ddns-updater.enable = true;

  services.obsidian-sync = {
    enable = true;
    vaultDir = "/home/zach/Documents";
    vaults = ["Graybeard"];
  };

  services.obsidian-docsite = {
    enable = true;
    host = "0.0.0.0";
    package = inputs.obsidian-docsite.packages.x86_64-linux.default;
    vaultPath = "/home/zach/Documents/Graybeard";
    environmentFile = "/var/lib/obsidian-docsite/env";
    settings = {
      server.base_url = "https://docs.vothuul.com";
      auth.github = {
        client_id = "$GITHUB_CLIENT_ID";
        client_secret = "$GITHUB_CLIENT_SECRET";
      };
      auth.google = {
        client_id = "$GOOGLE_CLIENT_ID";
        client_secret = "$GOOGLE_CLIENT_SECRET";
      };
      permissions.default_access = "private";
      permissions.admin_emails = ["admin@vothuul.com"];
      permissions.localhost_bypass = true;
      permissions.trust_proxy = true;
    };
  };

  systemd.services.obsidian-docsite.serviceConfig.ProtectHome = lib.mkForce "read-only";
  users.users.docsite.extraGroups = ["users"];
  users.users.zach.homeMode = "711";
}
