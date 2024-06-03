{...}:
{
  networking.hostName = "nixos";

  networking.interfaces.enp0s1.useDHCP = true;
  networking.interfaces.enp0s2.useDHCP = true;

  services.wfb.profiles = ["gcs"];
}
