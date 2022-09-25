local Module = {}
Module.setup = function(use)
    use {
        'hrsh7th/cmp-nvim-lsp'
    }
end

Module.update_capabilities = function(capabilities)
    return require('cmp_nvim_lsp').update_capabilities(capabilities)
end
return Module
