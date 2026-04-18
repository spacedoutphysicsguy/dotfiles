require("mason-tool-installer").setup({ ensure_installed = { "tree-sitter-cli" } })
require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})
require("nvim-treesitter").install({
	"lua",
	"python",
	"bash",
	"zsh",
	"yaml",
	"json",
})
require("nvim-treesitter-textobjects").setup()

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
