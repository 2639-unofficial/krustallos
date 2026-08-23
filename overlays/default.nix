{ inputs, ... }:

{
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    # Update jj-fzf
    jj-fzf = (
      prev.lib.warnIf (prev.lib.versionOlder "0.38.0" prev.jj-fzf.version)
        "jj-fzf > 0.38.0 is now in nixpkgs, the override can be removed."
        (
          prev.jj-fzf.overrideAttrs {
            version = "0.42.0";
            src = inputs.jj-fzf;
            patches = [ ./jj-fzf-preflight.patch ];
          }
        )
    );
  };
}
