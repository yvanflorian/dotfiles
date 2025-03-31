require "nvchad.options"

-- add yours here!
local opt = vim.opt
opt.relativenumber = true
opt.scrolloff = 8
opt.incsearch = true
opt.wrap = false

local autocmd = vim.api.nvim_create_autocmd
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tab", "*.sql", "*.pks", "*.pkb", "*.vw" },
  command = "set filetype=plsql",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.go", "*.ts", "*.tsx", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    vim.opt_local.foldmethod = "indent"
  end,
})

--- On opening of Neovim,
--- Automatically open Telescope
autocmd("VimEnter", {
  callback = function()
    require("telescope.builtin").find_files()
  end,
})

autocmd({ "BufWritePost", "BufEnter" }, {
  pattern = "*",
  callback = function()
    -- Define the keywords to highlight
    local keywords = { "TODO", "FIXME", "NOTE", "OPTIMIZE", "HACK", "BUG" }

    -- Create the syntax match command
    local syntax_cmd = "syntax match TodoHighlight '"

    -- Add each keyword to the syntax match command
    for i, keyword in ipairs(keywords) do
      syntax_cmd = syntax_cmd .. "\\v<" .. keyword .. ">:"
      if i < #keywords then
        syntax_cmd = syntax_cmd .. "|"
      end
    end

    -- Complete the syntax match command
    syntax_cmd = syntax_cmd .. "' containedin=.*Comment,vimCommentTitle"

    -- Ensure syntax is on always
    -- vim.cmd "syntax on"
    -- Execute the syntax match command
    vim.cmd(syntax_cmd)

    -- Define the highlight style
    -- TODO
    vim.cmd "highlight TodoHighlight guifg=#FF8C00 ctermfg=208 gui=bold"
  end,
})
