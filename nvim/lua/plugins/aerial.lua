require("aerial").setup({
-- optionally use on_attach to set keymaps when aerial has attached to a buffer
on_attach = function(bufnr)
-- Jump forwards/backwards with '{' and '}'
vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
end,
layout = { min_width = 30,},})
		-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>af", "<cmd>AerialToggle<CR>", { desc = "[A]erial [F]ocus" })
vim.keymap.set("n", "<leader>an", "<cmd>AerialNavToggle<CR>", { desc = "[A]erial [N]av Toggle" })
