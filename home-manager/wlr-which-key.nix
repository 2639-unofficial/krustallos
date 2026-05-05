{ config, pkgs, krustallos, ... }:
let
  config-path = "${krustallos.path}/home-manager/wlr-which-key";
in
{
  # Workaround before niri supports binding submaps
  # See also https://github.com/YaLTeR/niri/issues/846
  home.packages = with pkgs; [
    wlr-which-key
  ];

  xdg.configFile."wlr-which-key".source = config.lib.file.mkOutOfStoreSymlink config-path;
}
