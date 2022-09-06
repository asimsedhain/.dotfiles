
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

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


lua require("init")
