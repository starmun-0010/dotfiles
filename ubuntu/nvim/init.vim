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

"
Plug 'Hoffs/omnisharp-extended-lsp.nvim' 

"Signature help from LSP and other sources
Plug 'ray-x/lsp_signature.nvim'

"Easymotion
Plug 'justinmk/vim-sneak'


"Helps see defined keymaps
Plug 'folke/which-key.nvim'

"Syntax highlighting for kitty configuraiton
Plug 'fladson/vim-kitty'

"Theme

call plug#end()

"Source lua configurations
lua require('init')


"Sneak hints
let g:sneak#label = 1

"mappings
imap jj <Esc>

"Autosave on change to Normal mode
inoremap <Esc> <Esc>:w<CR>

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
