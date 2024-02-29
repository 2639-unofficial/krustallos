{ pkgs, config, ...}:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      # Basic
      l = "ls -Alh --color=auto";
      ".." = "cd ..";
      "..." = "cd ...";

      # Fast scroll back buffer clearing, like `clear`
      rst = "tput reset";
    };

    initExtra = ''
      # Create every dir along the path and cd to the path
      mkcd() {
        mkdir -p "$@" && cd "$_"
      }

      # cd up a number of directories
      up() {
        local d=""
        local limit="$1"

        # Default to limit of 1
        if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
          limit=1
        fi

        for ((i=1;i<=limit;i++)); do
          d="../$d"
        done

        # perform cd. Show error if cd fails
        if ! cd "$d"; then
          echo "Can't move up $limit directories.";
        fi
      }
    '';
  };
}

