{ pkgs, krustallos, ... }:

{
  # For wayland related systemd services like waybar and awww
  wayland.systemd.target = "niri.service";

  home.packages = with pkgs; [
    brightnessctl
    libnotify   # Notify-send
    hyprpicker  # Color picker
    # satty       # Screenshot annotation, might want to checkout github:AlexanderVanhee/Gradia
    wayscriber  # Real-time screen annotation tool
    wlrctl      # Wayland cli util
    xwayland-satellite
  ];

  services.awww.enable = true;

  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;

  programs.fuzzel.enable = true;

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

  # services.swayidle.enable = true;
  # programs.swaylock.enable = true;

  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  xdg.configFile = {
    "waybar/nix-snowflake-24x24.png".source = "${pkgs.nixos-icons}/share/icons/hicolor/24x24/apps/nix-snowflake.png";
  } // krustallos.ln [
    "niri"
    "waybar/color.css"
    "waybar/style.css"
    "waybar/config.jsonc"
    "fuzzel"
    "hypr/hypridle.conf"
    "hypr/hyprlock.conf"
  ];
}
