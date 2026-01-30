-- Standalone plugins with less than 10 lines of config go here
return {
	{
		-- autoclose tags
		"windwp/nvim-ts-autotag",
	},
	{
		-- detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		-- Powerful Git integration for Vim
		"tpope/vim-fugitive",
	},
	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
	},
	{
		-- Autoclose parentheses, brackets, quotes, etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		-- high-performance color highlighter
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- Selector for working with different python venvs
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
		config = true,
		event = "VeryLazy",
		keys = {
			-- Keymap to open the selector (e.g., Leader + v)
			{ "<leader>vs", "<cmd>VenvSelect<cr>" },
		},
	},
	-- Adding some surround motions
	{
		{
			"kylechui/nvim-surround",
			version = "*", -- use latest stable tag
			event = "VeryLazy",
			config = true, -- uses default setup()
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			bind = true, -- Mandatory for the floating window
			handler_opts = {
				border = "rounded",
			},
			hint_prefix = "󰏪 ", -- Use a Nerd Font icon for hints
			floating_window = true,
			padding = " ",
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
}
