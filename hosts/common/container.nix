{ ... }:

{
  virtualisation.podman = {
    enable = true;

    # Create a `docker` alias for podman, to use it as a drop-in replacement
    dockerCompat = true;

    # Required for containers under podman-compose to be able to talk to each other
    defaultNetwork.settings.dns_enabled = true;
  };

  # NOTE: See https://wiki.nixos.org/wiki/Waydroid, https://docs.waydro.id/,
  #       and https://wiki.archlinux.org/title/Waydroid for usage
  # NOTE: Usable but the UX isn't great (e.g. zooming in google map requires
  #       double clicking the left mouse btn then dragging the mouse up or down;
  #       related: https://github.com/waydroid/waydroid/issues/1087)
  # NOTE: Also, `waydroid prop set persist.waydroid.fake_touch "*"` does not
  #       work in GraspJPN, a Japanese vocabulary app
  # virtualisation.waydroid.enable = true;
}
