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

      font-size = "16px";
      frame-radius = "40px";
      popup-radius = "25px";

      # For large screen
      # TODO: Scale dynamically with the monitor size
      frame-margin = "280px";
      popup-margin = "230px";

      # For small screen
      # frame-margin = "20px";
      # popup-margin = "2px";

      # icon-file = name: "${pkgs.wlogout}/share/wlogout/assets/${name}.svg";
      icon-file = name: "${pkgs.wleave}/share/wleave/icons/${name}.svg";
      icon = name: "image(url(\"${icon-file name}\"))";
    in /* css */ ''
      * {
        background-image: none;
        font-family: monospace;
        font-size: ${font-size};
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
        border-radius: ${popup-radius};
        transition: all 0.3s cubic-bezier(.2, .2, .3, 1.7);
      }

      button:hover#lock {
        border-radius: ${popup-radius};
        margin: ${popup-margin} 0px ${popup-margin} ${frame-margin};
      }

      button:hover#logout,
      button:hover#suspend,
      button:hover#shutdown,
      button:hover#hibernate {
        border-radius: ${popup-radius};
        margin: ${popup-margin} 0px ${popup-margin} 0px;
      }

      button:hover#reboot {
        border-radius: ${popup-radius};
        margin: ${popup-margin} ${frame-margin} ${popup-margin} 0px;
      }

      #lock {
        background-image: ${icon "lock"};
        border-radius: ${frame-radius} 0px 0px ${frame-radius};
        margin: ${frame-margin} 0px ${frame-margin} ${frame-margin};
      }

      #hibernate {
        background-image: ${icon "hibernate"};
        border-radius: 0px 0px 0px 0px;
        margin: ${frame-margin} 0px ${frame-margin} 0px;
      }

      #logout {
        background-image: ${icon "logout"};
        border-radius: 0px 0px 0px 0px;
        margin: ${frame-margin} 0px ${frame-margin} 0px;
      }

      #shutdown {
        background-image: ${icon "shutdown"};
        border-radius: 0px 0px 0px 0px;
        margin: ${frame-margin} 0px ${frame-margin} 0px;
      }

      #suspend {
        background-image: ${icon "suspend"};
        border-radius: 0px 0px 0px 0px;
        margin: ${frame-margin} 0px ${frame-margin} 0px;
      }

      #reboot {
        background-image: ${icon "reboot"};
        border-radius: 0px ${frame-radius} ${frame-radius} 0px;
        margin: ${frame-margin} ${frame-margin} ${frame-margin} 0px;
      }
    '';
  };
}
