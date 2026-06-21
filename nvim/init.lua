require("vim._core.ui2").enable({})

require("core.options") -- Load general options
require("core.keymaps") -- Load general keymaps
require("core.snippets") -- Custom code snippets

-- local selective_load = function(plug_data)
--   if (plug_data.spec.data or {}).skip_load then return end
--   vim.cmd.packadd(plug_data.spec.name)
-- end

vim.pack.add({
	-- Aerial
	{ src = "https://github.com/stevearc/aerial.nvim" },
	-- Alpha
	{ src = "https://github.com/goolord/alpha-nvim" },
	-- Blink/autocompletion
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	-- Bufferline
	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/moll/vim-bbye" },
	-- Conform
	{ src = "https://github.com/stevearc/conform.nvim" },
	-- Dadbod/database
	{ src = "https://github.com/tpope/vim-dadbod" },
	{ src = "https://github.com/kristijanhusak/vim-dadbod-completion" },
	{ src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
	-- DAP/debug
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/mfussenegger/nvim-dap-python" },
	-- git
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	-- Lualine
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	-- LSP
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/ray-x/lsp_signature.nvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	-- Mason
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	-- Misc
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	-- {src= "https://github.com/numToStr/Comment.nvim"},
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/echasnovski/mini.icons" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/MeanderingProgrammer/markdown.nvim" },
	-- Python
	{ src = "https://github.com/Vigemus/iron.nvim" },
	{ src = "https://github.com/linux-cultist/venv-selector.nvim" },
	-- Plenary
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	-- None-ls
	-- {src= "https://github.com/nvimtools/none-ls.nvim"},
	-- {src= "https://github.com/nvimtools/none-ls-extras.nvim"},
	-- {src= "https://github.com/jayp0521/mason-null-ls.nvim"},
	-- Neo-tree
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = "v3.x" },
	{ src = "https://github.com/s1n7ax/nvim-window-picker", version = vim.version.range("2.x") },
	{ src = "https://github.com/3rd/image.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	-- Oil
	{ src = "https://github.com/stevearc/oil.nvim" },
	-- Telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
	-- Themes
	{ src = "https://github.com/navarasu/onedark.nvim", name = "onedark" },
	-- Vimtex
	{ src = "https://github.com/lervag/vimtex" },
	-- Whichkey
	{ src = "https://github.com/folke/which-key.nvim" },
})
-- Default undotree
vim.cmd("packadd nvim.undotree")

-- Import color theme based on environment variable NVIM_THEME
local default_color_scheme = "onedark"
local env_var_nvim_theme = os.getenv("NVIM_THEME") or default_color_scheme
-- -- Define a table of theme modules
local themes = {
	onedark = "plugins.themes.onedark",
}
require(themes[env_var_nvim_theme])

-- Setup plugins
require("plugins.aerial")
require("plugins.alpha")
require("plugins.autocompletion")
require("plugins.bufferline")
require("plugins.conform")
require("plugins.database")
require("plugins.debug")
require("plugins.git")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.misc")
require("plugins.neo-tree")
require("plugins.python")
require("plugins.oil")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.vimtex")
require("plugins.whichkey")

-- }, {
-- 	ui = {
-- 		-- If you have a Nerd Font, set icons to an empty table which will use the
-- 		-- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
-- 		icons = vim.g.have_nerd_font and {} or {
-- 			cmd = "⌘",
-- 			config = "🛠",
-- 			event = "📅",
-- 			ft = "📂",
-- 			init = "⚙",
-- 			keys = "🗝",
-- 			plugin = "🔌",
-- 			runtime = "💻",
-- 			require = "🌙",
-- 			source = "📄",
-- 			start = "🚀",
-- 			task = "📌",
-- 			lazy = "💤 ",
-- 		},
-- 	},
-- })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
