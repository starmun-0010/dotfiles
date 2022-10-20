local Module = {}

local function dap_config()
   require('dap/dotnet-dap-config').setup()
end
Module.setup = function(use)
    use {
        'mfussenegger/nvim-dap',
        config = dap_config,
        after='mason.nvim'
    }
end
return Module

