-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "chadtain",
  transparency = true,
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
return M
