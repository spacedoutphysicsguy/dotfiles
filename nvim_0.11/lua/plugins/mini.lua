return {
	"echasnovski/mini.icons",
	opts = {},
	config = function(_, opts)
		local icons = require("mini.icons")
		icons.setup(opts)
		-- This is the critical line that replaces the old plugin
		icons.mock_nvim_web_devicons()
	end,
}
