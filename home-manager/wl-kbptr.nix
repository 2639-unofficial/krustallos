{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # wl-kbptr    # Mouse pointer teleportation
    (wl-kbptr.overrideAttrs (old: {
      src = fetchFromGitHub {
        owner = "moverest";
        repo = "wl-kbptr";
        rev = "master";
        hash = "sha256-UEVPeqD1Oj3cK2Hq2eLpGy6Jdjd9i0tQNXdiDWAUIM0=";
      };
    }))
  ];

  xdg.configFile."wl-kbptr/config".text = let
    font = "sans-serif";

    main-fg = "#f0cabf";
    main-bg = "#000000";
    idle-bg = "#f0cabf";
    border = "#555555";
  in /* ini */ ''
    [general]
    home_row_keys=
    # modes=floating
    # modes=tile,split
    # modes=tile,bisect
    cancellation_status_code=1

    [mode_tile]
    label_color=${main-fg}cf
    label_select_color=${main-fg}6f
    unselectable_bg_color=${idle-bg}10
    selectable_bg_color=${main-bg}7f
    selectable_border_color=${border}9f
    label_font_family=${font}
    label_font_size=8 50% 100
    label_symbols=abcdefghijklmnopqrstuvwxyz

    [mode_floating]
    source=detect
    label_color=${main-fg}ff
    label_select_color=${main-fg}9f
    unselectable_bg_color=${idle-bg}10
    selectable_bg_color=${main-bg}7f
    selectable_border_color=${border}9f
    label_font_family=${font}
    label_font_size=12 50% 100
    label_symbols=abcdefghijklmnopqrstuvwxyz

    [mode_bisect]
    label_color=${main-fg}cf
    label_font_size=20
    label_font_family=${font}
    label_padding=12
    pointer_size=20
    pointer_color=${main-fg}df
    unselectable_bg_color=${idle-bg}10
    even_area_bg_color=${border}4f
    even_area_border_color=${border}8f
    odd_area_bg_color=${main-bg}4f
    odd_area_border_color=${main-bg}8f
    history_border_color=${border}9f

    [mode_split]
    pointer_size=20
    pointer_color=${main-fg}df
    bg_color=${idle-bg}10
    area_bg_color=${main-bg}7f
    vertical_color=${border}7f
    horizontal_color=${border}7f
    history_border_color=${border}9f

    [mode_click]
    # button=left
    # button=middle
    # button=right
  '';
}
