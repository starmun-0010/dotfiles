local Module = {}
local function whichkey_config()
    require('which-key').setup()
end

Module.setup = function(use)
    use {
        'folke/which-key.nvim',
        config = whichkey_config
    }
end
return Module
