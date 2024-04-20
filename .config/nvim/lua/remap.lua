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
	map("n", "÷", "<Plug>NERDCommenterToggle", { noremap = false, desc = "Option + / to toggle line comment" })
	map("v", "÷", "<Plug>NERDCommenterToggle<CR>gv", { noremap = false, desc = "Option + / to toggle line comment" })
	map("i", "÷", "<C-c><Plug>NERDCommenterToggle", { noremap = false, desc = "Option + / to toggle line comment" })
elseif has("win64") then
	map("n", "<C-_>", "<Plug>NERDCommenterToggle", { noremap = false, desc = "Toggle line comment" })
	map("v", "<C-_>", "<Plug>NERDCommenterToggle<CR>gv", { noremap = false, desc = "Toggle line comment" })
	map("i", "<C-_>", "<C-c><Plug>NERDCommenterToggle", { noremap = false, desc = "Toggle line comment" })
end

-- Remaping space to ctrl+w in normal mode
map("n", "<SPACE>", "<C-w>", { noremap = false, desc = "Remap Leader to Space" })

-- remapping < > and - + for resizing splits
map("n", "<lt>", "<C-W><lt>", { desc = "< to resize split" })
map("n", ">", "<C-W>>", { desc = "> to resize split" })
map("n", "-", "<C-W>-", { desc = "- to resize split" })
map("n", "=", "<C-W>+", { desc = "+ to resize split" })

-- Remapping alt+h/j/k/l to move around in splits
if has("macunix") then
	map("t", "˙", "<C-\\><C-N><C-w>h", { desc = "Option-h/j/k/l to move around to another pane" })
	map("t", "∆", "<C-\\><C-N><C-w>j", { desc = "Option-h/j/k/l to move around to another pane" })
	map("t", "˚", "<C-\\><C-N><C-w>k", { desc = "Option-h/j/k/l to move around to another pane" })
	map("t", "¬", "<C-\\><C-N><C-w>l", { desc = "Option-h/j/k/l to move around to another pane" })
	map("i", "˙", "<C-\\><C-N><C-w>h", { desc = "Option-h/j/k/l to move around to another pane" })
	map("i", "∆", "<C-\\><C-N><C-w>j", { desc = "Option-h/j/k/l to move around to another pane" })
	map("i", "˚", "<C-\\><C-N><C-w>k", { desc = "Option-h/j/k/l to move around to another pane" })
	map("i", "¬", "<C-\\><C-N><C-w>l", { desc = "Option-h/j/k/l to move around to another pane" })
	map("n", "˙", "<C-w>h", { desc = "Option-h/j/k/l to move around to another pane" })
	map("n", "∆", "<C-w>j", { desc = "Option-h/j/k/l to move around to another pane" })
	map("n", "˚", "<C-w>k", { desc = "Option-h/j/k/l to move around to another pane" })
	map("n", "¬", "<C-w>l", { desc = "Option-h/j/k/l to move around to another pane" })
elseif has("win64") then
	map("tnoremap", "<A-h>", "<C-\\><C-N><C-w>h", { desc = "Alt-h/j/k/l to move around to another pane" })
	map("tnoremap", "<A-j>", "<C-\\><C-N><C-w>j", { desc = "Alt-h/j/k/l to move around to another pane" })
	map("tnoremap", "<A-k>", "<C-\\><C-N><C-w>k", { desc = "Alt-h/j/k/l to move around to another pane" })
	map("tnoremap", "<A-l>", "<C-\\><C-N><C-w>l", { desc = "Alt-h/j/k/l to move around to another pane" })
	map("inoremap", "<A-h>", "<C-\\><C-N><C-w>h", { desc = "Alt-h/j/k/l to move around to another pane" })
	map("inoremap", "<A-j>", "<C-\\><C-N><C-w>j", { desc = "Alt-h/j/k/l to move around to another pane" })
	map("inoremap", "<A-k>", "<C-\\><C-N><C-w>k", { desc = "Alt-h/j/k/l to move around to another pane" })
	map("inoremap", "<A-l>", "<C-\\><C-N><C-w>l", { desc = "Alt-h/j/k/l to move around to another pane" })
	map("nnoremap", "<A-h>", "<C-w>h", { desc = "Alt-h/j/k/l to move around to another pane" })
	map("nnoremap", "<A-j>", "<C-w>j", { desc = "Alt-h/j/k/l to move around to another pane" })
	map("nnoremap", "<A-k>", "<C-w>k", { desc = "Alt-h/j/k/l to move around to another pane" })
	map("nnoremap", "<A-l>", "<C-w>l", { desc = "Alt-h/j/k/l to move around to another pane" })
end

-- make Y behave like other D/C
map("n", "Y", "y$", { desc = "Make Y behave like other D/C" })

-- map G to move to end of the file instead of end line of file
map("n", "G", "G$", { desc = "Map G to move to end of the file instead of end line of file" })

-- map gg to move begining of file instead of begining line of file
map("n", "gg", "gg^", { desc = "Map gg to move begining of file instead of begining line of file" })

-- Undo break points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

-- Fugitive remap
map("n", "<SPACE>gl", ":Git! log --decorate --oneline --graph --all<CR>", { desc = "<Space>gl to show git log" })
map("n", "<SPACE>gs", ":G<CR>", { desc = "<Space>gs to show git status" })

-- Telescope
-- Ctrl-p for searching for files
map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>", { desc = "Ctrl-p for searching for files" })
-- <Space>-p for searching for files without ignore hidden files
map("n", "<SPACE>p", "<cmd>lua require('telescope.builtin').find_files({hidden= true})<cr>",
	{ desc = "<Space>-p for searching for files without ignore hidden files" })
-- Ctrl-g for live grep
map("n", "<C-g>", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { desc = "Ctrl-g for live grep" })
-- <Space>-t for all pickers in telescope
map("n", "<SPACE>t", "<cmd>lua require('telescope.builtin').builtin()<cr>",
	{ desc = "<Space>-t for all pickers in telescope" })
-- Space-h for seaching through help
map("n", "<SPACE>h", "<cmd>lua require('telescope.builtin').help_tags()<cr>", {
	desc =
	"<Space>-h for seaching through help"
})
