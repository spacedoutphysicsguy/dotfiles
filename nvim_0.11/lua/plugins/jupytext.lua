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

return M
