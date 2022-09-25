local Module = {}
local common_lsp_config = require('lsp/lspconfig-config')
Module.setup = function()
    require("lspconfig").vimls.setup(common_lsp_config)
end
return Module
