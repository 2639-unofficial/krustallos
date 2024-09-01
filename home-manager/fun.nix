{ pkgs, ... }:
let
  # From nixpkgs/nixos/modules/services/x11/desktop-managers/gnome.nix
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
in
{
  home.packages = with pkgs; [
    # activate-linux
    asciiquarium
    cbonsai
    # cool-retro-term
    genact
    hollywood
    neo
    pipes-rs
  ] ++ [
    # Simon Tatham's puzzle collection
    # sgt-puzzles
  ] ++ gnome-games;
}
