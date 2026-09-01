{ lib, pkgs, ... }:
let
  terminal = with pkgs; [
    asciiquarium
    cbonsai
    # figlet             # Generate cool ASCII fonts
    # genact             # Nonsense activity generator
    # hollywood
    neo
    pipes-rs
    # rust-stakeholder   # Nonsense activity generator
  ];

  # From nixpkgs/nixos/modules/services/desktop-managers/gnome.nix
  gnome-games = with pkgs; [
    aisleriot
    atomix
    five-or-more
    four-in-a-row
    gnome-2048
    gnome-chess
    gnome-klotski
    gnome-mahjongg
    gnome-mines
    gnome-nibbles
    gnome-robots
    gnome-sudoku
    gnome-taquin
    gnome-tetravex
    hitori
    iagno
    lightsoff
    quadrapassel
    swell-foop
    tali
  ];

  roguelikes = with pkgs; [
    # brogue-ce       # Brogue: Community Edition (minimalist roguelike, Rogue successor)
    shattered-pixel-dungeon
    # tome4           # Tales of Maj'eyal (roguelike turnbase dungeon explore)
  ];

  miscellaneous = with pkgs; [
    # activate-linux
    # cool-retro-term
    keypunch           # Typing practice
    # osu-lazer          # Rythm game
    # sgt-puzzles        # Simon Tatham's puzzle collection

    # More interesting apps at https://circle.gnome.org/
  ];
in
{
  home.packages = lib.lists.flatten [
    terminal
    gnome-games
    roguelikes
    miscellaneous
  ];
}
