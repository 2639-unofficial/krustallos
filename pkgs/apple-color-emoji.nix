{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  # NOTE: See https://github.com/nixos/nixpkgs/issues/261100 for why it's not included in nixpkgs
  # NOTE: Not using the project's flake due to its long build time
  pname = "apple-color-emoji";
  version = "26-20260722-484daf4e";

  src = fetchurl {
    url = "https://github.com/samuelngs/apple-emoji-ttf/releases/download/macos-${finalAttrs.version}/AppleColorEmoji-linux.ttf";
    hash = "sha256-43x69iZaxKCvbVe8ZehhCad22ZZug0MzRVf2PaSCUW8=";
  };

  # Skip the unpack phase
  dontUnpack = true;

  # NOTE: With EXT4, the ttf file (43 MB) is duplicated, thereby doubling the closure size.
  # Should we `ln -s` instead?
  installPhase = ''
    runHook preInstall
    install -D -m 644 -t "$out/share/fonts/truetype/" $src
    runHook postInstall
  '';

  meta = {
    description = "A derivation for the Apple Color Emoji font";
    homepage = "https://github.com/samuelngs/apple-emoji-ttf";
    platform = lib.platforms.linux;
  };
})
