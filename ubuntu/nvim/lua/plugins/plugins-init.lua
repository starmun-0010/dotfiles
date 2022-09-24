local Module = {}

local packer_config = require('plugins/packer-config')
local packer = require('packer')

Module.setup = function()
    return packer.startup(function(use)
        use 'wbthomason/packer.nvim'
        use 'tpope/vim-commentary'
        packer_config.post_init(packer)
    end, packer_config.packer_config)
end
return Module
