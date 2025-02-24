{...}:
{
services.github-runners = {
graybeard = {
      enable = true;
      name = "runner";
      tokenFile = ./ci_token;
      url = "https://github.com/Nub/graybeard";
    };
};
}
