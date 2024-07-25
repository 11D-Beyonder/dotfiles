local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = "Bamboo"
config.font = wezterm.font("FantasqueSansM Nerd Font")
config.font_size = 16
return config
