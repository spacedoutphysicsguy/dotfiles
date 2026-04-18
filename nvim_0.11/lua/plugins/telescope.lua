-- Fuzzy Finder (files, lsp, etc)
return {
	"nvim-telescope/telescope.nvim",
	-- branch = '0.1.x',
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		require("telescope").setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "bottom",
						preview_width = 0.6,
						width = { padding = 0 },
						height = { padding = 0 },
					},
				},
				mappings = {
					i = {
						["<C-p>"] = actions.move_selection_previous, -- move to prev result
						["<C-n>"] = actions.move_selection_next, -- move to next result
						["<C-j>"] = actions.select_default, -- open file
					},
					n = {
						["q"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					file_ignore_patterns = { "node_modules", ".git", ".pixi", ".venv" },
					hidden = true,
				},
				buffers = {
					initial_mode = "normal",
					sort_lastused = true,
					-- sort_mru = true,
					mappings = {
						n = {
							["d"] = actions.delete_buffer,
							["l"] = actions.select_default,
						},
					},
				},
				marks = {
					initial_mode = "normal",
				},
				oldfiles = {
					initial_mode = "normal",
				},
			},
			live_grep = {
				file_ignore_patterns = { "node_modules", ".git", ".pixi", ".venv" },
				additional_args = function(_)
					return { "--hidden" }
				end,
			},
			path_display = {
				filename_first = {
					reverse_directories = true,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
			git_files = {
				previewer = false,
			},
		})

		-- Enable telescope fzf native, if installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind in existing [B]uffers" })
		vim.keymap.set("n", "<leader>fj", builtin.current_buffer_fuzzy_find, { desc = "[F]ind in current [B]uffer" })
		-- vim.keymap.set('n', '<leader><tab>', builtin.buffers, { desc = '[S]earch existing [B]uffers' })
		-- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
		vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "[F]ind in [M]arks" })
		vim.keymap.set("n", "<leader>fgf", builtin.git_files, { desc = "[F]ind in [G]it [F]iles" })
		vim.keymap.set("n", "<leader>fgc", builtin.git_commits, { desc = "[F]ind in [G]it [C]ommits" })
		vim.keymap.set("n", "<leader>fgn", builtin.git_bcommits, { desc = "[F]ind in [G]it Commits [N]ow" })
		vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "[F]ind in [G]it [B]ranches" })
		vim.keymap.set("n", "<leader>fgs", builtin.git_status, { desc = "[F]ind in [G]it [S]tatus (diff view)" })
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]ile" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind in [H]elp" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
		vim.keymap.set("n", "<leader>fk", builtin.live_grep, { desc = "[F]ind by [G]rep" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind in [D]iagnostics " })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]resumes" })
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "[F]ind in Recent Files" })
		vim.keymap.set("n", "<leader>fs", function()
			builtin.lsp_document_symbols({
				symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Property" },
			})
		end, { desc = "[F]ind in LSP document [S]ymbols" })
		vim.keymap.set("n", "<leader>f/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[F]ind in Open Files" })
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				previewer = false,
			}))
		end, { desc = "[/] Fuzzy Find" })
	end,
}
