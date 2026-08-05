{
  # inputs,
  krustallos,
  pkgs,
  ...
}:
let
  zjstatus_wasm = pkgs.zellijPlugins.zjstatus;
  # zjstatus_wasm = "${inputs.zjstatus.packages.${krustallos.system}.default}/bin/zjstatus.wasm";
in
{
  programs.zellij = {
    enable = true;
  };

  home.shellAliases = {
    zj = "zellij";
  };

  xdg.configFile = {
    # NOTE: Replace @zjstatus_wasm@ with the actual wasm location
    "zellij/layouts/default.kdl".source = pkgs.replaceVars ./zellij/layouts/default.kdl { inherit zjstatus_wasm; };
  } // krustallos.ln [
    "zellij/config.kdl"
  ];
}
