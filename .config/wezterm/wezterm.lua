local wezterm = require("wezterm")
function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Bamboo"
	else
		return "Bamboo Light"
	end
end

local config = {
	color_scheme = scheme_for_appearance(get_appearance()),

	font = wezterm.font("Rec Mono Casual"),
	font_size = 16,
}
return config
