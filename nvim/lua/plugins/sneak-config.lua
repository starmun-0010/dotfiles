local Module = {}
local function sneak_config()
    vim.g['sneak#label'] = 1
end

Module.setup = function(use)
    use {
        'justinmk/vim-sneak',
        config = sneak_config
    }
end
return Module
