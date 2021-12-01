
"Remaping space to ctrl+w in normal mode
nmap <SPACE> <C-w>


"Remapping < > and - + for resizing splits 
nnoremap <lt> <C-W><lt>
nnoremap > <C-W>>
nnoremap - <C-W>-
nnoremap + <C-W>+

"Remapping alt+h/j/k/l to move around in splits

:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

if has("macunix")
	:tnoremap ˙ <C-\><C-N><C-w>h
	:tnoremap ∆ <C-\><C-N><C-w>j
	:tnoremap ˚ <C-\><C-N><C-w>k
	:tnoremap ¬ <C-\><C-N><C-w>l
	:inoremap ˙ <C-\><C-N><C-w>h
	:inoremap ∆ <C-\><C-N><C-w>j
	:inoremap ˚ <C-\><C-N><C-w>k
	:inoremap ¬ <C-\><C-N><C-w>l
	:nnoremap ˙ <C-w>h
	:nnoremap ∆ <C-w>j
	:nnoremap ˚ <C-w>k
	:nnoremap ¬ <C-w>l
endif



" Show marks
nnoremap <silent> <SPACE>m :marks<CR>

" Fugitive remap
nnoremap <silent> <SPACE>gl  :Git! log --decorate --oneline --graph --all<CR>
nnoremap <SPACE>gs :G<CR>


" make Y behave like other D/C
nnoremap Y y$

" map G to move to end of the file instead of end line of file
nnoremap G G$

" map gg to move begining of file instead of begining line of file
nnoremap gg gg^


if has("win64")
	let s:clip = '/mnt/c/Windows/System32/clip.exe'
	if executable(s:clip)
		augroup WSLYank
			autocmd!
			autocmd TextYankPost * call system(s:clip, @0)
		augroup END
	endif
endif

"Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u


