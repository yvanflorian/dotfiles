local conf = require "nvchad.configs.telescope"
conf.defaults = {
  prompt_prefix = "    ",
  selection_caret = "󰋇 ",
  layout_config = {
    prompt_position = "bottom",
  },
  mappings = {
    i = {
      ["<C-j>"] = require("telescope.actions").move_selection_next,
      ["<Esc>"] = require("telescope.actions").close,
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
  },
}

return conf
