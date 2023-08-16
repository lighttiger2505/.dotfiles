local wezterm = require('wezterm')
return {
	use_ime = true,
	enable_wayland = true,
	color_scheme = "Gruvbox dark, medium (base16)",
	-- Show font list `wezterm ls-fonts --list-system`
	font = wezterm.font("HackGen Console NF", { weight = "Regular", stretch = "Normal", style = "Normal" }),
	-- Reference color schema `https://wezfurlong.org/wezterm/colorschemes/index.html`
	keys = {
		-- Turn off the toggle full screen by MacOS
		{
			key = 'Enter',
			mods = 'ALT',
			action = wezterm.action.DisableDefaultAssignment,
		},
		-- Turn off the new tab by MacOS
		{
			key = 't',
			mods = 'CMD',
			action = wezterm.action.DisableDefaultAssignment,
		},
		-- Turn off the new window by MacOS
		{
			key = 'n',
			mods = 'CMD',
			action = wezterm.action.DisableDefaultAssignment,
		},
		-- paste from the primary selection
		{
			key = 'V',
			mods = 'CTRL',
			action = wezterm.action.PasteFrom 'Clipboard',
		},
	},
}
