" install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

imap jj <Esc>

call plug#begin()
Plug 'fladson/vim-kitty'
Plug 'neovim/nvim-lspconfig'
call plug#end()
lua require'lspconfig'.csharp_ls.setup{} 
