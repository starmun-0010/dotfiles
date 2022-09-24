local Module = {}
local function treesitter_config()
    -- if not (packer_plugins["vim-fugitive"] and packer_plugins["nvim-treesitter"].loaded) then
    --     return
    -- end
    require("nvim-treesitter.configs").setup(
        {
            auto_install = true,
            ensure_installed = { "bash", "cpp", "c_sharp", "cmake", "css", "commonlisp",
                "dockerfile", "fish", "glsl", "hlsl", "html", "http", "java", "javascript",
                "json", "json5", "markdown", "make", "markdown_inline", "org", "python",
                "rasi", "regex", "scss", "sql", "toml", "typescript", "vim", "yaml", },
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = { enable = true },
            playground = {
                enable = true,
                disable = {},
                updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false -- Whether the query persists across vim sessions
            },
            rainbow = {
                enable = true,
                -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil, -- Do not enable for files with more than n lines, int
                -- colors = {}, -- table of hex strings
                -- termcolors = {} -- table of colour name strings
            }
        })
end

Module.setup = function(use)
    use {
        'nvim-treesitter/nvim-treesitter',
        run = 'TSUpdate',
        requires = { { 'p00f/nvim-ts-rainbow' } },
        config = treesitter_config
    }
end
return Module
