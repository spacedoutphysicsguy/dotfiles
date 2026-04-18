-- Simple setup calls
-- require('nvim-autopairs').setup({})
	require('todo-comments').setup({})
	require('nvim-surround').setup({})
	require('nvim-autopairs').setup({})
	require("ibl").setup({})

-- Mini setup
	local icons = require("mini.icons")
		icons.setup(opts)
		-- This is the critical line that replaces the old plugin
		icons.mock_nvim_web_devicons()
