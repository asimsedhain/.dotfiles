-- global variables
local g = vim.g
local map = require("utils").map
local api = vim.api
--local create_command = vim.api.nvim_create_user_command
--local call = vim


-- variables to modify Vim Airline
g['airline_section_y']=""
g['airline_section_warning']=""
g['airline_section_z']="%p%%"


-- Fugitive remap
map('n', '<SPACE>gl',  ':Git! log --decorate --oneline --graph --all<CR>')
map('n', '<SPACE>gs', ':G<CR>')




-- Telescope

-- Ctrl-p for searching for files
map('n', '<C-p>', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
-- Ctrl-g for live grep
map('n', '<C-g>', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
-- Space and t for all pickers in telescope
map('n', '<SPACE>t', '<cmd>lua require(\'telescope.builtin\').builtin()<cr>')
-- Space and h for seaching through help
map('n', '<SPACE>h', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')


-- COC
-- Remap keys for gotos
map('n', 'gd', '<Plug>(coc-definition)', {noremap=false})
map('n', 'gy', '<Plug>(coc-type-definition)', {noremap=false})
map('n', 'gi', '<Plug>(coc-implementation)', {noremap=false})
map('n', 'gr', '<Plug>(coc-references)', {noremap=false})

-- Remap for rename current word
map('n', '<F2>', '<Plug>(coc-rename)', {noremap=false})

-- Use `:Format` to format current buffer
api.nvim_create_user_command("Format", function()
	api.nvim_call_function('CocAction', {'format'})
end, {})

-- use `:Org` for organize import of current buffer
api.nvim_create_user_command("Org", function()
	api.nvim_call_function('CocAction', {'runCommand', 'editor.action.organizeImport'})
end, {})


-- Highlight symbol under cursor
api.nvim_create_autocmd('CursorHold',
	{
		pattern='*',
		desc='Highlight symbol under cursor',
		callback=function()
			api.nvim_call_function('CocActionAsync', {'highlight'})
		end
	})
