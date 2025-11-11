{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      alias = {
        ap = "add --patch";
        b = "branch";
        c = "commit";
        co = "checkout";
        d = "diff";
        ds = "diff --staged";
        lg = "log --pretty=oneline --graph --decorate --all";
        p = "pull";
        snapshot = "!date '+Snapshot %Y-%m-%d %a %H:%M' | git commit -F -"; # Create a WIP commit
        st = "status --short";
        sta = "status";
        sw = "switch";
        uncommit = "reset --soft HEAD^";
        unstage = "restore --staged";
      };

      commit.verbose = true;
      init.defaultBranch = "main";
      merge.conflictsytle = "zdiff3";
      push.autosetupremote = true;
      pull.rebase = true;
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };

    # Set to the new home-manager default value to get rid of the eval warning
    signing.format = null;
  };

    # Alternatives: difftastic or diff-so-fancy
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        dark = true;
        navigate = true;
        syntax-theme = "OneHalfDark";
        features = "side-by-side line-numbers decorations"; # hyperlinks
        whitespace-error-style = "22 reverse";
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-style = "bold yellow ul";
          file-decoration-style = "none";
          hunk-header-decoration-style = "cyan box ul";
        };
      };
    };

  home.shellAliases = {
    g = "git";
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
    gitCredentialHelper.enable = true;
  };

  # EXPERIMENTAL: Trying out jj
  programs.jujutsu = {
    enable = true;
  };

  home.packages = [
    pkgs.jj-fzf
  ];
}
