{ inputs, pkgs, ... }:

{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # For loading SVG in GTK apps, e.g. wlogout
  # See https://discourse.nixos.org/t/svg-icons-not-shown/32173
  # However, wleave (wlogout riir with gtk4 and refined icons) still doesn't work
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
}
