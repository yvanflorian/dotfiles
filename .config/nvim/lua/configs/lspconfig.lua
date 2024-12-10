-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  -- init_options = {
  --   preferences = {
  --     disableSuggestions = true,
  --   },
  -- },
}

lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "typescript" },
  root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json"),
  settings = {
    workingDirectory = { mode = "auto" },
    -- format = { enable = true },
    lint = { enable = true },
    -- Add this section to ignore minified files
    ignorePatterns = { "**/*.min.js", "**/*.min.ts" },
  },
}

lspconfig.bashls.setup {
  -- on_attach=on_attach,
  -- capabilities=capabilities,
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh" },
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls", "-remote=auto" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  -- rootdir = util.root_pattern("go.work","go.mod",".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
      gofumpt = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "terraform-ls", "serve" },
  filetypes = { "tf", "terraform", "terraform-vars" },
  -- rootdir = util.root_pattern(".tf",".terraform",".git"),
  settings = {
    completeUnimported = true,
  },
}

-- Overrid the lsp reference builtin that sends the
-- LSP reference look up to quickfix by default
vim.lsp.handlers["textDocument/references"] = function()
  require("telescope.builtin").lsp_references()
end
