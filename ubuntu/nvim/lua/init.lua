require("plugins/plugins-init").setup()

vim.cmd([[
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'cd '.argv()[0] | wincmd l | endif
]])
-- Mason lsp installer
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "sumneko_lua", "csharp_ls", "netcoredbg", "vimls", "jsonls", "omnisharp"
    }
}) -- lsp-signature
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation", "detail", "additionalTextEdits", "inlayHints"
    }
}

--Lsp extension commands
vim.lsp.commands['omnisharp/client/findReferences'] = vim.lsp.buf.references


local signature_config = {
    bind = true,
    wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    -- will set to true when fully tested, set to false will use whichever side has more space
    -- this setting will be helpful if you do not want the PUM and floating win overlap

    floating_window_off_x = 1, -- adjust float windows x position.
    floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
    transparency = 80, -- disabled by default, allow floating win transparent value 1~100
    select_signature_key = '<M-n>' -- cycle to next signature, e.g. '<M-n>' function overloading
}

local lsp_on_attatch = function(_, bufnr)
    require "lsp_signature".on_attach(signature_config, bufnr) -- Note: add in lsp client on-attach
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true }

    bufopts.desc = 'Go to Declaration'
    bufopts.callback = vim.lsp.buf.declaration
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>gD', '', bufopts)

    bufopts.desc = 'Go to Definition'
    bufopts.callback = vim.lsp.buf.definition
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>gd', '', bufopts)

    bufopts.desc = 'Hover'
    bufopts.callback = vim.lsp.buf.hover
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>h', '', bufopts)

    bufopts.desc = 'Go to Implementation'
    bufopts.callback = vim.lsp.buf.implementation
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>gi', '', bufopts)

    bufopts.desc = 'Signature Help'
    bufopts.callback = vim.lsp.buf.signature_help
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>sh', '', bufopts)

    bufopts.desc = 'Add Workspace Folder'
    bufopts.callback = vim.lsp.buf.add_workspace_folder
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>awf', '', bufopts)

    bufopts.desc = 'Remove Workspace Folder'
    bufopts.callback = vim.lsp.buf.remove_workspace_folder
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rwf', '', bufopts)

    bufopts.desc = 'List Workspace Folders'
    bufopts.callback = function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lwf', '', bufopts)

    bufopts.desc = 'Type Definition'
    bufopts.callback = vim.lsp.buf.type_definition
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>td', '', bufopts)

    bufopts.desc = 'Rename'
    bufopts.callback = vim.lsp.buf.rename
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>r', '', bufopts)

    bufopts.desc = 'Code Action'
    bufopts.callback = vim.lsp.buf.code_action
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca', '', bufopts)

    bufopts.desc = 'Go to References'
    bufopts.callback = vim.lsp.buf.references
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>gr', '', bufopts)

    bufopts.desc = 'Format File'
    bufopts.callback = vim.lsp.buf.formatting
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>f', '', bufopts)
end;

local lsp_setup = { capabilities = capabilities, on_attach = lsp_on_attatch }

local lsp_setup_lua = {
    capabilities = capabilities,
    on_attach = lsp_on_attatch,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                -- Fixes the 'global vim is undefined' error
                globals = { 'vim' }
            },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT"
            }
        }
    }
}

local lsp_setup_csharp = {
    capabilities = capabilities,
    on_attach = lsp_on_attatch,
    omnisharp = { enableDecompilationSupport = true }
}

}

-- lsp servers
require("lspconfig").vimls.setup(lsp_setup)
require("lspconfig").vimls.setup(lsp_setup)
-- require("lspconfig").csharp_ls.setup(lsp_setup)
require("lspconfig").sumneko_lua.setup(lsp_setup_lua)
require("lspconfig").omnisharp.setup(lsp_setup_csharp)

-- Tree sitter config

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

