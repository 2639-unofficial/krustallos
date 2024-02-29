# Home-manager configuration
# Man page: home-configuration.nix(5)
# Manual: `home-manager-help`

{ inputs, config, pkgs, ... }:

{
  home.username = "unofficial";
  home.homeDirectory = "/home/unofficial";

  imports = [
    ./bash.nix
    ./helix.nix
    ./zellij.nix
  ];

  # User packages
  home.packages = with pkgs; [
    firefox
    btop
    neofetch
    pfetch
    wezterm
    just
    fzf
  ];

  # Open the HTML manual with `home-manager-help`
  manual.html.enable = true;

  # Nicely reload system units when switching configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
