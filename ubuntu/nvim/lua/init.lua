-- Mason lsp installer
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "sumneko_lua", "csharp_ls", "netcoredbg", "vimls", "jsonls"
    }
})

-- lsp-signature
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"}
}
local has_words_before = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    return (vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true)[1] or
               ''):sub(cursor[2], cursor[2]):match('%s')
end

local function handle_cmp_tab(cmp, direction)
    return function(fallback)
        print(direction)
        if cmp.visible() then
            if direction == 1 then
                cmp.select_next_item()
            elseif direction == -1 then
                cmp.select_prev_item()
            end
        elseif require("luasnip").expandable() then
            require("luasnip").expand()
        elseif require("luasnip").jumpable(direction) then
            require("luasnip").jump(direction)
        elseif direction == 1 and has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end
end

local handle_tab_parameters = {"i", "s"}

local cmp = require("cmp")
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users. 
        end
    },
    mapping = {
        ["<CR>"] = cmp.mapping.confirm({select = true}),
        ['<C-K>'] = cmp.mapping.scroll_docs(-4),
        ['<C-J>'] = cmp.mapping.scroll_docs(4),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping(handle_cmp_tab(cmp, 1), handle_tab_parameters),
        ["<S-Tab>"] = cmp.mapping(handle_cmp_tab(cmp, -1), handle_tab_parameters)

    },
    sources = {
        {name = "nvim_lsp"}, {name = 'luasnip'}, {name = 'buffer'},
        {name = 'path'}
    },
    completion = {completeopt = "menu,menuone,noinsert"},
    experimental = {ghost_text = true}
})

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
    require"lsp_signature".on_attach(signature_config, bufnr) -- Note: add in lsp client on-attach
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', '<Leader>gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                   bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>f', '', {
        callback = vim.lsp.buf.formatting,
        noremap = true,
        silent = true,
        desc = 'Format File'
    })
end;

local lsp_setup = {capabilities = capabilities, on_attach = lsp_on_attatch}

local lsp_setup_lua = {
    capabilities = capabilities,
    on_attach = lsp_on_attatch,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                -- Fixes the 'global vim is undefined' error
                globals = {'vim'}
            }
        }
    }
}

local tree_sitter_config = {
    -- ensure_installed = "maintained",
    highlight = { enable = true },
    indent = { enable = true },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    }
}

-- lsp servers
require("lspconfig").vimls.setup(lsp_setup)
require("lspconfig").vimls.setup(lsp_setup)
-- require("lspconfig").csharp_ls.setup(lsp_setup)
require("lspconfig").sumneko_lua.setup(lsp_setup_lua)
require("lspconfig").omnisharp.setup(lsp_setup_lua)

-- Tree sitter config
require("nvim-treesitter.configs").setup(tree_sitter_config)

-- Which key
require('which-key').setup()

-- Autopairs
require("nvim-autopairs").setup()
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = {noremap = true, silent = true}
vim.keymap.set('n', '<C-.>', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<C-p>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C-n>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Theme
vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({transparent_background = true})
vim.cmd [[colorscheme catppuccin]]
