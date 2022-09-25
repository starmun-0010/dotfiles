local Module = {}

local function mason_config()
    require("mason").setup()
end

Module.setup = function(use)
    use {
        'williamboman/mason.nvim',
        requires = {
            { 'williamboman/mason-lspconfig.nvim' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' }
        },
        config = mason_config
    }
end
return Module
