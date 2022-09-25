local Module = {}
local function mason_tools_config()
    require('mason-tool-installer').setup {
        -- a list of all tools you want to ensure are installed upon
        -- start; they should be the names Mason uses for each tool
        ensure_installed = {
            'bash-language-server',
            'shellcheck',
            'luacheck',
            'netcoredbg',
            'firefox-debug-adapter'
        },
    }
end

Module.setup = function(use)
    use
    { 'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = mason_tools_config }
end
return Module
