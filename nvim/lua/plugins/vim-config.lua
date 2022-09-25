local Module = {}
Module.setup = function()
    vim.opt.number = true
    vim.opt.relativenumber = true

    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true

    vim.opt.shell = '/usr/bin/fish'

    vim.opt.path:append('.,,**')

    vim.g.mapleader = vim.api.nvim_replace_termcodes("<Space>", true, true, true)
    vim.g.maplocalleader = ','

    --Set end of buffer key
    vim.opt.fillchars:append { eob = "𝇟" }

    vim.cmd([[
        
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'cd '.argv()[0] | wincmd l | endif
    ]])

    require('keybindings/vim-keys').setup()
end
return Module
