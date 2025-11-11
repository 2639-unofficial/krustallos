{ ... }:

{
  nix = {
    # Enable automatic garbage collection
    # NOTE: Currently performed by nh
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 7d";
    # };

    settings = {
      # Enable flakes and new `nix` command
      experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
      # Deduplicate and optimize nix store
      # PERF: Could cause I/O overhead; consider running `nix store optimise`
      # manually, or setting `nix.optimise` instead
      auto-optimise-store = true;
    };
  };

  # Nix CLI helper
  # NOTE: The flake option is set via home-manager so
  # we don't have to hardcode the home directory
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };
}
