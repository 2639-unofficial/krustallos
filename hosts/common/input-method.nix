{ pkgs, ... }:

{
  # TODO: Config (theming)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-chewing
        fcitx5-mcbopomofo
        fcitx5-mellow-themes
        fcitx5-mozc-ut
      ];
    };
  };
}
