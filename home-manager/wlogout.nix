{ pkgs, ... }:

{
  programs.wlogout = {
    enable = true;

    style = let
      main-bg = "#000000";
      main-fg = "#ffffff";
      focus-bg = "#0c0e0f";
      popup-bg = "#000000";
      popup-fg = "#f0cabf";

      # TODO: Scale dynamically with the monitor size
      font-size = toString 16;
      frame-radius = toString 40;
      frame-margin = toString 280;
      popup-radius = toString 25;
      popup-margin = toString 230;

      # icon-file = name: "${pkgs.wlogout}/share/wlogout/assets/${name}.svg";
      icon-file = name: "${pkgs.wleave}/share/wleave/icons/${name}.svg";
      icon = name: "image(url(\"${icon-file name}\"))";
    in /* css */ ''
      * {
        background-image: none;
        font-family: monospace;
        font-size: ${font-size}px;
      }

      window {
        background-color: rgba(240, 202, 191, 0.1);
      }

      button {
        color: ${main-fg};
        background-color: ${main-bg};
        outline-style: none;
        border: none;
        border-width: 0px;
        border-radius: 0px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 20%;
        box-shadow: none;
        text-shadow: none;
      }

      button:focus {
        background-color: ${focus-bg};
        background-size: 30%;
      }

      button:hover {
        color: ${popup-fg};
        background-color: ${popup-bg};
        background-size: 40%;
        border-radius: ${popup-radius}px;
        transition: all 0.3s cubic-bezier(.2, .2, .3, 1.7);
      }

      button:hover#lock {
        border-radius: ${popup-radius}px;
        margin : ${popup-margin}px 0px ${popup-margin}px ${frame-margin}px;
      }

      button:hover#logout,
      button:hover#suspend,
      button:hover#shutdown,
      button:hover#hibernate {
        border-radius: ${popup-radius}px;
        margin : ${popup-margin}px 0px ${popup-margin}px 0px;
      }

      button:hover#reboot {
        border-radius: ${popup-radius}px;
        margin : ${popup-margin}px ${frame-margin}px ${popup-margin}px 0px;
      }

      #lock {
        background-image: ${icon "lock"};
        border-radius: ${frame-radius}px 0px 0px ${frame-radius}px;
        margin : ${frame-margin}px 0px ${frame-margin}px ${frame-margin}px;
      }

      #hibernate {
        background-image: ${icon "hibernate"};
        border-radius: 0px 0px 0px 0px;
        margin : ${frame-margin}px 0px ${frame-margin}px 0px;
      }

      #logout {
        background-image: ${icon "logout"};
        border-radius: 0px 0px 0px 0px;
        margin : ${frame-margin}px 0px ${frame-margin}px 0px;
      }

      #shutdown {
        background-image: ${icon "shutdown"};
        border-radius: 0px 0px 0px 0px;
        margin : ${frame-margin}px 0px ${frame-margin}px 0px;
      }

      #suspend {
        background-image: ${icon "suspend"};
        border-radius: 0px 0px 0px 0px;
        margin : ${frame-margin}px 0px ${frame-margin}px 0px;
      }

      #reboot {
        background-image: ${icon "reboot"};
        border-radius: 0px ${frame-radius}px ${frame-radius}px 0px;
        margin : ${frame-margin}px ${frame-margin}px ${frame-margin}px 0px;
      }
    '';
  };
}
