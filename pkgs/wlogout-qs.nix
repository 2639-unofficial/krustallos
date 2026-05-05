{
  lib,
  stdenvNoCC,
  makeWrapper,
  quickshell,
  wleave,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "wlogout-qs";
  version = "26.09";

  src = ./wlogout-qs;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dt $out/share/quickshell/wlogout-qs $src/*

    # Use the svg icons from wleave
    substituteInPlace $out/share/quickshell/wlogout-qs/LogoutButton.qml \
      --replace-fail "icons/" "${wleave}/share/wleave/icons/"

    makeWrapper ${lib.getExe quickshell} $out/bin/wlogout-qs \
      --add-flags "-p $out/share/quickshell/wlogout-qs/shell.qml"

    runHook postInstall
  '';

  meta = {
    description = "A personal quickshell replica of wlogout";
    mainPrograms = "wlogout-qs";
    platform = lib.platforms.linux;
  };
})
