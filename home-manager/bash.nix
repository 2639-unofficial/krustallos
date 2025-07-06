{ options, ... }:
let
  shellOptionsDefault = options.programs.bash.shellOptions.default;
in
{
  programs.bash = {
    enable = true;

    shellAliases = {
      # Basics
      l = "ls -Alh --color=auto";
      "c-" = "cd -";
      ".." = "cd ..";
      "..." = "cd ../..";
      "chx" = "chmod u+x";

      # Fast scroll back buffer clearing, like `clear`
      rst = "tput reset";

      # Check $PATH
      # path = "echo $PATH | tr ':' '\n'";
      # path = "echo $PATH | sed 's/:/\n/g'";
      path = "echo $PATH | awk --assign=RS=':' '{print}'";
    };

    initExtra = /* bash */ ''
      # Create every dir along the path and cd to the path
      mkcd() {
        mkdir -p "$@" && cd "$_"
      }

      # Return to project root
      rpr() {
        local root
        root=$(git rev-parse --show-toplevel 2>/dev/null) || {
            echo "Error: Not inside a Git repository." >&2
            return 1
        }
        cd "$root"
      }

      # Show directory contents when changing to a new directory,
      # with a size threshold to avoid performance hit
      export PROMPT_COMMAND='
        if [[ -n "$__new_workdir" && "$PWD" != "$__new_workdir" ]]; then
          file_count=$(find "$PWD" -maxdepth 1 -type f | wc -l)
          if [[ $file_count -lt 1000 ]]; then
            l
          fi
        fi
        __new_workdir=$PWD
        '
    '';

    shellOptions = shellOptionsDefault ++ [ "autocd" ];
  };

  programs.readline = {
    enable = true;
    includeSystemConfig = true;
    variables = {
      completion-ignore-case = true;
    };
  };
}
