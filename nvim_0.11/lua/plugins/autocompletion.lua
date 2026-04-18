return {
	"saghen/blink.cmp",
	version = "*", -- Use a release tag to download pre-built binaries
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip", -- Keep this since you are using it
	},
	opts = {
		-- Use 'default' for standard behavior, or 'super-tab' for VS Code style
		keymap = {
			preset = "default",
			["<C-j>"] = { "select_and_accept" },
			["<C-n>"] = { "snippet_forward", "fallback" },
			["<C-p>"] = { "snippet_backward", "fallback" },
		},

		appearance = {
			-- Set to 'mono' if you use Nerd Font Mono
			nerd_font_variant = "mono",
			-- This maps kind icons automatically
			kind_icons = {
				Text = "󰉿",
				Method = "m",
				Function = "󰊕",
				Constructor = "",
				Field = "",
				Variable = "󰆧",
				Class = "󰌗",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰇽",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰊄",
			},
		},

		-- Link LuaSnip
		snippets = { preset = "luasnip" },

		-- Sources are enabled by default, but you can customize order/names
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- Documentation window configuration
		completion = {
			menu = {
				draw = {
					-- This replicates your 'formatting' section
					columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
		},
	},
}
