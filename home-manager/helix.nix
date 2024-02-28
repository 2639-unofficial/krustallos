{ inputs, pkgs, ... }:
let
  helix = inputs.helix.packages.${pkgs.system}.default;
in
{
  programs.helix = {
    enable = true;
    package = helix;
    defaultEditor = true;
  };

  xdg.configFile.helix.source = ./helix;
}
