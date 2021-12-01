" ctrl+/ for commenting
if has("macunix")
	nmap ÷  <Plug>NERDCommenterToggle
	vmap ÷  <Plug>NERDCommenterToggle<CR>gv
	imap ÷ <C-c><Plug>NERDCommenterToggle
endif

if has("win64")
	nmap <C-_>   <Plug>NERDCommenterToggle
	vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
	imap <C-_>  <C-c><Plug>NERDCommenterToggle
endif


