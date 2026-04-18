			local iron = require("iron.core")
			local view = require("iron.view")
			local common = require("iron.fts.common")

			iron.setup({
				config = {
					-- Whether a repl should be discarded or not
					scratch_repl = true,
					highlight_last = "IronLastSent",
					scope = require("iron.scope").tab_based,
					close_window_on_exit = true,
					-- Your repl definitions come here
					repl_definition = {
						sh = {
							-- Can be a table or a function that
							-- returns a table (see below)
							command = { "zsh" },
						},
						python = {
							format = common.bracketed_paste_python,
							command = { "ipython", "--no-confirm-exit", "--no-autoindent" },
							block_dividers = { "# %%", "#%%" },
							env = { PYTHON_BASIC_REPL = "1" }, --this is needed for python3.13 and up.
						},
					},
					-- set the file type of the newly created repl to ft
					-- bufnr is the buffer id of the REPL and ft is the filetype of the
					-- language being used for the REPL.
					repl_filetype = function(bufnr, ft)
						return ft
					end,
					-- Send selections to the DAP repl if an nvim-dap session is running.
					dap_integration = true,
					-- How the repl window will be displayed
					-- See below for more information
					repl_open_cmd = view.split.horizontal("%40"),

					-- repl_open_cmd can also be an array-style table so that multiple
					-- repl_open_commands can be given.
					-- When repl_open_cmd is given as a table, the first command given will
					-- be the command that `IronRepl` initially toggles.
					-- Moreover, when repl_open_cmd is a table, each key will automatically
					-- be available as a keymap (see `keymaps` below) with the names
					-- toggle_repl_with_cmd_1, ..., toggle_repl_with_cmd_k
					-- For example,
					--
					-- repl_open_cmd = {
					--   view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
					--   view.split.rightbelow("%25")  -- cmd_2: open a repl below
					-- }
				},
				-- Iron doesn't set keymaps by default anymore.
				-- You can set them here or manually add keymaps to the functions in iron.core
				keymaps = {
					toggle_repl = "<leader>ro", -- toggles the repl open and closed.
					-- If repl_open_command is a table as above, then the following keymaps are
					-- available
					-- toggle_repl_with_cmd_1 = "<leader>rv",
					-- toggle_repl_with_cmd_2 = "<leader>rh",
					restart_repl = "<leader>rR", -- calls `IronRestart` to restart the repl
					send_motion = "<leader>rc",
					visual_send = "<leader>rc",
					send_file = "<leader>ra",
					send_line = "<leader>rl",
					send_paragraph = "<leader>rp",
					send_until_cursor = "<leader>ru",
					send_mark = "<leader>rm",
					send_code_block = "<leader>rb",
					send_code_block_and_move = "<leader>rn",
					-- mark_motion = "<leader>mc",
					-- mark_visual = "<leader>mc",
					-- remove_mark = "<leader>md",
					cr = "<leader>rs",
					interrupt = "<leader>ri",
					exit = "<leader>rq",
					clear = "<leader>rc",
				},
				-- If the highlight is on, you can change how it looks
				-- For the available options, check nvim_set_hl
				highlight = {
					italic = true,
				},
				ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
			})

			-- iron also has a list of commands, see :h iron-commands for all available commands
			vim.keymap.set("n", "<leader>rf", "<cmd>IronFocus<cr>")
			vim.keymap.set("n", "<leader>rh", "<cmd>IronHide<cr>")


	-- Selector for working with different python venvs
	require('venv-selector').setup()
	vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", {desc= "[V]env [S]elector"})


-- Some gurbled jupytext stuff (ChatGPTism)
local M = {}

local function notify(msg, level)
	vim.notify(msg, level or vim.log.levels.INFO, { title = "jupytext" })
end

local function has_jupytext()
	return vim.fn.executable("jupytext") == 1
end

local function run(cmd, ok_msg)
	vim.fn.jobstart(cmd, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stderr = function(_, data)
			if data and #data > 1 then
				notify(table.concat(data, "\n"), vim.log.levels.WARN)
			end
		end,
		on_exit = function(_, code)
			if code == 0 then
				if ok_msg then
					notify(ok_msg)
				end
			else
				notify("Command failed (exit " .. code .. "): " .. table.concat(cmd, " "), vim.log.levels.ERROR)
			end
		end,
	})
end

local function current_file()
	local path = vim.fn.expand("%:p")
	if path == "" then
		return nil
	end
	return path
end

local function ensure_saved()
	if vim.bo.modified then
		vim.cmd("write")
	end
end

local function has_ipynb_counterpart(file)
	local ipynb = file:gsub("%.py$", ".ipynb")
	return vim.fn.filereadable(ipynb) == 1
end

function M.sync()
	if not has_jupytext() then
		return notify("jupytext not found on PATH. Install with: pip install jupytext", vim.log.levels.ERROR)
	end
	local file = current_file()
	if not file then
		return notify("No file for current buffer", vim.log.levels.WARN)
	end
	ensure_saved()
	run({ "jupytext", "--sync", file }, "Synced: " .. vim.fn.fnamemodify(file, ":t"))
end

function M.pair()
	if not has_jupytext() then
		return notify("jupytext not found on PATH. Install with: pip install jupytext", vim.log.levels.ERROR)
	end
	local file = current_file()
	if not file then
		return notify("No file for current buffer", vim.log.levels.WARN)
	end
	ensure_saved()
	run({ "jupytext", "--set-formats", "ipynb,py:percent", file }, "Paired: " .. vim.fn.fnamemodify(file, ":t"))
end

-- Call this from init.lua to set up keymaps
function M.setup()
	-- keymaps
	vim.keymap.set("n", "<leader>rjs", M.sync, { desc = "Jupytext: sync" })
	vim.keymap.set("n", "<leader>rjp", M.pair, { desc = "Jupytext: pair (ipynb <-> py:percent)" })

	-- autosync on save (only if paired ipynb exists)
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "*.py",
		callback = function(args)
			if has_ipynb_counterpart(args.file) then
				M.sync()
			end
		end,
	})
	vim.api.nvim_create_autocmd("BufReadPost", {
		pattern = "*.py",
		callback = function(args)
			if vim.bo.modified then
				return
			end
			if has_ipynb_counterpart(args.file) then
				M.sync()
			end
		end,
	})
end

M.setup()
