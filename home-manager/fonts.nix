{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    atkinson-hyperlegible
    cascadia-code
    commit-mono
    crimson-pro
    font-awesome
    geist-font
    ibm-plex
    inter
    iosevka
    jetbrains-mono
    lexend
    liberation_ttf
    libertinus
    monaspace
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    ocr-a
  ];
}
