{ inputs, config, pkgs, system, ... }:
let
  # Skips the input but impurifies the build (use --impure to rebuild)
  # helix = (builtins.getFlake "github:helix-editor/helix/master").packages.${system}.default;

  helix = inputs.helix.packages.${system}.default;
  config-path = "${config.home.homeDirectory}/krustallos/home-manager/helix";
in
{
  programs.helix = {
    enable = true;
    package = helix;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # Nix
      nil
      nixd
      # HTML, CSS, JSON, ESLint
      vscode-langservers-extracted
    ];
  };

  home.packages = with pkgs; [
    # Command runner for unified scripting interface
    just
  ];

  home.shellAliases = {
    hxc = "hx ${config.xdg.configHome}";
    jst = "just";
  };

  # xdg.configFile.helix = {
  #   source = ./helix;
  #   recursive = true;
  # };

  xdg.configFile."helix".source = config.lib.file.mkOutOfStoreSymlink config-path;
}
