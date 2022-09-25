local Module = {}
local function load_plugins(use)
    use 'tpope/vim-commentary'
    use "fladson/vim-kitty"
    use 'Hoffs/omnisharp-extended-lsp.nvim'

    require('plugins/vim-config').setup()
    require('plugins/luadev-config').setup(use)
    require('plugins/lspkind-config').setup(use)
    require('lsp/lspconfig-config').setup(use)
    require('cmp/cmp-config').setup(use)
    require('cmp/cmpnvimlsp-config').setup(use)
    require('plugins/mason-config').setup(use)
    require('plugins/masonlspconfig-config').setup(use)
    require('plugins/masontoolinstaller-config').setup(use)
    require('plugins/autopairs-config').setup(use)
    require('plugins/signature-config').setup(use)
    require('plugins/treesitter-config').setup(use)
    require('plugins/catppuccin-config').setup(use)
    require('plugins/lualine-config').setup(use)
    require('plugins/gitsigns-config').setup(use)
    require('plugins/neotree-config').setup(use)
    require('plugins/telescope-config').setup(use)
end

Module.setup = function()
    require('plugins/packer-config').setup(load_plugins)
end
return Module
