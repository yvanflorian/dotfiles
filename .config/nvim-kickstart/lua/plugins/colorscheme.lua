return {
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 10, -- Make sure to load this before all the other start plugins.
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				style = "night", -- The theme comes in three styles: storm, night, day
				transparent = true, -- Enable transparency
				terminal_colors = true, -- Configure terminal colors
				styles = {
					comments = { italic = true }, -- Disable italics in comments

					sidebars = "dark",
					floats = "dark",
				},
			})

			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			-- vim.cmd.colorscheme("tokyonight-night")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				dark_variant = "moon",

				styles = {
					bold = true,
					italic = true,
					transparency = true, -- Enable transparency here!
				},
			})
			-- vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				-- flavour = "mocha",
				contrast = "soft",
				transparent_mode = true,
				terminal_colors = true,

				overrides = {
					-- Disable string highlighting by making it look like normal text
					-- You can find the exact highlight group names using :hi
					["@string"] = { fg = "#8ec07c" }, -- Use the same color as normal text
					String = { fg = "#8ec07c" }, -- Another common string highlight group
					["string"] = { fg = "#8ec07c" }, -- And another

					-- Dark gray comments (choose one of the options above)
					["@comment"] = { fg = "#7c6f64", italic = false },
					Comment = { fg = "#7c6f64", italic = false },

					--Folded
					-- Folded = { bg = "#7c6f64", fg = "#1d2021" },

					Folded = { bg = "#3c3836", fg = "#928374" },
				},
			})

			-- setup must be called before loading
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	-- TJ's onedark colorscheme
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "dark",
				transparent = true, -- Enable transparency if you want
				term_colors = true,
				ending_tildes = false, -- Show ~ at end of buffer
				cmp_itemkind_reverse = false,

				-- Custom highlights if needed
				code_style = {
					comments = "none", -- No italics for comments
					keywords = "none",
					functions = "none",
					strings = "none",
					variables = "none",
				},

				colors = {}, -- Override colors if needed
				highlights = {}, -- Override highlight groups
			})

			-- vim.cmd.colorscheme("onedark")
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				term_colors = true,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				color_overrides = {},
				custom_highlights = {},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					notify = false,
					mini = false,
					lualine = true,
					-- For more integrations, see: https://github.com/catppuccin/nvim#integrations
				},
			})

			-- setup must be called before loading
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"vague-theme/vague.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other plugins
		config = function()
			require("vague").setup({
				-- optional configuration here
				transparent = true,
				colors = {
					-- Make the function/parameter colors more pronounced

					constant = "#c5b8da", -- Properties (default: #c3c3d5)
					-- parameter = "#ff0000", -- Properties (default: #c3c3d5)
				},
			})
			-- vim.cmd("colorscheme vague")
		end,
	},
}
