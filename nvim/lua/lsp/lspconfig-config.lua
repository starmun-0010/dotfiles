local Module = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp/cmpnvimlsp-config').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation", "detail", "additionalTextEdits", "inlayHints"
    }
}

Module.on_attach = function(_, bufnr)
    require("plugins/signature-config").on_attach(bufnr)
    require("keybindings/lsp-keys").setup(bufnr)
end
local function lspconfig_config()
require("lsp/vimls-lsp-config").setup()
    require("lsp/lua-lsp-config").setup()
    require("lsp/omnishar-lsp-config").setup()
end
Module.capabilities = capabilities

Module.setup = function(use)
    use {
        'neovim/nvim-lspconfig',
        after='mason-lspconfig.nvim',
        config = lspconfig_config
    }
end
return Module
