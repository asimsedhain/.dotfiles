local M = {}

function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
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

-- Returns a copy of the array with the element removed
function M.remove_element(arr, element)
	local copy = {}
	for _, value in ipairs(arr) do
		if value ~= element then
			table.insert(copy, value)
		end
	end
	return copy
end

return M
