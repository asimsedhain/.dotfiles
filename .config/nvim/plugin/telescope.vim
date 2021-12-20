" Using Lua functions
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-g> <cmd>lua require('telescope.builtin').live_grep()<cr>
command! -nargs=0 Grep lua require('telescope.builtin').live_grep()
command! -nargs=0 Buffers lua require('telescope.builtin').buffers()
