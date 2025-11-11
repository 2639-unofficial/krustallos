{ config, pkgs, ... }:

{
  programs.nushell = {
    enable = true;

    shellAliases = {
      # Not overriding `ls` in nushell as it is sometimes useful
      l = "eza -Alh";
      lt = "eza --tree";

      "c-" = "cd -";
    };

    extraConfig = /* nu */ ''
      # How to make nushell match hidden files only when there is a "." prefix?
      # Related: https://github.com/nushell/nushell/issues/16106
      $env.config.completions.algorithm = "fuzzy" # prefix, substring, fuzzy
    '';
  };

  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;
  programs.carapace.enableBashIntegration = false;

  programs.eza.enableNushellIntegration = false;

  # Disable starship before it is properly setup
  programs.starship.enableNushellIntegration = false;

  programs.bash.shellAliases = {
    # Exec nushell (any better idea?)
    ens = "exec nu";
  };
}
