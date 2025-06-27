# Home-manager configuration
# Man page: home-configuration.nix(5)
# Manual: `home-manager-help`

{ inputs, pkgs, ... }:

{
  home.username = "unofficial";
  home.homeDirectory = "/home/unofficial";

  imports = [
    ./cursor.nix
    ./fonts.nix
    ./niri.nix
    ./wezterm.nix
  ] ++ [
    ./bash.nix
    ./direnv.nix
    ./distrobox.nix
    ./git.nix
    ./helix.nix
    ./tealdeer.nix
    ./yazi.nix
    ./zellij.nix
  ] ++ [
    ./fun.nix
  ];

  # User packages
  home.packages = with pkgs; [
    firefox
    ghostty
    # losslesscut-bin # FFmpeg gui
    # mixxc          # Volume mixer widget
    # oculante       # image viewer
    pavucontrol    # Sound control
    sioyek         # PDF reader
    zathura        # PDF reader
  ] ++ [
    btop
    comma          # Auto nix run
    dust           # Disk usage
    freeze         # Screenshot for code
    nitch          # Pretty fetch in Nim
    pfetch-rs
    tokei          # Line count
    ouch           # (De)Compressor
    ripdrag        # Floating drag and drop
    ripgrep
    systemctl-tui
    fd
    # hyperfine      # Benchmarking
    wl-clipboard-rs
  ];

  # Ensure proper shell integration
  programs.fzf.enable = true;
  programs.eza.enable = true;
  programs.eza.git = true;

  # `nix run n#hello` with ease!
  # QUESTION: System registry or user registry, where to place it?
  nix.registry = {
    n.flake = inputs.nixpkgs;
  };

  # Locate nixpkgs binary
  programs.nix-index.enable = true;

  # Open the HTML manual with `home-manager-help`
  manual.html.enable = true;

  # Nicely reload system units when switching configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
