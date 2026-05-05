{ inputs, krustallos, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # TODO: Consider replacing nix-index, comma, and the command-not-found util
  # with the wrapper https://github.com/nix-community/nix-index-database that
  # comes with a weekly updated nix-index db for nixos-unstable channel

  # Locate nixpkgs binary
  programs.nix-index.enable = true;

  home.packages = with pkgs; [
    comma              # Auto nix run
    # nix-inspect        # Interactively dissect nix config
    # vulnix             # CVE scanner for nix
  ];

  # Nix CLI helper
  # NOTE: nh only cleanups the user profile when GC is enabled via home-manager
  #       So it's better to utilize the nixos options for cleaning
  programs.nh = {
    enable = true;
    flake = krustallos.path;
  };

  # `nix run n#hello` with ease!
  # NOTE: Setting an entry in the user registry, instead of the system registry,
  # makes it OS-agnostic, and is thus more desirable
  # TODO: Try out https://github.com/numtide/nixpkgs-unfree to run unfree
  # packages without `NIXPKGS_ALLOW_UNFREE=1 nix run --impure ...`
  nix.registry = {
    n.flake = inputs.nixpkgs;
  };

  # Improves ergonomics with dev shells like `nix develop`
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
