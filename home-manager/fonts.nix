{ pkgs, ... }:
let
  apple-color-emoji = pkgs.callPackage ../pkgs/apple-color-emoji.nix { };
in
{
  fonts.fontconfig.enable = true;

  # fonts.fontconfig.defaultFonts = {
  #   serif = [ "Libertinus Serif" ];
  #   sansSerif = [ "Atkinson Hyperlegible Next" ];
  #   monospace = [ "JetBrains Mono" ];
  #   # NOTE: For firefox, the default emoji font still need to be set via the
  #   # `font.name-list.emoji` preference in about:config
  #   emoji = [ "Apple Color Emoji" ];
  # };

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
    icomoon-feather
    inter
    iosevka
    jetbrains-mono
    # jigmo          # Serif CJKV font
    lexend
    liberation_ttf
    libertinus
    monaspace
    # nerd-fonts.fantasque-sans-mono
    nerd-fonts.inconsolata
    # nerd-fonts.iosevka
    # nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    ttf-tw-moe
    ocr-a
  ];
}
