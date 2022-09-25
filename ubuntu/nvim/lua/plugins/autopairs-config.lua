local Module = {}

Module.setup = function(use)
    local function autopairs_config()
        require("nvim-autopairs").setup()
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        package.loaded.cmp.event:on("confirm_done",
            cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    end

    use {
        'windwp/nvim-autopairs',
        requires = { { 'hrsh7th/nvim-cmp' } },
        after = { 'nvim-cmp' },
        config = autopairs_config
    }
end
return Module
