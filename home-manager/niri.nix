{ config, inputs, pkgs, krustallos-path, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;

  config-path = {
    niri   = "${krustallos-path}/home-manager/niri";
    waybar = "${krustallos-path}/home-manager/waybar";
    fuzzel = "${krustallos-path}/home-manager/fuzzel";
  };
in
{
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  xdg.configFile."niri".source = mkOutOfStoreSymlink config-path.niri;

  home.packages = with pkgs; [
    awww        # Wallpaper
    brightnessctl
    libnotify   # Notify-send
    hyprpicker  # Color picker
    # satty       # Screenshot annotation, might want to checkout github:AlexanderVanhee/Gradia
    wayscriber  # Real-time screen annotation tool
    wlrctl      # Wayland cli util
    xwayland-satellite
  ];

  programs.waybar.enable = true;
  xdg.configFile."waybar/style.css".source = mkOutOfStoreSymlink "${config-path.waybar}/style.css";
  xdg.configFile."waybar/config.jsonc".source = mkOutOfStoreSymlink "${config-path.waybar}/config.jsonc";
  xdg.configFile."waybar/nix-snowflake-24x24.png".source = "${pkgs.nixos-icons}/share/icons/hicolor/24x24/apps/nix-snowflake.png";

  programs.fuzzel.enable = true;
  xdg.configFile."fuzzel".source = mkOutOfStoreSymlink config-path.fuzzel;

  programs.tofi.enable = true;

  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      font = "JetBrains Mono 11";
      padding = "15,20";
      background-color = "#0c0e0ff0";
      text-color = "#ffffff";
      border-size = 2;
      border-color = "#f0cabf";
      default-timeout = 0;
      markup = true;
      format = "<b>%s</b>\\n\\n%b";
    };
  };
  # services.swaync.enable = true;
  # services.dunst.enable = true;

  programs.swaylock.enable = true;
}
