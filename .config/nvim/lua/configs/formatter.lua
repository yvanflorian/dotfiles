local M = {
  filetype = {
    javascript = {
      require("formatter.filetypes.javascript").prettier,
    },
    typescript = {
      require("formatter.filetypes.typescript").prettier,
    },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
}

require("conform").setup {
  formatters_by_ft = {
    go = { "goimports" },
    javascript = { "prettier" },
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
  formatters = {
    prettier = {
      prepend_args = { "--config", vim.fn.expand "~/.config/prettier/.prettierrc.json" },
    },
  },
}

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   command = "FormatWriteLock",
-- })

--autoformat and organizeImports golang on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    -- vim.lsp.buf.format({async = false})
  end,
})

-- vim.api.nvim_create_autocmd({"BufWritePre"}, {
--   pattern = {"*.go"},
--   command = "silent! %!gofmt",
-- })

--
-- vim.api.nvim_create_autocmd({"BufWritePre"},{
--   pattern = "*.go",
--   callback = function ()
--     --get position of cursor
--     local save_cursor = vim.fn.getpos(".")
--     vim.cmd("silent! %!gofmt")
--     --return to it
--     vim.fn.setpos(".",save_cursor)
--   end
-- })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

return M
