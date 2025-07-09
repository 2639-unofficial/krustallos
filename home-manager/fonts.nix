{ pkgs, ... }:
let
  apple-color-emoji = pkgs.callPackage ../pkgs/apple-color-emoji.nix { };
in
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # andika
    apple-color-emoji
    atkinson-hyperlegible
    atkinson-hyperlegible-next
    # atkinson-hyperlegible-mono
    cascadia-code
    commit-mono
    crimson-pro
    departure-mono # Checkout the website @ https://departuremono.com!
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
    nerd-fonts.inconsolata
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    ttf-tw-moe
    ocr-a
  ];
}
