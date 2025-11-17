return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			local entry_display = require("telescope.pickers.entry_display")
			local make_entry = require("telescope.make_entry")

			--
			-- Custom entry maker
			-- to display date last modified and the line number
			local function make_grep_entry_with_mtime(opts)
				local displayer = entry_display.create({
					separator = " │ ",
					items = {
						{ width = 16 }, -- Date
						{ width = 6 }, -- Line number
						{ remaining = true }, -- Filename
					},
				})

				local make_display = function(entry)
					local stat = vim.uv.fs_stat(entry.filename)
					local mtime = stat and os.date("%Y-%m-%d %H:%M", stat.mtime.sec) or "unknown"

					return displayer({
						{ mtime, "TelescopeResultsComment" },
						{ tostring(entry.lnum), "TelescopeResultsLineNr" },
						entry.filename,
					})
				end

				return function(entry)
					local base = make_entry.gen_from_vimgrep(opts)(entry)
					if base then
						base.display = make_display
					end
					return base
				end
			end

			-- Function to live grep files with a given glob_pattern (extension like .go, .ts)
			local function live_grep_with_glob()
				local builtin = require("telescope.builtin")

				-- First, ask for glob pattern
				vim.ui.input({
					prompt = "File pattern (e.g., *.ts, *.lua) or leave empty: ",
					default = "*",
				}, function(pattern)
					if pattern then
						-- Then open live_grep with that pattern
						builtin.live_grep({
							glob_pattern = pattern ~= "*" and pattern or nil,
							entry_maker = make_grep_entry_with_mtime(), -- Your custom entry maker
							prompt_title = pattern ~= "*" and ("Live Grep in " .. pattern) or "Live Grep",
						})
					end
				end)
			end

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				defaults = {
					theme = "ivy",
					prompt_prefix = "    ",
					selection_caret = "󰋇 ",
					layout_strategy = "bottom_pane",
					layout_config = {
						prompt_position = "top",
						height = 0.3,
					},
					mappings = {
						i = {
							["<Esc>"] = require("telescope.actions").close,
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-r>"] = require("telescope.actions").delete_buffer,
							--	+ require("telescope.actions").move_to_top, --delete buffer
							["<C-v>"] = require("telescope.actions").file_vsplit,
							["<C-h>"] = require("telescope.actions").file_split,
							["<C-s>"] = require("telescope.actions").select_all,
							-- Shift-q for selected-list to be sent to quick-fix
							["<S-q>"] = require("telescope.actions").send_selected_to_qflist
								+ require("telescope.actions").open_qflist,
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
						"--sortr",
						"modified", -- Sort by last modified time (newest first would be --sortr modified)
					},
				},
				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob",
							"!.git/*",
							"--glob",
							"!.deprecated/*",
							"--sortr",
							"modified", -- Sort by last modified time (newest first would be --sortr modified)
						},
						theme = "ivy",
						layout_config = {
							prompt_position = "top",
							--height = 0.4,
						},
					},
					live_grep = {
						theme = "ivy",
						layout_config = {
							--height = 0.3,
						},
					},
					git_commits = {
						theme = "ivy",
					},
					git_bcommits = {
						theme = "ivy",
						layout_config = {
							height = 0.8,
						},
						git_command = {
							"git",
							"log",
							"--pretty=%h %ad %an %s",
							"--date=iso", -- 2024-11-11 14:30:25 +0300
							-- "--date=short", -- or "relative", "iso", "format:%Y-%m-%d %H:%M"
							"--follow", -- Follow file renames
						},
					},
					git_status = {
						theme = "ivy",
					},
					colorscheme = {
						enable_preview = true, -- Preview the colorscheme before applying
					},
					lsp_references = {
						theme = "ivy",
						layout_config = {
							--height = 0.3,
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
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			-- vim.keymap.set("n", "<leader>fc", builtin.live_grep, { desc = "[S]earch by [G]rep" })

			vim.keymap.set(
				"n",
				"<leader>fG",
				live_grep_with_glob,
				{ desc = "[F]ind files with grep with [G]lob patterns (specify file extension)" }
			)
			-- Grep with dates
			vim.keymap.set("n", "<leader>fg", function()
				builtin.live_grep({
					entry_maker = make_grep_entry_with_mtime(),
					prompt_title = "Live Grep",
				})
			end, { desc = "[Find] files with rip[g]rep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[S]earch [B]uffers" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "[ ] Find existing [b]uffers" })
			vim.keymap.set("n", "<leader>gt", builtin.git_status, { desc = "[G]it s[t]atus" })
			vim.keymap.set("n", "<leader>gl", builtin.git_bcommits, { desc = "[G]it [L]og this one file" })
			vim.keymap.set("n", "<leader>th", builtin.colorscheme, { desc = "Preview [Th]emes" })

			-- my own definition in vsplit
			vim.keymap.set("n", "gs", function()
				require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
			end, { desc = "Definition in vsplit" })
			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>cb", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
}
