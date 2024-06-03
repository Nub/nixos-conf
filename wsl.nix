{...}:
{
  networking.hostName = "zwlt";

  networking.interfaces.wlp2s0.useDHCP = true;

  services.wfb.profiles = ["drone"];
}
