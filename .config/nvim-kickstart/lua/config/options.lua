-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.incsearch = true
vim.o.wrap = false

--tab width to 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.winborder = "rounded"
-- Enable transparency

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

--winbar and remove filename bottom left
vim.o.winbar = "%f"
vim.o.statusline = ""
vim.o.laststatus = 0

vim.opt.nrformats:append("alpha")
