{ ... }:

{
  # Grant vial access to supported devices with udev rules
  services.udev.extraRules = ''
    # General rule for vial-supported keyboards
    # From https://get.vial.today/manual/linux-udev.html
    # Reload as root with `udevadm control --reload && udevadm trigger`
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"

    # Rule specifically for the Jezail Funder Cornix to be detected from vial
    # Unused since the general rule for vial works
    # KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="e118", ATTRS{idProduct}=="0001", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl" 
  '';
}
