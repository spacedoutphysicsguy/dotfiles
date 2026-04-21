local formatters = { "stylua", "ruff", "shfmt", "prettier" }
require("mason-tool-installer").setup({ ensure_installed = formatters })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format", "ruff_fix" },
		sh = { "shfmt" },
		zsh = { "shfmt" },
		bash = { "shfmt" },
	},
	format_on_save = {
		time_out_ms = 2000,
		lsp_format = "fallback",
	},
})
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	callback = function(args)
-- 		require("conform").format({ bufnr = args.buf })
-- 	end,
-- })
