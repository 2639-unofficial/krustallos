{ pkgs, ... }:

{
  # TODO: Config (theming)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = [ pkgs.fcitx5-chewing ];
    };
  };
}
