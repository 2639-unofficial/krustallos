{ ... }:

{
  programs.zellij = {
    enable = true;
  };

  home.shellAliases = {
    zj = "zellij";
  };

  xdg.configFile.zellij.source = ./zellij;
}
