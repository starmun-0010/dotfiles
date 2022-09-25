local Module = {}

Module.get_format = function()
    local lspkind = require('lspkind')
    local kind_icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = ""
    }
    return {
        format = function(entry, vim_item)
            -- Kind icons

            -- This concatonates the icons with the name of the item kind
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            -- Source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
            })[entry.source.name]
            return vim_item
        end
    }
end
Module.setup = function(use)
    use {
        'onsails/lspkind.nvim'
    }
end
return Module
