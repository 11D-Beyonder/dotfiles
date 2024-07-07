local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = "Monokai Soda"
config.font = wezterm.font("FantasqueSansM Nerd Font")
config.font_size = 14

local platform = require("utils.platform")()
if platform.is_win then
  config.default_prog = { "pwsh" }
end
return config
