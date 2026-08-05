{ pkgs, krustallos, ... }:

{
  # Workaround before niri supports binding submaps
  # See also https://github.com/YaLTeR/niri/issues/846
  home.packages = with pkgs; [
    wlr-which-key
  ];

  xdg.configFile = krustallos.ln [ "wlr-which-key" ];
}
