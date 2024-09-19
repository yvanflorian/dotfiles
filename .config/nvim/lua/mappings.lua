require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "definitions" })
map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "references" })
map("n", "gz", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "diagnostic" })
map("n", "<leader>fc", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })

--alternate file: Ctrl + " + Enter
-- map("n", '<C-">', "<cmd>e #<CR>", { desc = "Alternate file" })

-- Toggleable Terminal at the bottom (Ctrl + t)
map({ "n", "t" }, "<A-t>", function()
  require("nvchad.term").toggle { pos = "sp", id = "floatTerm" }
end, { desc = "Terminal Toggle Floating term" })

--Rename across files
map("n", '<C-">', function()
  vim.lsp.buf.rename()
end, { desc = "LSP Rename" })

map("n", "<leader>af", function()
  -- vim.cmd "e #"
  vim.lsp.buf.rename()
end, { desc = "LSP Rename" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
