local Module = {}
Module.configure = function()
    require("lua-dev").setup({
        -- add any options here, or leave empty to use the default settings
        -- return require('lua-dev').setup({
        --     library = {
        --         enabled = true, -- when not enabled, lua-dev will not change any settings to the LSP server
        --         -- these settings will be used for your Neovim config directory
        --         runtime = true, -- runtime path
        --         types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        --         plugins = true, -- installed opt or start plugins in packpath
        --         -- you can also specify the list of plugins to make available as a workspace library
        --         -- plugins = { nvim-treesitter, plenary.nvim, telescope.nvim },
        --     },
        --     setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
        --     -- for your Neovim config directory, the config.library settings will be used as is
        --     -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
        --     -- for any other directory, config.library.enabled will be set to false
        --     override = function(root_dir, options) end,
        override = function(_, library)
            library.enabled = true
            library.plugins = true
            library.runtime = true
            library.types = true -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
            library.setup_jsonls = true -- configures jsonls to provide completion for project specific .luarc.json files
        end,
    })
end

Module.setup = function(use)
    use {
        "folke/lua-dev.nvim",
        requires = { { 'neovim/nvim-lspconfig' } },
    }
end

return Module
