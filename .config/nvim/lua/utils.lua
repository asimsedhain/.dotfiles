local M = {}

function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		if opts.desc then
			opts.desc = "keymaps.lua: " .. opts.desc
		end
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.keys(table)
	local key_table = {}
	local i = 0
	for k, _ in pairs(table) do
		i = i + 1
		key_table[i] = k
	end
	return key_table
end

return M
