-- global variables
local g = vim.g
local map = require("utils").map

-- variables to modify Vim Airline
g['airline_section_y'] = ""
g['airline_section_warning'] = ""
g['airline_section_z'] = "%p%%"

-- Fugitive remap
map('n', '<SPACE>gl', ':Git! log --decorate --oneline --graph --all<CR>')
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
