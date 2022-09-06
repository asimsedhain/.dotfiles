
" hello front end masters
set path+=**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*




call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax"
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'cdelledonne/vim-cmake'
" colorscheme
Plug 'NLKNguyen/papercolor-theme'
Plug 'gruvbox-community/gruvbox'
Plug 'sonph/onehalf', {'rtp': 'vim'}
" Utility plugin that other plugin use
Plug 'nvim-lua/plenary.nvim'
" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'

" Svelte
Plug 'evanleck/vim-svelte'

Plug 'wellle/context.vim'

call plug#end()

" vim cmake
let g:cmake_link_compile_commands = 1
let g:cmake_default_config = 'build'

" coc config
let g:coc_global_extensions = [
  \	'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-pyright',
  \ 'coc-go',
  \ 'coc-yaml',
  \ 'coc-svelte',
  \ 'coc-rust-analyzer',
  \ 'coc-lua'
  \ ]

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 Org :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}



" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Remap for rename current word
nmap <F2> <Plug>(coc-rename)


" Vim Airline
let g:airline_section_y=""
let g:airline_section_warning=""
let g:airline_section_z="%p%%"

lua require("init")
