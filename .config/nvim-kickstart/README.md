# Neovim configs
This is my own first neovim conf, after moving out from nvchad...

## Directory Structure
~/.config/nvim-kickstart/
├── init.lua                 -- Entry point (loads everything)
├── lua/
│   ├── config/
│   │   ├── options.lua      -- Vim options (set commands)
│   │   ├── keymaps.lua      -- Key mappings
│   │   ├── autocmds.lua     -- Autocommands
│   │   └── lazy.lua         -- Lazy.nvim setup
│   └── plugins/
│       ├── colorscheme.lua  -- Theme configuration
│       ├── telescope.lua    -- Telescope config
│       ├── lsp.lua          -- LSP configuration
│       ├── treesitter.lua   -- Treesitter config
│       ├── completion.lua   -- nvim-cmp config
│       └── ...              -- Other plugin configs
