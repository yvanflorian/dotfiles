return {
	-- git stuff
	{
		"lewis6991/gitsigns.nvim",
		--event = "User FilePost",
		opts = {
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "󰍵" },
				changedelete = { text = "󱕖" },
			},
			-- custom keymaps for easier navigation
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				-- Navigation keymaps
				vim.keymap.set("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "Next Hunk" })
				vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "Prev Hunk" })
				vim.keymap.set("n", "]dt", gs.diffthis, { buffer = bufnr, desc = "Diff this file" })
			end,
		},
	},
}
