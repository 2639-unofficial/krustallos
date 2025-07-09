{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  # NOTE: See https://github.com/nixos/nixpkgs/issues/261100 for why it's not included in nixpkgs
  # NOTE: Not using the project's flake due to its long build time
  pname = "apple-color-emoji";
  version = "18.4";

  src = fetchurl {
    url = "https://github.com/samuelngs/apple-emoji-linux/releases/download/v${finalAttrs.version}/AppleColorEmoji.ttf";
    hash = "sha256-pP0He9EUN7SUDYzwj0CE4e39SuNZ+SVz7FdmUviF6r0=";
  };

  # Skip the unpack phase
  dontUnpack = true;

  # NOTE: With EXT4, the ttf file (43 MB) is duplicated, thereby doubling the closure size.
  # Should we `ln -s` instead?
  installPhase = ''
    install -D -m 644 -t "$out/share/fonts/truetype/" $src
  '';

  meta = {
    description = "A derivation for the Apple Color Emoji font";
    platform = lib.platforms.all;
  };
})
