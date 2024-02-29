{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
  };
}
