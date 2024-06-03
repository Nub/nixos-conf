{ ... }: {
  networking.wireless.enable = true;
  networking.wireless.userControlled.enable = true;
  networking.wireless.networks.BigHertz.pskRaw =
    "854f1b64defc9af6df1ff49c176717aaa69f4b689b95a164e593032c320bcd4c";
  networking.wireless.networks.THAYER-5G-1.psk = "timisking";
}
