{ inputs, pkgs, ... }:
let
  zjstatus_wasm = "${inputs.zjstatus.packages.${pkgs.system}.default}/bin/zjstatus.wasm";
in
{
  programs.zellij = {
    enable = true;
  };

  home.shellAliases = {
    zj = "zellij";
  };

  xdg.configFile = {
    "zellij/config.kdl".source = ./zellij/config.kdl;

    # NOTE: Replace @zjstatus_wasm@ with the actual wasm location
    "zellij/layouts/default.kdl".source = pkgs.replaceVars ./zellij/layouts/default.kdl { inherit zjstatus_wasm; };
  };
}
