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

local cmp = require("cmp")
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end
    },
    mapping = {
        ["<CR>"] = cmp.mapping.confirm({select = true}),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-e>"] = cmp.mapping.close()
    },
    sources = {{name = "nvim_lsp"}, {name = 'vsnip'}},
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

-- lsp servers
require("lspconfig").vimls.setup(lsp_setup)
require("lspconfig").vimls.setup(lsp_setup)
-- require("lspconfig").csharp_ls.setup(lsp_setup)
require("lspconfig").sumneko_lua.setup(lsp_setup_lua)
require("lspconfig").omnisharp.setup(lsp_setup_lua)

-- Theme
vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({transparent_background = true})
vim.cmd [[colorscheme catppuccin]]
