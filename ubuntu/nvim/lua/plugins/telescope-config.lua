local Module = {}

local function telescope_config()
    -- You dont need to set any of these options. These are the default ones. Only
    -- the fzf loading is important
    local telescope = require('telescope')
    telescope.setup {
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        }
    };
    -- To get fzf loaded and working with telescope, you need to call
    telescope.load_extension('fzf')
    telescope.load_extension "file_browser"
    --Keybindings
    require('keybindings/telescope-keys').setup()
end

Module.setup = function(use)
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        -- or                            , tag = '0.1.0',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'kyazdani42/nvim-web-devicons' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            { 'nvim-telescope/telescope-file-browser.nvim' }
        }, config = telescope_config
    }
end
return Module
