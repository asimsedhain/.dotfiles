local map = require("utils").map
local has = vim.fn.has


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
