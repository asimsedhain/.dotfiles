
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'wellle/context.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" colorscheme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'sonph/onehalf', {'rtp': 'vim'}
" Utility plugin that other plugin use
Plug 'nvim-lua/plenary.nvim'
" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}



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
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


lua require("init")
