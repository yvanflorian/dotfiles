local conf = require "nvchad.configs.telescope"
local actions = require "telescope.actions"

conf.defaults = {
  theme = "ivy",
  prompt_prefix = "    ",
  selection_caret = "󰋇 ",
  layout_config = {
    prompt_position = "top",
    height = 0.3,
  },
  mappings = {
    i = {
      ["<C-j>"] = actions.move_selection_next,
      ["<Esc>"] = actions.close,
      ["<C-r>"] = actions.delete_buffer + actions.move_to_top, --delete buffer
    },
  },
  vimgrep_arguments = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "--hidden", -- This allows searching in hidden files
    "--glob=!.git/*", -- This excludes the .git directory
    "--glob=!.deprecated/*", -- This excludes the .git directory
  },
}
conf.pickers = {
  find_files = {
    find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*", "--glob", "!.deprecated/*" },
    theme = "ivy",
    layout_config = {
      prompt_position = "top",
      height = 0.4,
    },
  },
  live_grep = {
    theme = "ivy",
    layout_config = {
      height = 0.3,
    },
  },
  git_commits = {
    theme = "ivy",
  },
  git_status = {
    theme = "ivy",
  },
  lsp_references = {
    theme = "ivy",
    layout_config = {
      height = 0.3,
    },
  },
  buffers = {
    theme = "ivy",
    layout_config = {
      prompt_position = "top",
      preview_width = 0.6,
      preview_cutoff = 0,
      height = 0.3,
    },
    -- remove completely borders
    borderchars = {
      { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }, -- Default border chars
      prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      results = { " ", " ", " ", " ", " ", " ", " ", " " }, -- No borders for results
      preview = { " ", " ", " ", " ", " ", " ", " ", " " }, -- No borders for preview
    },
  },
}

return conf
