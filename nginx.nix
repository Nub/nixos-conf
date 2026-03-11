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
      locations."/" = {
        return = ''200 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><title>vothuul.com</title><style>body{display:flex;justify-content:center;align-items:center;min-height:100vh;margin:0;font-family:sans-serif;background:#111;color:#eee}h1{font-size:2rem}</style></head><body><h1>Under Construction</h1></body></html>"'';
        extraConfig = ''
          default_type text/html;
        '';
      };
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
