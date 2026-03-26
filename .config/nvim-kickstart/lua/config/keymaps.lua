--
--
-- Clear highlights on search when pressing <Esc> in normal mode
-- Set highlight on search, but clear on pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Buffer Keymaps
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close current buffer" })

-- my own for comment
vim.keymap.set("n", "<leader>/", "gcc", { desc = "Toggle line comment", remap = true })

-- Navigate quickfix list
vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })
vim.keymap.set("n", "[q", ":cprev<CR>", { desc = "Previous quickfix" })

--Diagnostics
vim.keymap.set("n", "gz", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "diagnostics" })

-- Resize splits
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { silent = true })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Toggle minimal syntax highlighting (disables treesitter + LSP semantic tokens)
vim.keymap.set("n", "<leader>ts", function()
	local bufnr = vim.api.nvim_get_current_buf()

	-- Check if treesitter highlight is active
	local ts_active = vim.treesitter.highlighter.active[bufnr] ~= nil

	if ts_active then
		vim.cmd("TSBufDisable highlight")
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
			vim.lsp.semantic_tokens.stop(bufnr, client.id)
		end
		print("Minimal syntax highlighting")
	else
		vim.cmd("TSBufEnable highlight")
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
			vim.lsp.semantic_tokens.start(bufnr, client.id)
		end
		print("Full syntax highlighting")
	end
end, { desc = "Toggle Minimal syntax highlighting" })

-- Copy file p ath to the clipboard
vim.keymap.set("n", "<leader>cp", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy file path to clipboard" })
