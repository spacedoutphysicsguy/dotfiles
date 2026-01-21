return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"moll/vim-bbye",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				numbers = "none",
				themable = true,
				close_command = "Bdelete! %d",
				right_mouse_command = "Bdelete! %d",
				left_mouse_command = "buffer %d",
				middle_mouse_command = nil,
				buffer_close_icon = "✗",
				close_icon = "",
				modified_icon = "●",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 30,
				max_prefix_length = 30,
				tab_size = 21,
				diagnostics = false,
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				persist_buffer_sort = true,
				separator_style = { "│", "│" },
				enforce_regular_tabs = true,
				always_show_bufferline = true,
				show_tab_indicators = false,
				indicator = {
					style = "none",
				},
				icon_pinned = "󰐃",
				minimum_padding = 1,
				maximum_padding = 5,
				sort_by = "insert_at_end",

				-- 	name_formatter = function(buf)
				-- 		local parent = vim.fn.fnamemodify(buf.path, ":p:h:t")
				-- 		if parent == "." or parent == "" then
				-- 			return buf.name
				-- 		end
				-- 		return parent .. " / " .. buf.name
				-- 	end,
			},
			highlights = {
				separator = {
					fg = "#434C5E",
				},
				buffer_selected = {
					bold = true,
					italic = false,
				},
			},
		})
	end,
}
