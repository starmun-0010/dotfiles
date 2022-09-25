local Module = {}
local packer_config = require('plugins/packer-config')
local packer = require('packer')
local function load_plugins(use)
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-commentary'
    use "fladson/vim-kitty"
    use 'Hoffs/omnisharp-extended-lsp.nvim'
    use 'justinmk/vim-sneak'

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
    packer_config.post_init(packer)
end

Module.setup = function()
    return packer.startup({ load_plugins, packer_config.packer_config })
end
return Module
