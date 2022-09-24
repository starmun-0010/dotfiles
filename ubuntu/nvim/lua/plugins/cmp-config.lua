local Module = {}

local function cmp_config()
    local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local function handle_cmp_tab(cmp, direction)
        return function(fallback)
            if cmp.visible() then
                if direction == 1 then
                    cmp.select_next_item()
                elseif direction == -1 then
                    cmp.select_prev_item()
                end
            elseif require("luasnip").expandable() then
                require("luasnip").expand()
            elseif require("luasnip").jumpable(direction) then
                require("luasnip").jump(direction)
            elseif direction == 1 and has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end
    end

    local autopairs_config = function(cmp)
        local yo = require("nvim-autopairs")
        yo.setup()
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done",
            cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
        print(cmp_autopairs)
    end

    local handle_tab_parameters = { "i", "s" }

    local cmp = require("cmp");
    cmp.setup
    {
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end
        },
        mapping = {
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ['<C-K>'] = cmp.mapping.scroll_docs(-4),
            ['<C-J>'] = cmp.mapping.scroll_docs(4),
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<Tab>"] = cmp.mapping(handle_cmp_tab(cmp, 1), handle_tab_parameters),
            ["<S-Tab>"] = cmp.mapping(handle_cmp_tab(cmp, -1), handle_tab_parameters)

        },
        sources = {
            { name = "nvim_lsp" }, { name = 'luasnip' }, { name = 'buffer' },
            { name = 'path' }
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        experimental = { ghost_text = true }
    }
    autopairs_config(cmp)
end

Module.setup = function(use)
    use { 'hrsh7th/nvim-cmp',
        config = cmp_config,
        after = { 'nvim-autopairs', 'LuaSnip', 'cmp_luasnip' },
        requires = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'windwp/nvim-autopairs' },
            { "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" },
            { 'saadparwaiz1/cmp_luasnip' }
        }
    }
end
return Module
