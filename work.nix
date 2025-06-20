{pkgs, ...}: {
  services.tailscale.enable = true;
  nix.settings.substituters = ["https://attic.stonecat.net/sc-attic-01-cache"];
  nix.settings.trusted-public-keys = [
    "sc-attic-01-cache:AXRzExEtJkBFP9ENBtwPg5R4vRAL2RiaOVMVYLY/WT8="
  ];
  nix.settings.netrc-file = pkgs.writeText "netrc" ''
    machine attic.stonecat.net
    password eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NjYyNzgzMzcsIm5iZiI6MTczNDcxODE0NSwic3ViIjoiZGVwbG95IiwiaHR0cHM6Ly9qd3QuYXR0aWMucnMvdjEiOnsiY2FjaGVzIjp7InNjLWF0dGljLTAxLWNhY2hlIjp7InIiOjF9fX19.4kl9TTZuHS5AEhIWZF3W1-fAdvKerh33qQfV_Gntq-A
  '';
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      domain = true;
      hinfo = true;
      userServices = true;
    };
  };
  services.resolved.enable = true;
}
