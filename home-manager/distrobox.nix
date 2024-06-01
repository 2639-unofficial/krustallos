{ pkgs, ... }:

{
  home.packages = with pkgs; [
    distrobox
  ];

  home.shellAliases = {
    dbox = "distrobox";
  };
}
