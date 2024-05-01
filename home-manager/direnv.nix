{ ... }:

{
  # Improves ergonomics with dev shells like `nix develop`
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
