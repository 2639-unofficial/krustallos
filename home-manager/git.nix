{ ... }:

{
  programs.git = {
    enable = true;

    aliases = {
      ap = "add --patch";
      b = "branch";
      c = "commit";
      co = "checkout";
      d = "diff";
      ds = "diff --staged";
      lg = "log --pretty=oneline --graph --decorate --all";
      p = "pull";
      st = "status --short";
      sta = "status";
      sw = "switch";
      unstage = "restore --staged";
    };

    # difftastic.enable = true;
    delta.enable = true;
    delta.options = {
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
    # diff-so-fancy.enable = true;

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autosetupremote = true;
      };
      pull = {
        rebase = true;
      };
      commit = {
        verbose = true;
      };
      merge = {
        conflictsytle = "zdiff3";
      };
      "url \"ssh://git@github.com/\"" = {
        insteadOf = "https://github.com/";
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
}
