{
  description = "krustallos: systems formed by nix and flakes";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Lockable HTTP Tarball from the nix infra (hydra)
    # See the discussions in https://discourse.nixos.org/t/inputs-nixpkgs-from-flakehub/69095/
    # nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Disko
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Helix editor
    helix.url = "github:helix-editor/helix/master";
    helix.inputs.nixpkgs.follows = "nixpkgs";

    # # Niri compositor
    # niri.url = "github:sodiboo/niri-flake/main";
    # niri.inputs.nixpkgs.follows = "nixpkgs";

    # Statusbar plugin for Zellij (is in nixpkgs now)
    # zjstatus.url = "github:dj95/zjstatus/main";
    # zjstatus.inputs.nixpkgs.follows = "nixpkgs";

    # Declarative flatpak manager; useful for GUI programs and basic bubblewrap sandbox
    # Related: [NixOS-integrated Flatpak package management](https://github.com/NixOS/nixpkgs/pull/347605)
    nix-flatpak.url = "github:gmodena/nix-flatpak/main";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }: {
    # Local modifications to nixpkgs
    overlays = import ./overlays { inherit inputs; };

    # Custom packages, accessible through `nix build` and `nix shell`
    # Consider `pkgs.extend self.overlays.modifications` or instantiating an overlayed nixpkgs if needed
    packages = builtins.mapAttrs (system: pkgs: import ./pkgs pkgs) nixpkgs.legacyPackages;

    # NixOS configuration entry point
    nixosConfigurations = {
      mfm8s = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/mfm8s/configuration.nix ];
      };
      vbs14 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/vbs14/configuration.nix ];
      };
    };

    # Home manager configuration entry point
    homeConfigurations = {
      "unofficial@mfm8s" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./hosts/mfm8s/home.nix ];
      };
      "endi@vbs14" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./hosts/vbs14/home.nix ];
      };
    };
  };

  # INFO: Nix stores the options to $HOME/.local/share/nix/trusted-settings.json
  # when user agrees to "permanently trust" the settings
  # Also see https://kokada.dev/blog/quick-bits-where-does-nix-store-flakes-trusted-settings/
  # nixConfig = {
  #   # NOTE: These options do not work for two reasons:
  #   # 1) Without `accept-flake-config` being enabled, only a small portion of
  #   #    options are allowed here. See section nix3-flake#flake-format in the
  #   #    nix manual for more details.
  #   # 2) Without the user being added to `trusted-users`, the `trusted-public-keys`
  #   #    option will be ignored, even if the user is added to `allowed-users` and
  #   #    the `trusted-substituters` option is properly set.
  #   #    See https://github.com/NixOS/nix/issues/1921
  #   #    Related: https://github.com/nixos/nix/issues/8973
  #   #    However, being added to `trusted-users` poses a critical security risk,
  #   #    per https://github.com/NixOS/nix/issues/9649#issuecomment-1868001568:
  #   #    > With your user in trusted-users:
  #   #    > ```bash
  #   #    > sudo2() {
  #   #    >   NIX_CONFIG="post-build-hook = $@" nix build nixpkgs#hello --rebuild --print-build-logs;
  #   #    > }
  #   #    > ```
  #   #    > Brand new sudo, now without password!
  #   extra-trusted-substituters = [ "https://helix.cachix.org" ];
  #   extra-trusted-public-keys = [ "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs=" ];
  # };
}
