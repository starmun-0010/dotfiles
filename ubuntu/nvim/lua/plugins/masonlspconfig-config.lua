local Module = {}

local function mason_lspconfig_config()
    require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
            "sumneko_lua", "angularls", "csharp_ls", "netcoredbg", "vimls", "jsonls", "omnisharp",
            "dockerls", "clangd", "sqlls", "tsserver", "marksman", "yamlls", "cssls",
            "rust_analyzer", "lemminx", "html", "jsonls", "pyright", "cmakels"
        }
    })
end

Module.setup = function(use)

    use {
        'williamboman/mason-lspconfig.nvim',
        config = mason_lspconfig_config
    }
end

return Module
