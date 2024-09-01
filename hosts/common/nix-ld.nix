{ pkgs, ... }:

{
  # INFO: https://wiki.nixos.org/wiki/FAQ#I've_downloaded_a_binary%2C_but_I_can't_run_it%2C_what_can_I_do%3F
  programs.nix-ld = {
    enable = true;
    libraries = pkgs.steam-run.fhsenv.args.multiPkgs pkgs;
  };
}
