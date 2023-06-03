call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'wellle/context.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" colorscheme
Plug 'sonph/onehalf', {'rtp': 'vim'}
Plug 'EdenEast/nightfox.nvim', { 'tag': 'v1.0.0' }
Plug 'olimorris/onedarkpro.nvim'
Plug 'rebelot/kanagawa.nvim'

" Utility plugin that other plugin use
Plug 'nvim-lua/plenary.nvim'
" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'

" pairs completer
Plug 'windwp/nvim-autopairs'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" LSP manager
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
" LSP completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

call plug#end()

lua require("init")
