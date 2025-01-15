local cmp = require "nvchad.configs.cmp"

cmp.setup {
  mapping = cmp.mapping.preset.insert {
    ["<C-l>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  },
}

return cmp
