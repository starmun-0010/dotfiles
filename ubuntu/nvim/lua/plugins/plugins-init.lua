local Module = {}

local packer_config = require('plugins/packer-config')
local packer = require('packer')

Module.setup = function()
    return packer.startup(function(use)
        use 'wbthomason/packer.nvim'
        use 'tpope/vim-commentary'
        use "fladson/vim-kitty"

        require('plugins/cmp-config').setup(use)
        require('plugins/treesitter-config').setup(use)
        require('plugins/catppuccin-config').setup(use)
        require('plugins/lualine-config').setup(use)
        require('plugins/gitsigns-config').setup(use)
        require('plugins/neotree-config').setup(use)
        require('plugins/telescope-config').setup(use)
        packer_config.post_init(packer)
    end, packer_config.packer_config)
end
return Module
