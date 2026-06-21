require("blink.cmp").setup({
	-- Use 'default' for standard behavior, or 'super-tab' for VS Code style
	keymap = {
		preset = "default",
		-- ["<C-j>"] = { "select_and_accept" },
		-- ["<C-n>"] = { "snippet_forward", "fallback" },
		-- ["<C-p>"] = { "snippet_backward", "fallback" },
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
		list = {
			selection = {
				preselect = false,
				auto_insert = true,
			},
		},
	},
	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
})
require("luasnip.loaders.from_vscode").lazy_load()
