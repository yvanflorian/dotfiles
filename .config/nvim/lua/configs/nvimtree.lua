local conf = require "nvchad.configs.nvimtree"
conf.git = {
  ignore = false,
  enable = true,
}
conf.filters = {
  dotfiles = false,
}

return conf
