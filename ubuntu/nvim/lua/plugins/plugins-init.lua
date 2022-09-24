local Module = {}

local packer_config = require('plugins/packer-config')
local packer = require('packer')

Module.setup = function()
    return packer.startup(function(use)
        packer_config.post_init(packer)
    end, packer_config.packer_config)
end
return Module
