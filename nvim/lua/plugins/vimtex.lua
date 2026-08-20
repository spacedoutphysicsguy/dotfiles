if vim.fn.has("macunix") == 1 then
	vim.g.vimtex_view_method = "skim"
else
	vim.g.vimtex_view_method = "zathura"
end
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_quickfix_mode = 0

vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	callback = function()
		local opts = { buffer = true, silent = true }

		vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>", opts)
		vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", opts)
		vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<CR>", opts)
		vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>", opts)
		vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<CR>", opts)
	end,
})
