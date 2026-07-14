{ pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    size = 24;

    # INFO: To find out the name of a cursor theme, build the package
    # and check the `cursor.theme` files in the `result` directory

    # package = pkgs.qogir-icon-theme;
    # name = "Qogir";

    # package = pkgs.bibata-cursors;
    # name = "Bibata-Modern-Ice";

    # package = pkgs.google-cursor;
    # name = "GoogleDot-White";

    package = pkgs.phinger-cursors;
    name = "phinger-cursors-light";
  };

  # If not set, some applications do not respect the cursor theme (eg. firefox)
  # See https://github.com/NixOS/nixpkgs/issues/207339
  gtk = {
    enable = true;
  };
}
