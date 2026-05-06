{ config, krustallos, pkgs, ... }:

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
      # See https://github.com/justinsteven/advisories/blob/main/2022_git_buried_bare_repos_and_fsmonitor_various_abuses.md
      safe.bareRepository = "explicit";
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

  # See https://docs.github.com/en/github-cli/github-cli/github-cli-telemetry#how-to-opt-out
  # via https://blog.gslin.org/archives/2026/04/23/13007/github-cli-預設會收集-telemetry-資料/
  home.sessionVariables = {
    GH_TELEMETRY = false;
    DO_NOT_TRACK = true;
  };

  home.packages = with pkgs; [
    jujutsu
    jj-fzf
  ];

  # NOTE: There is also a jujutsu home-manager module, but the
  # out-of-store symlink is more convenient for experimenting
  xdg.configFile = let
      inherit (config.lib.file) mkOutOfStoreSymlink;
  in {
    "jj/config.toml".source = mkOutOfStoreSymlink "${krustallos.path}/home-manager/jj/config.toml";

    "jj/conf.d/krustallos.toml".source = pkgs.replaceVars ./jj/conf.d/krustallos.toml { krustallos_path = krustallos.path; };
  };
}
