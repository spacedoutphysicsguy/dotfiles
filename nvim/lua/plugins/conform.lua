local formatters = { "stylua", "ruff", "shfmt", "prettier" }
require("mason-tool-installer").setup({ ensure_installed = formatters })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff" },
		sh = { "shfmt" },
		zsh = { "shfmt" },
		bash = { "shfmt" },
	},
	format_on_save = {
		time_out_ms = 500,
		lsp_format = "fallback",
	},
})
