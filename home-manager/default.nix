# Home-manager configuration
# Man page: home-configuration.nix(5)
# Manual: `home-manager-help`

{ config, inputs, lib, pkgs, ... }:

{
  # Extra arguments that get passed to imported nix modules
  _module.args = {
    # A dedicated namespace to prevent potential name collisions with future upstream arguments
    krustallos = {
      inherit (pkgs.stdenv.hostPlatform) system;

      # The impure path of this flake
      # SAFETY: To avoid infinite recursion, `home.homeDirectory` must be set
      # before importing this file
      path = "${config.home.homeDirectory}/krustallos";
    };
  };

  imports = let
    cli = [
      ./bash.nix
      ./direnv.nix
      ./distrobox.nix
      ./git.nix
      ./helix.nix
      ./nushell.nix
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
      ./wl-kbptr.nix
      ./wlogout.nix
      ./wlr-which-key.nix
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
    crosspipe          # Pipewire graph
    # discord
    firefox
    fractal            # Matrix client (text selection bug: https://gitlab.gnome.org/World/fractal/-/issues/1088)
    ghostty
    # koreader           # Ebook reader
    # losslesscut-bin    # FFmpeg gui
    # mixxc              # Volume mixer widget
    obsidian             # Local-first note-taking with markdown (foss alt: logseq)
    # oculante           # Image viewer
    pavucontrol        # Sound control
    # planify            # Task manager / Todo list
    pwvucontrol        # Pipewire volume control
    readest            # Ebook reader
    # rnote              # Handwritten notes
    sioyek             # PDF reader
    # sniffnet           # Network monitor
    vesktop            # Discord with Vencord
    zathura            # PDF reader
  ] ++ [
    btop
    bluetui            # Bluetooth manager
    charm-freeze       # Screenshot for code
    comma              # Auto nix run (TODO: Replace with https://github.com/nix-community/nix-index-database)
    dig                # DNS utilities
    dust               # Disk usage
    fd
    # gibo               # gitignore boilerplates
    hexyl              # Hex viewer
    # hyperfine          # Benchmarking
    nitch              # Pretty fetch in Nim
    # nix-inspect        # Interactively dissect nix config
    # numbat             # Featureful Calculator
    pfetch-rs
    tokei              # Line count
    ouch               # (De)Compressor
    # rdap               # Registration data
    # rip2               # Safe rm (xdg-trash alt, recycle)
    ripdrag            # Floating drag and drop
    ripgrep
    systemctl-tui
    # vulnix             # CVE scanner for nix
    wl-clipboard-rs
  ];

  home.shellAliases = {
    sctui = "systemctl-tui";
  };

  # Ensure proper shell integration
  programs.fzf.enable = true;
  programs.eza.enable = true;
  programs.eza.git = true;

  # TODO: Try using keepassxc as the org.freedesktop.secrets dbus service with a new kdbx vault
  programs.keepassxc.enable = true;

  gtk.gtk4.theme = null;

  # Automouting USB drives
  # REF: https://wiki.nixos.org/wiki/USB_storage_devices
  services.udiskie = {
    enable = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/632
    settings.program_options.file_manager = "${pkgs.xdg-utils}/bin/xdg-open";
  };

  programs.man = {
    enable = true;
    generateCaches = true;
  };

  # Nix CLI helper
  # NOTE: nh only cleanups the user profile when GC is enabled via home-manager
  #       So it's better to utilize the nixos options for cleaning
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/krustallos";
  };

  # `nix run n#hello` with ease!
  # NOTE: Setting an entry in the user registry, instead of the system registry,
  # makes it OS-agnostic, and is thus more desirable
  # TODO: Try out https://github.com/numtide/nixpkgs-unfree to run unfree
  # packages without `NIXPKGS_ALLOW_UNFREE=1 nix run --impure ...`
  nix.registry = {
    n.flake = inputs.nixpkgs;
  };

  # Locate nixpkgs binary
  # TODO: Consider replacing it with https://github.com/nix-community/nix-index-database
  programs.nix-index.enable = true;

  # Open the HTML manual with `home-manager-help`
  manual.html.enable = true;

  # Nicely reload system units when switching configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
