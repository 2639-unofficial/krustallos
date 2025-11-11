{ pkgs, ... }:

{
  programs.wleave = {
    enable = true;
    settings = let
      icon-path = name: "${pkgs.wleave}/share/wleave/icons/${name}.svg";
    in {
      # margin = 200;
      buttons-per-row = "1/1";
      column-spacing = 0;
      delay-command-ms = 100;
      close-on-lost-focus = true;
      show-keybinds = true;
      buttons = [
        {
            "label" = "lock";
            "action" = "loginctl lock-session";
            "text" = "Lock";
            "keybind" = "l";
            "icon" = icon-path "lock";
        }
        {
            "label" = "hibernate";
            "action" = "systemctl hibernate";
            "text" = "Hibernate";
            "keybind" = "h";
            "icon" = icon-path "hibernate";
        }
        {
            "label" = "logout";
            "action" = "loginctl terminate-user $USER";
            "text" = "Logout";
            "keybind" = "e";
            "icon" = icon-path "logout";
        }
        {
            "label" = "shutdown";
            "action" = "systemctl poweroff";
            "text" = "Shutdown";
            "keybind" = "s";
            "icon" = icon-path "shutdown";
        }
        {
            "label" = "suspend";
            "action" = "systemctl suspend";
            "text" = "Suspend";
            "keybind" = "u";
            "icon" = icon-path "suspend";
        }
        {
            "label" = "reboot";
            "action" = "systemctl reboot";
            "text" = "Reboot";
            "keybind" = "r";
            "icon" = icon-path "reboot";
        }
      ];
    };
  };
}
