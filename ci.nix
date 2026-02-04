{ ... }:
{
  services.logind.settings.Login = {
    RuntimeDirectorySize = "100G";
  };
  services.github-runners = {
    graybeard = {
      enable = true;
      name = "graybeard";
      tokenFile = ./ci_token;
      url = "https://github.com/Nub/graybeard";
    };
  };
}
