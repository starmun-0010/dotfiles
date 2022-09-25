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
