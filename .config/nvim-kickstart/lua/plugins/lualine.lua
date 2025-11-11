return {
	{ --Bottom nice statusline
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Enhanced LSP component with icons
			local function get_enhanced_lsp()
				local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
				if #buf_clients == 0 then
					return " No LSP"
				end

				local client_names = {}
				for _, client in ipairs(buf_clients) do
					local icon = "" -- Default LSP icon
					if client.name == "tsserver" then
						icon = ""
					elseif client.name == "rust_analyzer" then
						icon = ""
					elseif client.name == "gopls" then
						icon = ""
					elseif client.name == "pyright" then
						icon = ""
					elseif client.name == "lua_ls" then
						icon = ""
					elseif client.name == "clangd" then
						icon = ""
					end
					table.insert(client_names, icon .. " " .. client.name)
				end
				return table.concat(client_names, " ")
			end
			require("lualine").setup({
				theme = "gruvbox_dark",

				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = { "filename", "diff", "diagnostics" },
					lualine_x = { get_enhanced_lsp, "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
