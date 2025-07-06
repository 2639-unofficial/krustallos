{ lib, ... }:

{
  # TODO: Try NextDNS

  # REF: https://wiki.nixos.org/wiki/NetworkManager#DNS_Management
  networking = {
    networkmanager.enable = lib.mkDefault true;

    # Disable NetworkManager's internal DNS resolution
    networkmanager.dns = "none";

    # These options are unnecessary when managing DNS ourselves
    useDHCP = false;
    dhcpcd.enable = false;

    # Configure DNS servers manually (this example uses Cloudflare and Google DNS)
    # IPv6 DNS servers can be used here as well.
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      "1.0.0.1"
      "8.8.4.4"
    ];
  };
}
