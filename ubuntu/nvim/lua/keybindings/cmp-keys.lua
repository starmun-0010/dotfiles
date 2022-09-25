local Module = {}
Module.get_keymap = function()

    local cmp = package.loaded.cmp
    local handle_cmp_tab = require('cmp/cmp-helpers').handle_cmp_tab
    local handle_tab_parameters = { "i", "s" }
    return {
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ['<C-K>'] = cmp.mapping.scroll_docs(-4),
        ['<C-J>'] = cmp.mapping.scroll_docs(4),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping(handle_cmp_tab(cmp, 1), handle_tab_parameters),
        ["<S-Tab>"] = cmp.mapping(handle_cmp_tab(cmp, -1), handle_tab_parameters)
    }
end
return Module
