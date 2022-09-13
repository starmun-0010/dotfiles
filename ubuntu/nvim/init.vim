"General settings
set number
set relativenumber

"For recursive file search
set path=.,,**

set tabstop=4
set shiftwidth=4
set expandtab

"Set defalt terminal
set shell=/usr/bin/fish 

"install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugins
call plug#begin()

"LSP manager
Plug 'williamboman/mason.nvim'

"Helps assure LSP installation on startup
Plug 'williamboman/mason-lspconfig.nvim'

"Configuration hook for builtin LSP
Plug 'neovim/nvim-lspconfig'

"Autocompletion
Plug 'hrsh7th/nvim-cmp'

"LSP source for autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'

"For pairing brackets
Plug 'windwp/nvim-autopairs'

"Snippet manager
"Plug 'hrsh7th/vim-vsnip'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v<CurrentMajor>.*'}

"Snippet hook into autocompletion
"Plug 'hrsh7th/cmp-vsnip'
Plug 'saadparwaiz1/cmp_luasnip'

"Signature help from LSP and other sources
Plug 'ray-x/lsp_signature.nvim'

"Lua formatter
Plug 'andrejlevkovitch/vim-lua-format'

"Helps see defined keymaps
Plug 'folke/which-key.nvim'

"Syntax highlighting for kitty configuraiton
Plug 'fladson/vim-kitty'

"Theme
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

call plug#end()

"Source lua configurations
lua require('init')

"Autocommands
"Fomat Lua
autocmd FileType lua nnoremap <buffer> <c-k> :call LuaFormat()<cr>
autocmd BufWrite *.lua call LuaFormat()

"mappings
imap jj <Esc>
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
