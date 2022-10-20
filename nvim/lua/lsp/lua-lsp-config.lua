local Module = {}
local common_lsp_config = require('lsp/lspconfig-config')

local lua_lsp_config = {
    --require('plugins/luadev-config').luadev()
    capabilities = common_lsp_config.capabilities,
    on_attach = common_lsp_config.on_attach,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            completion = { enable = true, callSnippet = "Both" },
            diagnostics = {
                enable = true,
                globals = {
                    'vim', 'describe', 'awesome', 'root',
                    'client', 'screen'
                },
            },
        }
    }
}

Module.setup = function()
    -- IMPORTANT: make sure to setup lua-dev BEFORE lspconfig
    require('plugins/luadev-config').configure()
    require('lspconfig').sumneko_lua.setup(lua_lsp_config)
end
return Module
