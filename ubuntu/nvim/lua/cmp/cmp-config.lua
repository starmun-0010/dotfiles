local Module = {}

Module.setup = function(use)
    local function cmp_config()
        local format = require('plugins/lspkind-config').get_format()
        require("cmp").setup {
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end
            },
            mapping = require('keybindings/cmp-keys').get_keymap(),
            sources = {
                { name = 'buffer' },
                { name = 'path' },
                { name = 'LuaSnip' },
                { name = "nvim_lsp" },
                { name = "nvim_lua" }
            },
            completion = { completeopt = "menu,menuone,noinsert" },
            experimental = { ghost_text = true },
            formatting= format
        }
    end

    use { 'hrsh7th/nvim-cmp',
        config = cmp_config,
        after = { 'LuaSnip', 'cmp_luasnip' },
        requires = {
            { "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" },
            { 'saadparwaiz1/cmp_luasnip' }
        }
    }
end
return Module
