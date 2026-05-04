{ inputs, ... }:

{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    # Prerequisite: Set `services.flatpak.enable` to true in the NixOS config
    enable = true;

    # Enable auto gc, and allow imperative operations (trading purity for convenience)
    uninstallUnused = true;
    uninstallUnmanaged = false;

    # Update apps weekly with a systemd timer, instead of on activations
    update.auto.enable = true;
    update.onActivation = false;

    packages = [
      { appId = "com.brave.Browser"; origin = "flathub"; }
      "app.zen_browser.zen"
      "com.discordapp.Discord"
      # "dev.vencord.Vesktop"
      # "de.schmidhuberj.tubefeeder" # Pipeline (Youtube frontend)

      # "com.github.k4zmu2a.spacecadetpinball" # Reversed-engineered Space Cadet Pinball game from Windows
    ];
  };

  # Set up font permissions:
  #   flatpak --user override --filesystem=/nix/store:ro
  #   flatpak --user override --filesystem=xdg-data/fonts:ro
  #   flatpak --user override --filesystem=xdg-config/fontconfig:ro
  # Update font files in $XDG_DATA_HOME/fonts (mkdir omitted):
  #   chmod -R u+w $XDG_DATA_HOME/fonts/*
  #   rm -f $XDG_DATA_HOME/fonts/*
  #   cp -LR /run/current-system/sw/share/X11/fonts/* $XDG_DATA_HOME/fonts/
  #   cp -LR $HOME/.nix-profile/share/fonts/* $XDG_DATA_HOME/fonts/

  # Note on how to avoid `/nix/store:ro` for fontconfig
  # https://github.com/ryan4yin/nixos-and-flakes-book/discussions/276
}
