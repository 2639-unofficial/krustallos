{ inputs, pkgs, ... }:
let
  helix = inputs.helix.packages.${pkgs.system}.default;
in
{
  programs.helix = {
    enable = true;
    package = helix;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # Nix
      nil
    ];
  };

  xdg.configFile.helix.source = ./helix;
}
