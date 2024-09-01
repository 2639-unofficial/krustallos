local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'GitHub Dark'

config.window_decorations = "RESIZE"

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.enable_kitty_keyboard = true

-- NOTE: Check https://github.com/NixOS/nixpkgs/issues/336069
config.front_end = "WebGpu"

return config
