require("which-key").setup({
	delay = 0,
	preset = "helix",
	icons = {
		mappings = true,
	},
	spec = {
		{ "<leader>f", group = "Find" },
		{ "<leader>g", group = "Git" },
		{ "<leader>l", group = "LSP", icon = "󰚩" },
		{ "<leader>d", group = "Diagnostics" },
		{ "<leader>q", group = "Quit" },
		{ "<leader>s", group = "Save", icon = "💾" },
		{ "<leader>r", group = "Iron", icon = "⛓️" },
		{ "<leader>t", group = "Tab" },
		{ "<leader>a", group = "Aerial", icon = "󰙅" },
	},
})
