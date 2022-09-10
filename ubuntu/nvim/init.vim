"mappings
imap jj <Esc>

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

"Snippet manager
Plug 'hrsh7th/vim-vsnip'
"Snippet hook into autocompletion
Plug 'hrsh7th/cmp-vsnip'

"Signature help from LSP and other sources
Plug 'ray-x/lsp_signature.nvim'

"Lua formatter
Plug 'andrejlevkovitch/vim-lua-format'

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
