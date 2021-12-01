
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

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'cdelledonne/vim-cmake'
" colorscheme
Plug 'NLKNguyen/papercolor-theme'
Plug 'gruvbox-community/gruvbox'
Plug 'sonph/onehalf', {'rtp': 'vim'}

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
" completing pairs
Plug 'cohama/lexima.vim'
" Utility plugin that other plugin use
Plug 'nvim-lua/plenary.nvim'
" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
" Syntax analyzer
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" highlights variables
Plug 'RRethy/vim-illuminate'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'


call plug#end()

" vim cmake
let g:cmake_link_compile_commands = 1


