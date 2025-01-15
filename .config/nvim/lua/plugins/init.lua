return {
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.formatter"
    end,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      return require "configs.nvimtree"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = function()
  --     return require "nvchad.configs.cmp"
  --     -- local opts = require "plugins.configs.cmp"
  --     -- local custom_opts = require "configs.cmp"
  --     -- return vim.tbl_deep_extend("force", opts, custom_opts.cmp)
  --   end,
  -- },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "typescript-language-server",
        "prettier",
        "eslint-lsp",
        "terraform-ls",
        "tflint",
        "tfsec",
        "gofumpt",
        "bash-language-server",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    -- lazy = false,
    config = function()
      require "configs.lint"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "go",
        "javascript",
        "typescript",
        "tsx",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      return require "configs.telescope"
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    config = function()
      require "luasnip"
      require("luasnip.loaders.from_vscode").load_standalone {
        path = "~/.config/nvim/lua/snippets/plsqljs.code-snippets",
      }
    end,
  },
}
