local wezterm = require("wezterm")
local config = {
	hide_tab_bar_if_only_one_tab = true,
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	-- default_prog = { "wsl", "su", "yvanflorian" },
	-- color_scheme = "Chameleon (Gogh)",
	front_end = "WebGpu",
	color_scheme = "Gruvbox dark, soft (base16)",
	font = wezterm.font("Iosevka Nerd Font", { weight = "Regular" }),
	font_size = 16.45,
	window_background_image = wezterm.config_dir .. "/horizon.jpg",
	window_background_image_hsb = {
		brightness = 0.15,
		hue = 0.62,
		saturation = 0.85,
	},
	-- initial_rows = 1000,
	-- initial_cols = 1000,

	--
	-- AI Generated colorscheme to match with
	-- neovim vague: vague-theme/vague.nvim
	--colors = {
	--	foreground = "#cdcdcd",
	--	background = "#18191a", -- Vague uses #141415, slightly adjusted for better visibility
	--	cursor_bg = "#c48282",
	--	cursor_fg = "#18191a",
	--	cursor_border = "#c48282",
	--	selection_bg = "#333738",
	--	selection_fg = "#cdcdcd",
	--	ansi = {
	--		"#18191a", -- black
	--		"#d8647e", -- red
	--		"#7fa563", -- green
	--		"#e8b589", -- yellow
	--		"#6e94b2", -- blue
	--		"#bb9dbd", -- magenta
	--		"#24EAF7", -- cyan
	--		"#cdcdcd", -- white
	--	},
	--	brights = {
	--		"#606079", -- bright black (comment color)
	--		"#d8647e", -- bright red
	--		"#7fa563", -- bright green
	--		"#f3be7c", -- bright yellow (warning)
	--		"#7e98e8", -- bright blue (hint)
	--		"#bb9dbd", -- bright magenta
	--		"#b4d4cf", -- bright cyan (builtin)
	--		"#cdcdcd", -- bright white
	--	},
	--},
}

return config
