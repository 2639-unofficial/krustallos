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
      ./distrobox.nix
      ./git.nix
      ./helix.nix
      ./nix.nix
      ./nushell.nix
      ./tealdeer.nix
      ./yazi.nix
      ./zellij.nix
    ];

    gui = [
      ./cursor.nix
      ./flatpak.nix
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

  # User packages
  home.packages = with pkgs; [
    crosspipe          # Pipewire graph
    # discord
    firefox
    fractal            # Matrix client (text selection bug: https://gitlab.gnome.org/World/fractal/-/issues/1088)
    ghostty
    # gnome-commander  # Daul-panel file manager
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
    alsa-utils         # Useful audio related tools like `speaker-test`
    # btop               # Prefer system-level installation for hardware-specific setup
    bluetui            # Bluetooth manager
    charm-freeze       # Screenshot for code
    dig                # DNS utilities
    # dmidecode          # Read hardware info from system BIOS
    dust               # Disk usage
    # ethtool            # Network device utilities
    fd
    # gibo               # gitignore boilerplates
    hexyl              # Hex viewer
    # hyperfine          # Benchmarking
    # lsof               # Find processes that have a given file open
    nitch              # Pretty fetch in Nim
    # numbat             # Featureful Calculator
    pciutils           # lspci for inspecting PCI devices
    pfetch-rs
    tokei              # Line count
    ouch               # (De)Compressor
    rclone             # Manage files on cloud storage
    # rdap               # Registration data
    # rip2               # Safe rm (xdg-trash alt, recycle)
    ripdrag            # Floating drag and drop
    ripgrep
    systemctl-tui
    # smartmontools      # Hard drive health info; also see services.smartd in system config
    usbutils           # lsusb for inspecting USB devices
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

  # Open the HTML manual with `home-manager-help`
  manual.html.enable = true;

  # Nicely reload system units when switching configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
