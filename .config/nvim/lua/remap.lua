-- global variables
local g = vim.g

local map = require("utils").map
local has = vim.fn.has

-- variables to modify netrw
g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_winsize = 25

-- ctrl+/ for commenting
if has("macunix") then
	map("n", "÷", "<Plug>NERDCommenterToggle", { noremap = false })
	map("v", "÷", "<Plug>NERDCommenterToggle<CR>gv", { noremap = false })
	map("i", "÷", "<C-c><Plug>NERDCommenterToggle", { noremap = false })
elseif has("win64") then
	map("n", "<C-_>", "<Plug>NERDCommenterToggle", { noremap = false })
	map("v", "<C-_>", "<Plug>NERDCommenterToggle<CR>gv", { noremap = false })
	map("i", "<C-_>", "<C-c><Plug>NERDCommenterToggle", { noremap = false })
end

-- Remaping space to ctrl+w in normal mode
map("n", "<SPACE>", "<C-w>", { noremap = false })

-- remapping < > and - + for resizing splits
map("n", "<lt>", "<C-W><lt>")
map("n", ">", "<C-W>>")
map("n", "-", "<C-W>-")
map("n", "=", "<C-W>+")

-- Remapping alt+h/j/k/l to move around in splits
if has("macunix") then
	map("t", "˙", "<C-\\><C-N><C-w>h")
	map("t", "∆", "<C-\\><C-N><C-w>j")
	map("t", "˚", "<C-\\><C-N><C-w>k")
	map("t", "¬", "<C-\\><C-N><C-w>l")
	map("i", "˙", "<C-\\><C-N><C-w>h")
	map("i", "∆", "<C-\\><C-N><C-w>j")
	map("i", "˚", "<C-\\><C-N><C-w>k")
	map("i", "¬", "<C-\\><C-N><C-w>l")
	map("n", "˙", "<C-w>h")
	map("n", "∆", "<C-w>j")
	map("n", "˚", "<C-w>k")
	map("n", "¬", "<C-w>l")
elseif has("win64") then
	map("tnoremap", "<A-h>", "<C-\\><C-N><C-w>h")
	map("tnoremap", "<A-j>", "<C-\\><C-N><C-w>j")
	map("tnoremap", "<A-k>", "<C-\\><C-N><C-w>k")
	map("tnoremap", "<A-l>", "<C-\\><C-N><C-w>l")
	map("inoremap", "<A-h>", "<C-\\><C-N><C-w>h")
	map("inoremap", "<A-j>", "<C-\\><C-N><C-w>j")
	map("inoremap", "<A-k>", "<C-\\><C-N><C-w>k")
	map("inoremap", "<A-l>", "<C-\\><C-N><C-w>l")
	map("nnoremap", "<A-h>", "<C-w>h")
	map("nnoremap", "<A-j>", "<C-w>j")
	map("nnoremap", "<A-k>", "<C-w>k")
	map("nnoremap", "<A-l>", "<C-w>l")
end

-- make Y behave like other D/C
map("n", "Y", "y$")

-- map G to move to end of the file instead of end line of file
map("n", "G", "G$")

-- map gg to move begining of file instead of begining line of file
map("n", "gg", "gg^")

-- Undo break points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

-- Fugitive remap
map("n", "<SPACE>gl", ":Git! log --decorate --oneline --graph --all<CR>")
map("n", "<SPACE>gs", ":G<CR>")

-- Telescope
-- Ctrl-p for searching for files
map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>")
-- Space and p for searching for files without ignore hidden files
map("n", "<SPACE>p", "<cmd>lua require('telescope.builtin').find_files({hidden= true})<cr>")
-- Ctrl-g for live grep
map("n", "<C-g>", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
-- Space and t for all pickers in telescope
map("n", "<SPACE>t", "<cmd>lua require('telescope.builtin').builtin()<cr>")
-- Space and h for seaching through help
map("n", "<SPACE>h", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
