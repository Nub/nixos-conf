{...}: {
  services.nginx = {
    enable = true;
    virtualHosts."docs.vothuul.com" = {
      forceSSL = true;
      useACMEHost = "vothuul.com";
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header X-Forwarded-Host $host;
          proxy_set_header X-Real-IP $remote_addr;
        '';
      };
    };
    virtualHosts."vothuul.com" = {
      forceSSL = true;
      useACMEHost = "vothuul.com";
      root = ./vothuul-landing;
    };
  };

  security.acme = {
    acceptTerms = true;
    certs."vothuul.com" = {
      domain = "vothuul.com";
      extraDomainNames = ["*.vothuul.com"];
      dnsProvider = "cloudflare";
      environmentFile = "/var/lib/secrets/acme-cloudflare.env";
      email = "admin@vothuul.com";
      group = "nginx";
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
