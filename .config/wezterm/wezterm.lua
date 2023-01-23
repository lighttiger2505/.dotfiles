local wezterm = require('wezterm')
return {
	use_ime = true,
	color_scheme = "Gruvbox Dark",
	font = wezterm.font("HackGenNerd Console", { weight = "Regular", stretch = "Normal", italic = false }),
	colors = { compose_cursor = "orange" },
}
