{ pkgs, ... }:

{
  # INFO: https://wiki.nixos.org/wiki/FAQ#I've_downloaded_a_binary%2C_but_I_can't_run_it%2C_what_can_I_do%3F
  programs.nix-ld = {
    enable = true;
    libraries = pkgs.steam-run.args.multiPkgs pkgs;
  };

  # https://fzakaria.com/2025/02/26/nix-pragmatism-nix-ld-and-envfs.html
  # services.envfs = {
  #   enable = true;
  # };
}
