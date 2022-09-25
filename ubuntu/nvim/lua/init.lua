require("plugins/plugins-init").setup()
require("lsp.lsp-init").setup()

vim.cmd([[
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'cd '.argv()[0] | wincmd l | endif
]])
-- Mason lsp installer

--Lsp extension commands

-- Which key
require('which-key').setup()


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-.>', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<C-p>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C-n>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Theme

