local Module = {}

local function catppuccin_config()
    vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
    require("catppuccin").setup({
        transparent_background = true,
        integrations = {
            aerial = false,
            barbar = false,
            beacon = false,
            cmp = true,
            coc_nvim = false,
            dashboard = true,
            fern = false,
            fidget = false,
            gitgutter = false,
            gitsigns = true,
            hop = false,
            illuminate = false,
            leap = false,
            lightspeed = false,
            lsp_saga = false,
            lsp_trouble = false,
            markdown = false,
            mini = false,
            neogit = false,
            notify = false,
            nvimtree = false,
            overseer = false,
            pounce = false,
            symbols_outline = false,
            telekasten = false,
            telescope = true,
            treesitter = true,
            treesitter_context = true,
            ts_rainbow = true,
            vim_sneak = true,
            vimwiki = false,
            which_key = true,

            -- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
            dap = {
                enabled = true,
                enable_ui = true,
            },
            indent_blankline = {
                enabled = true,
                colored_indent_levels = true,
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
            navic = {
                enabled = false,
                custom_bg = "NONE",
            },
            neotree = {
                enabled = true,
                show_root = true,
                transparent_panel = true,
            },
        },
    })
    vim.cmd [[
        colorscheme catppuccin
   
        "Transparency
        highlight LineNr ctermbg=none
        highlight Normal ctermbg=none
        highlight NonText ctermbg=none
        highlight SignColumn ctermbg=none
        highlight VertSplit ctermbg=none ctermfg=98 cterm=none

        "Horizontal limit hint
        set colorcolumn=120
        highlight ColorColumn ctermbg=238

        "End of buffer symbol color
        hi EndOfBuffer ctermfg=DarkGray
    ]]
end

Module.setup = function(use)
    use {
        'catppuccin/nvim',
        as = 'catppuccin',
        config = catppuccin_config
    }
end
return Module
