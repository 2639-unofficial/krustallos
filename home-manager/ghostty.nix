{
  krustallos,
  ...
}:

{
  programs.ghostty = {
    enable = true;
  };

  xdg.configFile = krustallos.ln [ "ghostty/config" ];
}
