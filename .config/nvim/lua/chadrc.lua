-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  transparency = true,
  theme = "chadtain",
}

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "block",
  },
  tabufline = {
    enabled = false,
  },

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- buffer full filename
vim.cmd [[set winbar=%f]]
--increments alphabet with g+Ctrl-a
vim.opt.nrformats = vim.opt.nrformats + "alpha"
return M
