# Home-manager configuration
# Man page: home-configuration.nix(5)
# Manual: `home-manager-help`

{ config, inputs, lib, pkgs, ... }:

{
  imports = let
    cli = [
      ./bash.nix
      ./direnv.nix
      ./distrobox.nix
      ./git.nix
      ./helix.nix
      ./tealdeer.nix
      ./yazi.nix
      ./zellij.nix
    ];

    gui = [
      ./cursor.nix
      ./fonts.nix
      ./wezterm.nix
    ];

    niri = [
      ./niri.nix
      ./wlogout.nix
    ];

    misc = [
      ./fun.nix
    ];
  in lib.lists.flatten [
    cli
    gui
    niri
    misc
  ];

  nixpkgs.config.allowUnfree = true;

  # User packages
  home.packages = with pkgs; [
    firefox
    ghostty
    # koreader           # Ebook reader
    # losslesscut-bin    # FFmpeg gui
    # mixxc              # Volume mixer widget
    # oculante           # Image viewer
    pavucontrol        # Sound control
    pwvucontrol        # Pipewire volume control
    readest            # Ebook reader
    # rnote              # Handwritten notes
    sioyek             # PDF reader
    # sniffnet           # Network monitor
    zathura            # PDF reader
  ] ++ [
    btop
    bluetui            # Bluetooth manager
    charm-freeze       # Screenshot for code
    comma              # Auto nix run
    dust               # Disk usage
    fd
    # gibo               # gitignore boilerplates
    hexyl              # Hex viewser
    # hyperfine          # Benchmarking
    nitch              # Pretty fetch in Nim
    # numbat             # Featureful Calculator
    pfetch-rs
    tokei              # Line count
    ouch               # (De)Compressor
    # rdap               # Registration data
    ripdrag            # Floating drag and drop
    ripgrep
    systemctl-tui
    wl-clipboard-rs
  ];

  # Ensure proper shell integration
  programs.fzf.enable = true;
  programs.eza.enable = true;
  programs.eza.git = true;

  # Nix CLI helper
  # NOTE: nh only cleanups the user profile when GC is enabled via home-manager
  #       So it's better to utilize the nixos options for cleaning
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/krustallos";
  };

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
}
