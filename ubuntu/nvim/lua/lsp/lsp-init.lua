local Module = {}
Module.setup = function()
    require("lsp/vimls-lsp-config").setup()
    require("lsp/lua-lsp-config").setup()
    require("lsp/omnishar-lsp-config").setup()
end
return Module
