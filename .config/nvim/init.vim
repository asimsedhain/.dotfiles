
" TextEdit might fail if hidden is not set.
set hidden
"
"  Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
"
"  " Give more space for displaying messages.
set cmdheight=2
"
"  Having longer updatetime (default is 4000 ms = 4 s leads to noticeable
") delays and poor user experience.
set updatetime=50
"
"" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
"  diagnostics appear/become resolved.
if has("patch-8.1.1564")
"Recently vim can merge signcolumn and number column into one
	set signcolumn=number
else
	set signcolumn=yes
endif


call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax"
Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'imkmf/ctrlp-branches'

call plug#end()

"gurvbox theme setting
let g:gruvbox_contrast_light = "hard"
let g:gruvbox_contrast_dark = "hard"
set bg=dark
"set bg=light

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[38;2;%lu;%lu;%lum"
endif


colorscheme gruvbox


" coc config
let g:coc_global_extensions = [
  \	'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-pyright',
  \ 'coc-python',
  \ 'coc-go',
  \ 'coc-yaml'
  \ ]

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}



" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_extensions = ['branches']
let g:ctrlp_working_path_mode = 'ra'

" ctrl+/ for commenting
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
imap <C-_>  <C-c><Plug>NERDCommenterToggle



" Native settings
set nocompatible
filetype off                 


set spelllang=en
set tabstop=4 
set softtabstop=4
set shiftwidth=4 
set scrolloff=12
filetype indent on
set number
set ignorecase
set smartcase
set noswapfile
set incsearch
set noexpandtab
"set autoindent


" Tweaks for file tree
let g:netrw_banner = 0      " remove the banner at top
let g:netrw_altv=3          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_winsize = 25
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'


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


" Show register
nnoremap <silent> <SPACE>r :registers<CR>
" Show buffers
nnoremap <silent> <SPACE>b :buffers<CR>
" Show marks
nnoremap <silent> <SPACE>m :marks<CR>

" Fugitive remap
nnoremap <silent> <SPACE>gl  :Git! log --decorate --oneline --graph --all<CR>
nnoremap <SPACE>gs :G<CR>


nnoremap Y y$



"Copy and Pasting to clipboard
"Copies into the clipboard with everyyank
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
	augroup WSLYank
		autocmd!
		autocmd TextYankPost * call system(s:clip, @0)
	augroup END
endif

"Paste from the clipboard with =p works only in normal mode
"Breaks nvim, uncomment at your own risk
"
"nnoremap <silent> =p :r !powershell.exe -Command Get-Clipboard<CR>
"let s:clip = 'powershell.exe Get-Clipboard'
"nnoremap <silent> =p call echo(system(s:clip))
"nnoremap =p :exe 'norm a'.system('/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard')<CR>


" Formating commands
command Gofmt w <bar> silent exec "!go fmt %" <bar> e
command Black w <bar> silent exec "!black %" <bar> e
command Cfmt normal gg=G<C-o>


